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
  FireDAC.Phys.SQLiteWrapper.Stat;

type
  TWebModule1 = class(TWebModule)
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    FDTable2: TFDTable;
    FDTable3: TFDTable;
    DataSource1: TDataSource;
    FDTable2tableID: TIntegerField;
    FDTable2id: TIntegerField;
    FDTable2category: TWideMemoField;
    FDTable2name: TWideMemoField;
    FDTable2image: TBlobField;
    FDTable2timedata: TSQLTimeStampField;
    FDTable2status: TIntegerField;
    FDTable3id: TFDAutoIncField;
    FDTable3category: TWideMemoField;
    FDTable3name: TWideMemoField;
    FDTable3comment: TWideMemoField;
    FDTable3price: TIntegerField;
    FDTable3qty: TIntegerField;
    FDTable3cnt: TIntegerField;
    FDTable3fileext: TWideMemoField;
    FDTable3image: TBlobField;
    FDTable2orderID: TIntegerField;
    FDTable1id: TFDAutoIncField;
    FDTable1category: TWideMemoField;
    FDTable1name: TWideMemoField;
    FDTable1comment: TWideMemoField;
    FDTable1price: TIntegerField;
    FDTable1qty: TIntegerField;
    FDTable1cnt: TIntegerField;
    FDTable1fileext: TWideMemoField;
    FDTable1image: TBlobField;
    FDTable2qty: TIntegerField;
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

uses System.JSON, System.IOUtils, System.NetEncoding, Data, Vcl.Graphics;

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
      order.Id := FDTable1.FieldByName('id').AsInteger;
      order.name := FDTable1.FieldByName('name').AsString;
      order.comment := FDTable1.FieldByName('comment').AsString;
      order.qty := FDTable1.FieldByName('qty').AsInteger;
      order.price := FDTable1.FieldByName('price').AsInteger;
      order.count := FDTable1.FieldByName('cnt').AsInteger;
      order.ImageBase64 := img;
      Data.Add(order.toJson);
      FDTable1.Next;
    end;
    JSON.AddPair('items', Data);
    Response.ContentType := 'applicatrion/json; charset=utf-8';
    Response.Content := JSON.toJson;
  finally
    JSON.Free;
    order.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  order: TOrderData;
  JSON, Data: TJSONObject;
  arr: TJSONArray;
  t: TDateTime;
begin
  FDTable2.Filter := 'tableID = ' + Request.Content;
  JSON := TJSONObject.Create;
  order := TOrderData.Create;
  try
    arr := TJSONArray.Create;
    FDTable3.First;
    while not FDTable3.Eof do
    begin
      t := FDTable2.FieldByName('timeData').AsDateTime;
      order.name := FDTable3.FieldByName('name').AsString;
      order.qty := FDTable2.FieldByName('qty').AsInteger;
      order.price := FDTable3.FieldByName('price').AsInteger;
      order.ImageBase64 := BlobImageString(FDTable3);
      order.status := FDTable2.FieldByName('status').AsInteger;
      Data := order.toJson;
      Data.AddPair('time', DateTimeToStr(t));
      arr.Add(Data);
      FDTable3.Next;
    end;
    JSON.AddPair('items', arr);
    Response.ContentType := 'application/json; charset=utf-8';
    Response.Content := JSON.toJson;
  finally
    JSON.Free;
    order.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem4Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  order: TJSONObject;
  blobO, blobI: TStream;
  orderID: integer;
begin
  order := TJSONObject.ParseJSONValue(Request.Content) as TJSONObject;
  FDTable1.Filtered := false;
  if FDTable1.Locate('id', order.GetValue<integer>('id')) then
  begin
    FDTable1.Edit;
    FDTable1.FieldByName('cnt').AsInteger := order.count;
    FDTable1.Post;
    Response.Content := '注文しました';

    FDTable2.Last;
    orderID := FDTable2.FieldByName('orderID').AsInteger + 1;

    FDTable2.Append;
    FDTable2.FieldByName('category').AsString :=
      FDTable1.FieldByName('category').AsString;
    FDTable2.FieldByName('name').AsString :=
      FDTable1.FieldByName('name').AsString;

    FDTable2.FieldByName('tableID').AsInteger :=
      order.GetValue<integer>('userID');
    FDTable2.FieldByName('qty').AsInteger := order.GetValue<integer>('qty');
    blobO := FDTable1.CreateBlobStream(FDTable1.FieldByName('image'), bmRead);
    blobI := FDTable2.CreateBlobStream(FDTable2.FieldByName('image'), bmWrite);
    try
      blobI.CopyFrom(blobO);
    finally
      blobI.Free;
      blobO.Free;
    end;
    FDTable2.FieldByName('orderID').AsInteger := orderID;
    FDTable2.FieldByName('timedata').AsDateTime := Now;
    FDTable2.Post;
  end
  else
    Response.Content := 'エラー： スタッフにお声がけください';
  FDTable1.Filtered := true;
end;

procedure TWebModule1.WebModule1WebActionItem5Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  JSON: TJSONObject;
  arr: TJSONArray;
  I, tableID: integer;
begin
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

end.
