unit Unit4;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.StdCtrls, WEBLib.REST, Vcl.StdCtrls,
  Vcl.Controls, WEBLib.ExtCtrls, webdata;

type
  TForm3 = class(TWebForm)
    WebPanel1: TWebPanel;
    WebButton1: TWebButton;
    WebHttpRequest1: TWebHttpRequest;
    WebSpinEdit1: TWebSpinEdit;
    WebButton2: TWebButton;
    WebPanel2: TWebPanel;
    WebImageControl1: TWebImageControl;
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    WebLabel3: TWebLabel;
    WebLabel5: TWebLabel;
    procedure WebButton2Click(Sender: TObject);
    procedure WebButton1Click(Sender: TObject);
    procedure WebSpinEdit1Change(Sender: TObject);
    procedure WebFormShow(Sender: TObject);
    procedure WebHttpRequest1Timeout(Sender: TObject);
    procedure WebHttpRequest1Response(Sender: TObject; AResponse: string);
    procedure WebHttpRequest1Error(Sender: TObject;
      ARequest: TJSXMLHttpRequestRecord; Event: TJSEventRecord;
      var Handled: Boolean);
  private
    function GetTotalCost: integer;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(Sender: TComponent; AOrder: TOrderData); overload;
    property TotalCost: integer read GetTotalCost;
  end;

var
  Form3: TForm3;
  Order: TOrderData;

implementation

{$R *.dfm}

uses WEBLib.JSON, main, info;

var
  min: integer;

constructor TForm3.Create(Sender: TComponent; AOrder: TOrderData);
begin
  inherited Create(Sender);
  Order.Assign(AOrder);
end;

function TForm3.GetTotalCost: integer;
begin
  result := Order.qty * Order.price;
end;

procedure TForm3.WebButton1Click(Sender: TObject);
var
  data: TJSONObject;
begin
  data := TJSONObject.Create;
  try
    data.AddPair('userID', main.tableID);
    data.AddPair('id', Order.Id);
    data.AddPair('qty', Order.qty);
    data.AddPair('count', Order.count - Order.qty);
    Hide;
    WebHttpRequest1.PostData := data.ToString;
  finally
    data.Free;
  end;
  WebHttpRequest1.Execute;
end;

procedure TForm3.WebButton2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TForm3.WebFormShow(Sender: TObject);
begin
  WebLabel1.Caption := Order.name;
  WebLabel2.Caption := Order.comment;
  WebLabel3.Caption := Order.price.ToString + ' 円';
  WebSpinEdit1.Value := Order.qty;
  min := Order.qty;
  WebImageControl1.URL := Order.ImageBase64;
  WebLabel5.Caption := TotalCost.ToString + ' 円';
  WebSpinEdit1Change(nil);
  WebHttpRequest1.URL := 'http://' + info.server + '/order';
end;

procedure TForm3.WebHttpRequest1Error(Sender: TObject;
  ARequest: TJSXMLHttpRequestRecord; Event: TJSEventRecord;
  var Handled: Boolean);
begin
  WebButton2Click(Sender);
  Showmessage('通信エラー');
end;

procedure TForm3.WebHttpRequest1Response(Sender: TObject; AResponse: string);
begin
  ModalResult := mrOK;
  Showmessage(AResponse);
  Close;
end;

procedure TForm3.WebHttpRequest1Timeout(Sender: TObject);
begin
  Showmessage('エラー： 混雑中');
  ModalResult := mrCancel;
  Close;
end;

procedure TForm3.WebSpinEdit1Change(Sender: TObject);
begin
  if WebSpinEdit1.Value < min then
    WebSpinEdit1.Value := min;
  Order.qty := WebSpinEdit1.Value;
  WebLabel5.Caption := TotalCost.ToString + ' 円';
  if Order.count - Order.qty < 0 then
  begin
    WebButton1.Caption := '品切れ';
    WebButton1.Enabled := false;
  end
  else
  begin
    WebButton1.Caption := '決定';
    WebButton1.Enabled := true;
  end;
end;

end.
