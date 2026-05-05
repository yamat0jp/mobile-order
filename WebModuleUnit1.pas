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
    FDConnection1: TFDConnection;
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
    function GetOrCreateSessionID(Request: TWebRequest;
      Response: TWebResponse): string;
    function BlobImageString(DataSet: TDataSet): string;
    function NewConnection: TFDConnection;
    { private 宣言 }
  public
    { public 宣言 }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses System.JSON, System.IOUtils, System.NetEncoding, webData, Vcl.Graphics,
  info, System.Variants, System.Hash;

function TWebModule1.BlobImageString(DataSet: TDataSet): string;
var
  blob: TStream;
  bytes: TBytes;
begin
  blob := DataSet.CreateBlobStream(DataSet.FieldByName('image'), bmRead);
  try
    SetLength(bytes, blob.Size);
    blob.ReadBuffer(bytes, 0, blob.Size);
    result := 'data:image/' + DataSet.FieldByName('fileext').AsString +
      ';base64,' + TNetEncoding.Base64.EncodeBytesToString(bytes);
  finally
    blob.Free;
  end;
end;

function TWebModule1.GetOrCreateSessionID(Request: TWebRequest;
  Response: TWebResponse): string;
const
  CookieName = 'SESSION_ID';
var
  cookie: string;
begin
  cookie := Request.CookieFields.Values[CookieName];

  if cookie <> '' then
    Exit(cookie);

  // 新規発行（適当なランダム文字列）
  result := THashMD5.GetHashString(IntToStr(Random(MaxInt)) + DateTimeToStr(Now)
    + Request.RemoteIP);

  // Cookie にセット（有効期限は適宜）
  with Response.Cookies.Add do
  begin
    Name := CookieName;
    Value := result;
    Path := '/';
    HttpOnly := true;
//    SameSite := TCookieSameSite.Lax;
    Expires := Now + 1;
  end;
end;

function TWebModule1.NewConnection: TFDConnection;
begin
  result := TFDConnection.Create(nil);
  result.Params.Assign(FDConnection1.Params);
  result.Connected := true;
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Conn: TFDConnection;
  Q: TFDQuery;
  JSON: TJSONObject;
  Data: TJSONArray;
  order: TOrderData;
begin
  JSON := TJSONObject.Create;
  Data := TJSONArray.Create;
  order := TOrderData.Create;

  Conn := NewConnection;
  Q := TFDQuery.Create(nil);

  try
    // 接続設定をコピー
    Conn.Params.Assign(FDConnection1.Params);
    Conn.Connected := true;

    Q.Connection := Conn;
    Q.SQL.Text :=
      'SELECT id, category, name, comment, qty, price, cnt, fileext, image ' +
      'FROM item WHERE category = :cat order by id';
    Q.ParamByName('cat').AsString := Request.QueryFields.Values['category'];
    Q.Open;

    while not Q.Eof do
    begin
      // Blob → Base64
      order.ImageBase64 := BlobImageString(Q);
      // JSON オブジェクトへ
      order.category := Q.FieldByName('category').AsString;
      order.id := Q.FieldByName('id').AsInteger;
      order.name := Q.FieldByName('name').AsString;
      order.comment := Q.FieldByName('comment').AsString;
      order.qty := Q.FieldByName('qty').AsInteger;
      order.price := Q.FieldByName('price').AsInteger;
      order.count := Q.FieldByName('cnt').AsInteger;
      order.ImageBase64 := BlobImageString(Q);

      Data.Add(order.toJson);
      Q.Next;
    end;

    if Data.count = 0 then
      Response.Content := '{}'
    else
    begin
      JSON.AddPair('items', Data);
      Response.ContentType := 'application/json; charset=utf-8';
      Response.Content := JSON.toJson;
    end;

  finally
    Q.Free;
    Conn.Free;
    order.Free;
    JSON.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  tableStr: string;
  sessionID: string;
  Conn: TFDConnection;
  Q: TFDQuery;
begin
  sessionID := GetOrCreateSessionID(Request, Response);
  tableStr := Request.QueryFields.Values['table'];

  Conn := NewConnection;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := Conn;
    if tableStr = '' then
    begin
      Q.SQL.Text := 'SELECT tableID FROM uid WHERE session_id = :sid';
      Q.ParamByName('sid').AsString := sessionID;
      Q.Open;

      if not Q.Eof then
        Response.Content := Q.FieldByName('tableID').AsString
      else
        Response.Content := '';
    end
    else
    begin
      // テーブル設定
      Q.SQL.Text := 'INSERT INTO uid (session_id, tableID) VALUES (:sid, :tid) ' +
        'ON CONFLICT (session_id) DO UPDATE SET tableID = EXCLUDED.tableID';

      Q.ParamByName('sid').AsString := sessionID;
      Q.ParamByName('tid').AsInteger := tableStr.ToInteger;
      Q.ExecSQL;

      Response.Content := tableStr;
      Response.SendRedirect(info.myurl);
    end;
  finally
    Conn.Free;
    Q.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem2Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Conn: TFDConnection;
  Q: TFDQuery;
  JSON: TJSONObject;
  arr: TJSONArray;
  order: TAdvanceData;
  sessionID: string;
  tableID: integer;
begin
  sessionID := GetOrCreateSessionID(Request, Response);

  Conn := NewConnection;
  Q := TFDQuery.Create(nil);
  JSON := TJSONObject.Create;
  arr := TJSONArray.Create;
  order := TAdvanceData.Create;

  try
    Q.Connection := Conn;

    // 1. セッションID → tableID を取得
    Q.SQL.Text := 'SELECT tableID FROM uid WHERE session_id = :sid';
    Q.ParamByName('sid').AsString := sessionID;
    Q.Open;

    if Q.Eof then
    begin
      Response.Content := '{}';
      Exit;
    end;

    tableID := Q.FieldByName('tableID').AsInteger;

    // 2. 注文一覧を JOIN で取得
    Q.Close;
    Q.SQL.Text :=
      'SELECT kitchen.qty, timedata, name, price, comment, fileext, image '
      + 'FROM kitchen JOIN item ON kitchen.id = item.id ' +
      'WHERE tableID = :tid AND status < 2 ORDER BY timedata';
    Q.ParamByName('tid').AsInteger := tableID;
    Q.Open;

    // 3. JSON 生成
    while not Q.Eof do
    begin
      order.name := Q.FieldByName('name').AsString;
      order.qty := Q.FieldByName('qty').AsInteger;
      order.price := Q.FieldByName('price').AsInteger;
      order.comment := Q.FieldByName('comment').AsString;
      order.time := Q.FieldByName('timedata').AsString;

      order.ImageBase64 := BlobImageString(Q);

      arr.Add(order.toJson);
      Q.Next;
    end;

    JSON.AddPair('items', arr);
    Response.ContentType := 'application/json; charset=utf-8';

    if arr.count = 0 then
      Response.Content := '{}'
    else
      Response.Content := JSON.toJson;

  finally
    order.Free;
    JSON.Free;
    Q.Free;
    Conn.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem4Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Conn: TFDConnection;
  Q: TFDQuery;
  JSON: TJSONObject;
  sessionID: string;
  tableID, itemID, qty, count: integer;
begin
  JSON := TJSONObject.ParseJSONValue(Request.Content) as TJSONObject;
  sessionID := GetOrCreateSessionID(Request, Response);

  Conn := NewConnection;
  Q := TFDQuery.Create(nil);

  try
    // テーブルID取得
    Q.Connection := Conn;
    Q.SQL.Text := 'SELECT tableID FROM uid WHERE session_id = :sid';
    Q.ParamByName('sid').AsString := sessionID;
    Q.Open;

    if Q.Eof then
    begin
      Response.Content := 'テーブル未設定です';
      Exit;
    end;

    tableID := Q.FieldByName('tableID').AsInteger;

    // JSON から値取得
    itemID := JSON.GetValue<integer>('id');
    qty := JSON.GetValue<integer>('qty');
    count := JSON.GetValue<integer>('count');

    // cnt 更新
    Q.SQL.Text := 'UPDATE item SET cnt = :c WHERE id = :id';
    Q.ParamByName('c').AsInteger := count;
    Q.ParamByName('id').AsInteger := itemID;
    Q.ExecSQL;

    // 注文追加
    Q.SQL.Text := 'INSERT INTO kitchen (id, tableID, qty, timedata, status) ' +
      'VALUES (:id, :tid, :qty, :time, :status)';
    Q.ParamByName('id').AsInteger := itemID;
    Q.ParamByName('tid').AsInteger := tableID;
    Q.ParamByName('qty').AsInteger := qty;
    Q.ParamByName('time').AsString := FormatDateTime('hh:nn', Now);
    Q.ParamByName('status').AsInteger := 0; // pending
    Q.ExecSQL;

    Response.Content := '注文しました';

  finally
    JSON.Free;
    Q.Free;
    Conn.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem5Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  Conn: TFDConnection;
  Q: TFDQuery;
  sessionID: string;
  tableID: integer;
begin
  sessionID := GetOrCreateSessionID(Request, Response);

  Conn := NewConnection;
  Q := TFDQuery.Create(nil);

  try
    // テーブルID取得
    Q.Connection := Conn;
    Q.SQL.Text := 'SELECT tableID FROM uid WHERE session_id = :sid';
    Q.ParamByName('sid').AsString := sessionID;
    Q.Open;

    if Q.Eof then
    begin
      Response.Content := 'テーブル未設定です';
      Exit;
    end;

    tableID := Q.FieldByName('tableID').AsInteger;

    // 会計処理
    Q.SQL.Text := 'UPDATE kitchen SET status = ' + 'CASE WHEN status = 0 THEN 3 '
      + // pending → canceled?
      '     WHEN status = 1 THEN 2 ' + // cooking → billing
      '     ELSE status END ' + 'WHERE tableID = :tid';
    Q.ParamByName('tid').AsInteger := tableID;
    Q.ExecSQL;

    Response.Content := '会計処理ができました';

  finally
    Q.Free;
    Conn.Free;
  end;
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
  Response.Content := E.Message;
  Handled := true;
end;

end.
