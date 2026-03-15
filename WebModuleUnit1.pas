unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1WebActionItem1Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { private êÈåæ }
  public
    { public êÈåæ }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses System.JSON;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  JSON, item: TJSONObject;
  data: TJSONArray;
begin
  data := TJSONArray.Create;
  JSON := TJSONObject.Create;
  try
    for var i := 1 to 5 do
    begin
      item:=TJSONObject.Create;
      item.AddPair('id', 'ice');
      item.AddPair('name', 'ice cup');
      item.AddPair('qrt', 'test');
      item.AddPair('price', TJSONNumber.Create(380));
      data.Add(item);
    end;
    json.AddPair('items',data);
    Response.ContentType := 'applicatrion/json; charset=utf-8';
    Response.Content := JSON.ToJSON;
  finally
    JSON.Free;
  end;
end;

procedure TWebModule1.WebModule1WebActionItem1Action(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content:='test';
end;

end.
