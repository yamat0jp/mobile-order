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
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem4Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem5Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { private êÈåæ }
    function BlobImageString: string;
  public
    { public êÈåæ }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses System.JSON, System.IOUtils, System.NetEncoding, Data;

function TWebModule1.BlobImageString: string;
var
  blob: TStream;
  bytes: TBytes;
begin
  blob := FDTable1.CreateBlobStream(FDTable1.FieldByName('image'), bmRead);
  try
    SetLength(bytes, blob.Size);
    blob.ReadBuffer(bytes, 0, blob.Size);
    Result := Format('data:image/%s;base64,',
      [FDTable1.FieldByName('fileext').AsString]) +
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
  s, na, img: string;
begin
  JSON := TJSONObject.Create;
  order := TOrderData.Create;
  try
    Data := TJSONArray.Create;
    FDTable1.First;
    while not FDTable1.Eof do
    begin
      na := FDTable1.FieldByName('name').AsString;
      s := Format('%.5d_%s', [FDTable1.FieldByName('id').AsInteger, na]);
      img := BlobImageString;

      order.category := FDTable1.FieldByName('category').AsString;
      order.Id := s;
      order.name := na;
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

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := 'test';
end;

procedure TWebModule1.WebModule1WebActionItem4Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  order: TOrderData;
  v: Variant;
begin
  order := TOrderData.Create(TJSONValue.ParseJSONValue(Request.Content)
    as TJSONObject);
  v := StrToInt(Copy(order.Id, 4, 5)); //check
  if FDTable1.Locate('id', v) then
  begin
    FDTable1.Edit;
    FDTable1.FieldByName('cnt').AsInteger := order.count;
    FDTable1.Post;
    Response.Content := 'íçï∂ÇµÇ‹ÇµÇΩ';
  end;
end;

procedure TWebModule1.WebModule1WebActionItem5Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := 'âÔåvèàóùÇ™Ç≈Ç´Ç‹ÇµÇΩ';
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
