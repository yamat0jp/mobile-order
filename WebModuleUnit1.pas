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
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  FireDAC.Comp.UI;

type
  TWebModule1 = class(TWebModule)
    DataSource1: TDataSource;
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    FDTable2: TFDTable;
    FDTable2id: TIntegerField;
    FDTable2category: TWideMemoField;
    FDTable2name: TWideMemoField;
    FDTable2comment: TWideMemoField;
    FDTable2price: TIntegerField;
    FDTable2qty: TIntegerField;
    FDTable2cnt: TIntegerField;
    FDTable2fileext: TWideMemoField;
    FDTable2image: TBlobField;
    FDTable1tableid: TIntegerField;
    FDTable1orderid: TIntegerField;
    FDTable1id: TIntegerField;
    FDTable1qty: TIntegerField;
    FDTable1timedata: TWideMemoField;
    FDTable1status: TIntegerField;
    FDTable3: TFDTable;
    FDTable4: TFDTable;
    FDTable4id: TIntegerField;
    FDTable4tableid: TIntegerField;
    FDTable4ip: TWideMemoField;
    FDTable3id: TIntegerField;
    FDTable3category: TWideMemoField;
    FDTable3name: TWideMemoField;
    FDTable3comment: TWideMemoField;
    FDTable3price: TIntegerField;
    FDTable3qty: TIntegerField;
    FDTable3cnt: TIntegerField;
    FDTable3fileext: TWideMemoField;
    FDTable3image: TBlobField;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
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
    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleException(Sender: TObject; E: Exception;
      var Handled: Boolean);
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
  JSON := TJSONObject.Create;
  order := TOrderData.Create;
  try
    FDTable3.Filter := 'category = ' +
      QuotedStr(Request.QueryFields.Values['category']);
    FDTable3.Filtered := true;
    Data := TJSONArray.Create;
    FDTable3.First;
    while not FDTable3.Eof do
    begin
      img := BlobImageString(FDTable3);

      order.category := FDTable3.FieldByName('category').AsString;
      order.id := FDTable3.FieldByName('id').AsInteger;
      order.name := FDTable3.FieldByName('name').AsString;
      order.comment := FDTable3.FieldByName('comment').AsString;
      order.qty := FDTable3.FieldByName('qty').AsInteger;
      order.price := FDTable3.FieldByName('price').AsInteger;
      order.count := FDTable3.FieldByName('cnt').AsInteger;
      order.ImageBase64 := img;
      Data.Add(order.toJson);
      FDTable3.Next;
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
    Response.SendRedirect(info.myurl);
  end;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  order: TAdvanceData;
  JSON: TJSONObject;
  arr: TJSONArray;
begin
  JSON := TJSONObject.Create;
  order := TAdvanceData.Create;
  try
    if not FDTable4.Locate('ip', Request.RemoteIP) then
      Exit;
    FDTable1.Filter := 'status < 2 and tableID = ' + FDTable4.FieldByName
      ('tableID').AsString;
    FDTable1.Filtered := true;
    arr := TJSONArray.Create;
    FDTable1.First;
    while not FDTable1.Eof do
    begin
      order.name := FDTable2.FieldByName('name').AsString;
      order.qty := FDTable1.FieldByName('qty').AsInteger;
      order.price := FDTable2.FieldByName('price').AsInteger;
      order.comment := FDTable2.FieldByName('comment').AsString;
      order.ImageBase64 := BlobImageString(FDTable2);
      order.time := FDTable1.FieldByName('timedata').AsString;
      arr.Add(order.toJson);
      FDTable1.Next;
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

procedure TWebModule1.WebModule1WebActionItem4Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  JSON: TJSONObject;
begin
  JSON := TJSONObject.ParseJSONValue(Request.Content) as TJSONObject;
  try
    if not FDTable4.Locate('ip', Request.RemoteIP) then
      Exit;
    if FDTable3.Locate('id', JSON.GetValue<integer>('id')) then
    begin
      FDTable3.Edit;
      FDTable3.FieldByName('cnt').AsInteger := JSON.GetValue<integer>('count');
      FDTable3.Post;
      Response.Content := '注文しました';

      FDTable1.Append;
      FDTable1.FieldByName('id').AsInteger := FDTable3.FieldByName('id')
        .AsInteger;
      FDTable1.FieldByName('tableID').AsInteger :=
        FDTable4.FieldByName('tableID').AsInteger;
      FDTable1.FieldByName('qty').AsInteger := JSON.GetValue<integer>('qty');
      FDTable1.FieldByName('timedata').AsString :=
        FormatDateTime('hh:nn', GetTime);
      FDTable1.FieldByName('status').AsInteger := Ord(TOrderStatus.pending);
      FDTable1.Post;
    end
    else
      Response.Content := 'エラー：しばらく待ってご注文ください';
  finally
    JSON.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem5Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  JSON: TJSONObject;
  tableID: integer;
  i: integer;
begin
  JSON := TJSONObject.ParseJSONValue(Request.Content) as TJSONObject;
  try
    if not FDTable4.Locate('ip', Request.RemoteIP) then
      Exit;
    tableID := FDTable1.FieldByName('tableID').AsInteger;
    FDTable1.Filter := 'tableID = ' + tableID.ToString;
    FDTable1.First;
    while not FDTable1.Eof do
    begin
      FDTable1.Edit;
      i := FDTable1.FieldByName('status').AsInteger;
      if i = 0 then
        FDTable1.FieldByName('status').AsInteger := 3
      else if i = 1 then
        FDTable1.FieldByName('status').AsInteger := Ord(TOrderStatus.billing);
      FDTable1.Post;
      FDTable1.Next;
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

procedure TWebModule1.WebModuleException(Sender: TObject; E: Exception;
  var Handled: Boolean);
begin
  Response.ContentType := 'text/html; charset=UTF-8';
  Response.StatusCode := 500;
  Response.Content := E.Message + ' {' + info.server + '}';
  Handled := true;
end;

end.
