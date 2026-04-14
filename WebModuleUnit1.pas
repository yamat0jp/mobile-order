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
    procedure WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
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

var
  conn: TFDConnection;

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
  table: TFDTable;
begin
  table := TFDTable.Create(nil);
  JSON := TJSONObject.Create;
  order := TOrderData.Create;
  try
    table.Connection := conn;
    table.TableName := 'item';
    table.IndexFieldNames := 'id';
    table.Filter := 'category = ' +
      QuotedStr(Request.QueryFields.Values['category']);
    table.Filtered := true;
    table.Open;
    Data := TJSONArray.Create;
    table.First;
    while not table.Eof do
    begin
      img := BlobImageString(table);

      order.category := table.FieldByName('category').AsString;
      order.id := table.FieldByName('id').AsInteger;
      order.name := table.FieldByName('name').AsString;
      order.comment := table.FieldByName('comment').AsString;
      order.qty := table.FieldByName('qty').AsInteger;
      order.price := table.FieldByName('price').AsInteger;
      order.count := table.FieldByName('cnt').AsInteger;
      order.ImageBase64 := img;
      Data.Add(order.toJson);
      table.Next;
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
    table.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  s: string;
  ip: string;
  id: integer;
  v: Variant;
  table: TFDTable;
begin
  table := TFDTable.Create(nil);
  try
    table.Connection := conn;
    table.TableName := 'uid';
    table.IndexFieldNames := 'id';
    table.Open;
    s := Request.QueryFields.Values['table'];
    if s = '' then
    begin
      v := table.Lookup('ip', Request.RemoteIP, 'tableID');
      if not VarIsNull(v) then
        Response.Content := v;
    end
    else
    begin
      id := s.ToInteger;
      ip := Request.RemoteIP;
      if not table.Locate('ip', ip) then
        table.AppendRecord([nil, id, ip])
      else
      begin
        table.Edit;
        table.FieldByName('tableID').AsInteger := id;
        table.Post;
      end;
      Response.Content := s;
      Response.SendRedirect(myurl);
    end;
  finally
    table.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  order: TAdvanceData;
  JSON: TJSONObject;
  arr: TJSONArray;
  table2, table3, table4: TFDTable;
begin
  table2 := TFDTable.Create(nil);
  table3 := TFDTable.Create(nil);
  table4 := TFDTable.Create(nil);
  JSON := TJSONObject.Create;
  order := TAdvanceData.Create;
  try
    table4.Connection := conn;
    table4.TableName := 'uid';
    table4.IndexFieldNames := 'id';
    table4.Open;
    if not table4.Locate('ip', Request.RemoteIP) then
      Exit;
    table2.Connection := conn;
    table3.Connection := conn;
    table2.TableName := 'kitchen';
    table3.TableName := 'item';
    DataSource1.DataSet := table2;
    table3.MasterSource := DataSource1;
    table3.MasterFields := 'id';
    table2.IndexName := 'orderID';
    table3.IndexName := 'id';
    table2.Filter := 'status < 2 and tableID = ' +
      table4.FieldByName('tableID').AsString;
    table2.Filtered := true;
    table2.Open;
    table3.Open;
    arr := TJSONArray.Create;
    table2.First;
    while not table2.Eof do
    begin
      order.name := table3.FieldByName('name').AsString;
      order.qty := table2.FieldByName('qty').AsInteger;
      order.price := table3.FieldByName('price').AsInteger;
      order.comment := table3.FieldByName('comment').AsString;
      order.ImageBase64 := BlobImageString(table3);
      order.time := table2.FieldByName('timedata').AsString;
      arr.Add(order.toJson);
      table2.Next;
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
    table2.Free;
    table3.Free;
    table4.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem4Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  JSON: TJSONObject;
  table1, table2, table4: TFDTable;
begin
  JSON := TJSONObject.ParseJSONValue(Request.Content) as TJSONObject;
  table1 := TFDTable.Create(nil);
  table2 := TFDTable.Create(nil);
  table4 := TFDTable.Create(nil);
  try
    table1.Connection := conn;
    table2.Connection := conn;
    table4.Connection := conn;
    table1.TableName := 'item';
    table2.TableName := 'kitchen';
    table4.TableName := 'uid';
    table1.IndexFieldNames := 'id';
    table2.IndexName := 'orderID';
    table4.IndexName := 'id';
    table1.Open;
    table2.Open;
    table4.Open;
    if not table4.Locate('ip', Request.RemoteIP) then
      Exit;
    if table1.Locate('id', JSON.GetValue<integer>('id')) then
    begin
      table1.Edit;
      table1.FieldByName('cnt').AsInteger := JSON.GetValue<integer>('count');
      table1.Post;
      Response.Content := '注文しました';

      table2.Append;
      table2.FieldByName('id').AsInteger := table1.FieldByName('id').AsInteger;
      table2.FieldByName('tableID').AsInteger := table4.FieldByName('tableID')
        .AsInteger;
      table2.FieldByName('qty').AsInteger := JSON.GetValue<integer>('qty');
      table2.FieldByName('timedata').AsString :=
        FormatDateTime('hh:nn', GetTime);
      table2.FieldByName('status').AsInteger := Ord(TOrderStatus.pending);
      table2.Post;
    end
    else
      Response.Content := 'エラー： スタッフにお声がけください';
  finally
    JSON.Free;
    table1.Free;
    table2.Free;
    table4.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem5Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  JSON: TJSONObject;
  tableID: integer;
  i: integer;
  table2, table4: TFDTable;
begin
  table2 := TFDTable.Create(nil);
  table4 := TFDTable.Create(nil);
  JSON := TJSONObject.ParseJSONValue(Request.Content) as TJSONObject;
  try
    table2.Connection := conn;
    table4.Connection := conn;
    table2.TableName := 'kitchen';
    table4.TableName := 'uid';
    table2.IndexFieldNames := 'orderID';
    table4.IndexFieldNames := 'id';
    if not table4.Locate('ip', Request.RemoteIP) then
      Exit;
    tableID := table2.FieldByName('tableID').AsInteger;
    table2.Filter := 'tableID = ' + tableID.ToString;
    table2.First;
    while not table2.Eof do
    begin
      table2.Edit;
      i := table2.FieldByName('status').AsInteger;
      if i = 0 then
        table2.FieldByName('status').AsInteger := 3
      else if i = 1 then
        table2.FieldByName('status').AsInteger := Ord(TOrderStatus.billing);
      table2.Post;
      table2.Next;
    end;
  finally
    JSON.Free;
    table2.Free;
    table4.Free;
  end;
  Response.Content := '会計処理ができました';
end;

procedure TWebModule1.WebModuleAfterDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  conn.Free;
end;

procedure TWebModule1.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.SetCustomHeader('Access-Control-Allow-Origin', '*');
  Response.SetCustomHeader('Access-Control-Allow-Methods',
    'GET, POST, PUT, DELETE, OPTIONS');
  Response.SetCustomHeader('Access-Control-Allow-Headers', '*');
  conn := TFDConnection.Create(nil);
  conn.ConnectionDefName := 'MyPG';
  conn.Open;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
var
  params: TStrings;
begin
  params := TStringList.Create;
  try
    params.Add('CharacterSet=utf8');
    params.Add('driverid=PG');
    params.Add('fastcgiapp');
    params.Add('server=127.0.0.1');
    params.Add('database=mydb');
    params.Add('user_name=postgres');
    params.Add('port=5432');
    params.Add('pooled = true');
    params.Add('pool_maximumitems = 6');
    params.Add('pool_expiretimeout = 30000');
    params.Add('pool_cleanuptimeout = 30000');
    params.Add('LoginTimeout = 15000');
    params.Add('WaitTimeout = 30000');
    params.Add('CommandTimeout = 30000');

    FDManager.Close;
    FDManager.AddConnectionDef('MyPG', 'PG', params);
    FDManager.ResourceOptions.SilentMode := true;
  finally
    params.Free;
  end;
  FDManager.Open;
end;

procedure TWebModule1.WebModuleException(Sender: TObject; E: Exception;
  var Handled: Boolean);
begin
  Response.ContentType := 'text/html; charset=UTF-8';
  Response.StatusCode := 500;

  Response.Content := '<html><body>' + '<h2>エラーが発生しました</h2>' + '<p>' + E.Message
    + '</p>' + '</body></html>';

  Handled := true;

  if Assigned(conn) then
    conn.Free;
end;

end.
