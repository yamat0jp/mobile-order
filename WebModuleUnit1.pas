unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.PG, FireDAC.Phys.PGDef;

type
  TWebModule1 = class(TWebModule)
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    FDTable3: TFDTable;
    DataSource1: TDataSource;
    FDTable2: TFDTable;
    FDTable3category: TWideMemoField;
    FDTable3name: TWideMemoField;
    FDTable3comment: TWideMemoField;
    FDTable3price: TIntegerField;
    FDTable3qty: TIntegerField;
    FDTable3cnt: TIntegerField;
    FDTable3fileext: TWideMemoField;
    FDTable3image: TBlobField;
    FDTable1category: TWideMemoField;
    FDTable1name: TWideMemoField;
    FDTable1comment: TWideMemoField;
    FDTable1price: TIntegerField;
    FDTable1qty: TIntegerField;
    FDTable1cnt: TIntegerField;
    FDTable1fileext: TWideMemoField;
    FDTable1image: TBlobField;
    FDTable1id: TIntegerField;
    FDTable3id: TIntegerField;
    FDTable2tableid: TIntegerField;
    FDTable2orderid: TIntegerField;
    FDTable2id: TIntegerField;
    FDTable2qty: TIntegerField;
    FDTable2status: TIntegerField;
    FDTable2timedata: TWideMemoField;
    FDTable4: TFDTable;
    FDTable4id: TIntegerField;
    FDTable4tableid: TIntegerField;
    FDTable4ip: TWideMemoField;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem4Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem5Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem2Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem3Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { private 宣言 }
    function BlobImageString(DataSet: TDataSet): string;
  public
    { public 宣言 }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses System.JSON, System.IOUtils, System.NetEncoding, webData, Vcl.Graphics,
  info, System.Variants;

function TWebModule1.BlobImageString(DataSet: TDataSet): string;
var
  blob: TStream;
  bytes: TBytes;
begin
  blob := DataSet.CreateBlobStream(DataSet.FieldByName('image'), bmRead);
  try
    SetLength(bytes, blob.Size);
    blob.ReadBuffer(bytes, 0, blob.Size);
    Result := Format('data:image/%s;base64,',
      [DataSet.FieldByName('fileext').AsString]) +
      TNetEncoding.Base64.EncodeBytesToString(bytes);
  finally
    blob.Free;
  end;
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  JSON: TJSONObject;
  Data: TJSONArray;
  order: TOrderData;
  img: string;
begin
  FDTable1.Filter := 'category = ' +
    QuotedStr(Request.QueryFields.Values['category']);
  JSON := TJSONObject.Create;
  order := TOrderData.Create;
  try
    Data := TJSONArray.Create;
    FDTable1.First;
    while not FDTable1.Eof do
    begin
      img := BlobImageString(FDTable1);

      order.category := FDTable1.FieldByName('category').AsString;
      order.id := FDTable1.FieldByName('id').AsInteger;
      order.name := FDTable1.FieldByName('name').AsString;
      order.comment := FDTable1.FieldByName('comment').AsString;
      order.qty := FDTable1.FieldByName('qty').AsInteger;
      order.price := FDTable1.FieldByName('price').AsInteger;
      order.count := FDTable1.FieldByName('cnt').AsInteger;
      order.ImageBase64 := img;
      Data.Add(order.toJson);
      FDTable1.Next;
    end;
    if Data.count = 0 then
      Response.Content := '{}'
    else
    begin
      JSON.AddPair('items', Data);
      Response.ContentType := 'applicatrion/json; charset=utf-8';
      Response.Content := JSON.toJson;
    end;
  finally
    JSON.Free;
    order.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
  ip: string;
  id: integer;
  v: Variant;
begin
  s := Request.QueryFields.Values['table'];
  if s = '' then
  begin
    v := FDTable4.Lookup('ip', Request.RemoteIP, 'tableID');
    if not VarIsNull(v) then
      Response.Content := v;
  end
  else
  begin
    id := s.ToInteger;
    ip := Request.RemoteIP;
    if not FDTable4.Locate('ip', ip) then
      FDTable4.AppendRecord([nil, id, ip])
    else
    begin
      FDTable4.Edit;
      FDTable4.FieldByName('tableID').AsInteger := id;
      FDTable4.Post;
    end;
    Response.Content := s;
    Response.SendRedirect(myurl);
  end;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  order: TAdvanceData;
  JSON: TJSONObject;
  arr: TJSONArray;
begin
  if not FDTable4.Locate('ip', Request.RemoteIP) then
    Exit;
  FDTable2.Filter := 'status < 2 and tableID = ' + FDTable4.FieldByName
    ('tableID').AsString;
  JSON := TJSONObject.Create;
  order := TAdvanceData.Create;
  try
    arr := TJSONArray.Create;
    FDTable2.First;
    while not FDTable2.Eof do
    begin
      order.name := FDTable3.FieldByName('name').AsString;
      order.qty := FDTable2.FieldByName('qty').AsInteger;
      order.price := FDTable3.FieldByName('price').AsInteger;
      order.comment := FDTable3.FieldByName('comment').AsString;
      order.ImageBase64 := BlobImageString(FDTable3);
      order.time := FDTable2.FieldByName('timedata').AsString;
      arr.Add(order.toJson);
      FDTable2.Next;
    end;
    JSON.AddPair('items', arr);
    Response.ContentType := 'application/json; charset=utf-8';
    if arr.count = 0 then
      Response.Content := '{}'
    else
      Response.Content := JSON.toJson;
  finally
    JSON.Free;
    order.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem3Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content:='ok';
end;

procedure TWebModule1.WebModule1WebActionItem4Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  JSON: TJSONObject;
begin
  if not FDTable4.Locate('ip', Request.RemoteIP) then
    Exit;
  JSON := TJSONObject.ParseJSONValue(Request.Content) as TJSONObject;
  FDTable1.Filtered := false;
  try
    if FDTable1.Locate('id', JSON.GetValue<integer>('id')) then
    begin
      FDTable1.Edit;
      FDTable1.FieldByName('cnt').AsInteger := JSON.GetValue<integer>('count');
      FDTable1.Post;
      Response.Content := '注文しました';

      FDTable2.Append;
      FDTable2.FieldByName('id').AsInteger := FDTable1.FieldByName('id')
        .AsInteger;
      FDTable2.FieldByName('tableID').AsInteger :=
        FDTable4.FieldByName('tableID').AsInteger;
      FDTable2.FieldByName('qty').AsInteger := JSON.GetValue<integer>('qty');
      FDTable2.FieldByName('timedata').AsString :=
        FormatDateTime('hh:nn', GetTime);
      FDTable2.FieldByName('status').AsInteger := Ord(TOrderStatus.pending);
      FDTable2.Post;
    end
    else
      Response.Content := 'エラー： スタッフにお声がけください';
  finally
    JSON.Free;
    FDTable1.Filtered := true;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem5Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  JSON: TJSONObject;
  tableID: integer;
  i: integer;
begin
  if not FDTable4.Locate('ip', Request.RemoteIP) then
    Exit;
  tableID := FDTable2.FieldByName('tableID').AsInteger;
  JSON := TJSONObject.ParseJSONValue(Request.Content) as TJSONObject;
  try
    FDTable2.Filter := 'tableID = ' + tableID.ToString;
    FDTable2.First;
    while not FDTable2.Eof do
    begin
      FDTable2.Edit;
      i := FDTable2.FieldByName('status').AsInteger;
      if i = 0 then
        FDTable2.FieldByName('status').AsInteger := 3
      else if i = 1 then
        FDTable2.FieldByName('status').AsInteger := Ord(TOrderStatus.billing);
      FDTable2.Post;
      FDTable2.Next;
    end;
  finally
    JSON.Free;
  end;
  Response.Content := '会計処理ができました';
end;

procedure TWebModule1.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.SetCustomHeader('Access-Control-Allow-Origin', '*');
  Response.SetCustomHeader('Access-Control-Allow-Methods',
    'GET, POST, PUT, DELETE, OPTIONS');
  Response.SetCustomHeader('Access-Control-Allow-Headers', '*');
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
begin
  FDConnection1.Open;
  FDTable1.Open;
  FDTable2.Open;
  FDTable3.Open;
  FDTable4.Open;
end;

end.
