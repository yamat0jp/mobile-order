unit main;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ExtCtrls, WEBLib.CSS,
  WEBLib.Controls, WEBLib.StdCtrls, WEBLib.WebCtrls, WEBLib.JSON,
  WEBLib.Slider, WEBLib.REST,
  WEBLib.Menus, Vcl.Imaging.GIFImg, Vcl.Controls, Vcl.StdCtrls;

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
    WebHttpRequest2: TWebHttpRequest;
    WebHttpRequest3: TWebHttpRequest;
    procedure WebFormCreate(Sender: TObject);
    procedure WebHttpRequest1Response(Sender: TObject; AResponse: string);
    procedure WebPanel1Click(Sender: TObject);
    procedure WebFormDestroy(Sender: TObject);
    procedure WebHttpRequest2Response(Sender: TObject; AResponse: string);
    procedure WebHttpRequest3Response(Sender: TObject; AResponse: string);
  private
    { Private declarations }
    procedure ModalForm(Sender: TObject);
    procedure About;
    procedure Home;
  public
    { Public declarations }
    procedure Order(Sender: TObject);
  end;

var
  Form1: TForm1;
  tableID: integer;

implementation

{$R *.dfm}

uses Unit1, Unit2, System.Generics.Collections, webdata, Unit4;

function NativeIntToCssColor(AColor: NativeInt): string;
begin
  Result := Format('#%.2x%.2x%.2x', [GetRValue(AColor), GetGValue(AColor),
    GetBValue(AColor)]);
end;

procedure TForm1.About;
begin
  Showmessage('version 0.2.0');
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
  form.ShowModal(
    procedure(mr: TModalResult)
    begin
      WebHttpRequest1.Execute;
    end);
end;

procedure TForm1.Order(Sender: TObject);
var
  Order: TOrderData;
begin
  Order := TFrame1(Sender).Order;
  Unit4.Order.Assign(Order);
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
  Unit2.List := TObjectList<TAdvanceData>.Create;

  document.getElementById('menuHome').addEventListener('click', @Home);
  document.getElementById('menuAbout').addEventListener('click', @About);

  WebHttpRequest3.Execute;
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
  try
    arr := JSON.GetValue('items') as TJSONArray;
    for i := 0 to arr.Count - 1 do
    begin
      data := TOrderData.Create(arr[i] as TJSONObject);
      obj := TFrame1.Create(Self);
      obj.Parent := WebScrollBox1;
      obj.LoadFromForm;
      obj.RegisterItem(data);
      obj.WebImageControl1.URL := data.ImageBase64;
      obj.Align := alLeft;
      data.Free;
    end;
  finally
    JSON.Free;
  end;
end;

procedure TForm1.WebHttpRequest2Response(Sender: TObject; AResponse: string);
var
  JSON: TJSONObject;
  arr: TJSONArray;
  i: integer;
  Order: TAdvanceData;
begin
  Unit2.List.Clear;
  JSON := TJSONObject.ParseJSONValue(AResponse) as TJSONObject;
  try
    arr := JSON.Values['items'] as TJSONArray;
    for i := 0 to arr.Count - 1 do
    begin
      Order := TAdvanceData.Create(arr[i] as TJSONObject);
      Unit2.List.Add(Order);
    end;
  finally
    JSON.Free;
  end;
end;

procedure TForm1.WebHttpRequest3Response(Sender: TObject; AResponse: string);
var
  JSON: TJSONObject;
begin
  JSON := TJSONObject.ParseJSONValue(AResponse) as TJSONObject;
  try
    tableID := (JSON.GetValue('tableID') as TJSONNumber).asInt;
  finally
    JSON.Free;
  end;
  WebHttpRequest2.PostData := tableID.toString;
  WebHttpRequest1.Execute;
  WebHttpRequest2.Execute;
  WebLabel1.Caption := Format('"%.2d" 番テーブル', [tableID]);
end;

procedure TForm1.WebPanel1Click(Sender: TObject);
var
  URL: string;
begin
  if Sender = WebPanel1 then
    URL := 'http://localhost:8080/?category=drink'
  else if Sender = WebPanel2 then
    URL := 'http://localhost:8080/?category=setmenu'
  else if Sender = WebPanel3 then
    URL := 'http://localhost:8080/?category=popular'
  else if Sender = WebPanel4 then
    URL := 'http://localhost:8080/?category=softdrink';
  WebHttpRequest1.URL := URL;
  WebWaitMessage1.Show;
  WebHttpRequest1.Execute;
end;

end.
