unit main;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ExtCtrls, WEBLib.CSS,
  WEBLib.Controls, WEBLib.StdCtrls, WEBLib.WebCtrls, WEBLib.JSON,
  WEBLib.Slider, Unit1, Vcl.Controls, Vcl.StdCtrls, WEBLib.REST, Vcl.Menus,
  WEBLib.Menus, Vcl.Imaging.GIFImg;

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
    WebWaitMessage1: TWebWaitMessage;
    procedure WebFormCreate(Sender: TObject);
    procedure WebHttpRequest1Response(Sender: TObject; AResponse: string);
    procedure WebPanel1Click(Sender: TObject);
    procedure WebPanel4Click(Sender: TObject);
    procedure WebFormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure ModalForm(Sender: TObject);
    procedure Order(Sender: TObject);
    procedure About;
    procedure Home;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2, System.Generics.Collections, data, Unit4;

function NativeIntToCssColor(AColor: NativeInt): string;
begin
  Result := Format('#%.2x%.2x%.2x', [GetRValue(AColor), GetGValue(AColor),
    GetBValue(AColor)]);
end;

procedure TForm1.About;
begin
  Showmessage('version 0.1.0');
end;

procedure TForm1.Home;
begin
  TForm2.CreateNew(@ModalForm);
end;

procedure TForm1.ModalForm(Sender: TObject);
var
  form: TWebForm;
begin
  form := Sender as TWebForm;
  form.Popup := true;
  form.Left := (Width - form.Width) div 2;
  form.Top := (Height - form.Height) div 2;
  form.Execute;
end;

procedure TForm1.Order(Sender: TObject);
begin
  Unit4.Order.Assign(TFrame1(Sender).Order);
  TForm3.CreateNew(@ModalForm);
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

  Unit4.Order := TOrderData.Create;
  Unit2.List := TObjectList<TOrderData>.Create;

  document.getElementById('menuHome').addEventListener('click', @Home);
  document.getElementById('menuAbout').addEventListener('click', @About);

  WebHttpRequest1.Execute;
end;

procedure TForm1.WebFormDestroy(Sender: TObject);
begin
  Unit4.Order.Free;
  Unit2.List.Free;
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
  WebWaitMessage1.Hide;
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
    obj.OnOrder := @Form1.Order;
    data.Free;
  end;
end;

procedure TForm1.WebPanel1Click(Sender: TObject);
var
  url: string;
begin
  if Sender = WebPanel1 then
    url := 'http://localhost:8080/drink'
  else if Sender = WebPanel2 then
    url := 'http://localhost:8080/setmenu'
  else if Sender = WebPanel3 then
    url := 'http://localhost:8080/popular';
  WebHttpRequest1.url := url;
  WebWaitMessage1.Show;
  WebHttpRequest1.Execute;
end;

procedure TForm1.WebPanel4Click(Sender: TObject);
begin
  WebHttpRequest1.url := 'http://localhost:8080/test';
  WebHttpRequest1.Execute;
end;

end.
