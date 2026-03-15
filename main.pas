unit main;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ExtCtrls, WEBLib.CSS,
  WEBLib.Controls, WEBLib.StdCtrls, WEBLib.WebCtrls, WEBLib.JSON,
  WEBLib.Slider, Unit1, Vcl.Controls, Vcl.StdCtrls, WEBLib.REST;

type
  TForm1 = class(TWebForm)
    WebResponsiveGridPanel1: TWebResponsiveGridPanel;
    WebPanel1: TWebPanel;
    WebPanel2: TWebPanel;
    WebPanel3: TWebPanel;
    WebPanel4: TWebPanel;
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    WebPanel7: TWebPanel;
    WebLinkLabel1: TWebLinkLabel;
    WebLinkLabel2: TWebLinkLabel;
    WebLabel3: TWebLabel;
    WebHTMLDiv2: TWebHTMLDiv;
    WebScrollBox1: TWebScrollBox;
    WebLinkLabel3: TWebLinkLabel;
    WebHttpRequest1: TWebHttpRequest;
    procedure WebFormCreate(Sender: TObject);
    procedure WebHttpRequest1Response(Sender: TObject; AResponse: string);
    procedure WebPanel1Click(Sender: TObject);
    procedure WebPanel4Click(Sender: TObject);
  private
    { Private declarations }
    procedure Order(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2, System.Generics.Collections, data;

function NativeIntToCssColor(AColor: NativeInt): string;
begin
  Result := Format('#%.2x%.2x%.2x', [GetRValue(AColor), GetGValue(AColor),
    GetBValue(AColor)]);
end;

procedure TForm1.Order(Sender: TObject);
begin
  Form2 := TForm2.CreateNew(Self);
  Form2.Load;
  Form2.Parent := Self;
  Form2.AddItem(TFrame1(Sender).Order);
  Form2.Show;
end;

procedure TForm1.WebFormCreate(Sender: TObject);
var
  panel: TWebPanel;
  color: string;
  i: integer;
begin
  for i := 0 to WebResponsiveGridPanel1.ControlCollection.Count - 1 do
    if WebResponsiveGridPanel1.ControlCollection.Items[i].Control is TWebPanel
    then
    begin
      panel := WebResponsiveGridPanel1.ControlCollection.Items[i]
        .Control as TWebPanel;
      color := NativeIntToCssColor(panel.color);
      panel.ElementHandle.style.setProperty('background-color', color);
    end;

  WebHttpRequest1.Execute;
end;

procedure TForm1.WebHttpRequest1Response(Sender: TObject; AResponse: string);
var
  JSON: TJSONObject;
  arr: TJSONArray;
  i: integer;
  data: TOrderData;
  obj: TFrame1;
  old: TObject;
begin
  Showmessage('A');
  for i := WebScrollBox1.ControlCount - 1 downto 0 do
    if WebScrollBox1.Controls[i] is TFrame1 then
    begin
      old := WebScrollBox1.Controls[i];
      old.Free;
    end;

  JSON := TJSONObject.ParseJSONValue(AResponse) as TJSONObject;
  arr := JSON.GetValue('items') as TJSONArray;
  for i := 0 to arr.Count - 1 do
  begin
    data := TOrderData.Create(arr[i] as TJSONObject);
    obj := TFrame1.Create(Self);
    obj.Parent := WebScrollBox1;
    obj.LoadFromForm;
    obj.RegisterItem(data);
    obj.Align := alLeft;
    obj.OnOrder := @Order;
    data.Free;
  end;
end;

procedure TForm1.WebPanel1Click(Sender: TObject);
var
  url: string;
begin
  if Sender = WebPanel1 then
    url := 'http://'
  else if Sender = WebPanel2 then
    url := 'http://'
  else if Sender = WebPanel3 then
    url := 'http://localhost:8080/';
  WebHttpRequest1.url := url;
  WebHttpRequest1.Execute;
end;

procedure TForm1.WebPanel4Click(Sender: TObject);
begin
  WebHttpRequest1.url := 'http://';
  WebHttpRequest1.Execute;
end;

end.
