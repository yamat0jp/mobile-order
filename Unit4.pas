unit Unit4;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.StdCtrls, WEBLib.REST, Vcl.StdCtrls,
  Vcl.Controls, WEBLib.ExtCtrls, data;

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
    WebLabel4: TWebLabel;
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

uses Unit2;

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
begin
  WebHttpRequest1.PostData := Order.toJson.ToString;
  WebHttpRequest1.Execute;
  Enabled := false;
  WebButton1.Caption := '処理中';
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
  WebLabel3.Caption := Order.price.ToString;
  WebSpinEdit1.Value := Order.qty;
  WebImageControl1.URL := Order.ImageBase64;
  WebLabel5.Caption := TotalCost.ToString;
end;

procedure TForm3.WebHttpRequest1Error(Sender: TObject;
  ARequest: TJSXMLHttpRequestRecord; Event: TJSEventRecord;
  var Handled: Boolean);
begin
  WebButton2Click(Sender);
  Showmessage('通信エラー');
end;

procedure TForm3.WebHttpRequest1Response(Sender: TObject; AResponse: string);
var
  obj: TOrderData;
begin
  obj := TOrderData.Create;
  obj.Assign(Order);
  Unit2.List.Add(obj);
  ModalResult := mrOK;
  Close;
  Showmessage(AResponse);
end;

procedure TForm3.WebHttpRequest1Timeout(Sender: TObject);
begin
  Showmessage('エラー： 混雑中');
  ModalResult := mrCancel;
  Close;
end;

procedure TForm3.WebSpinEdit1Change(Sender: TObject);
begin
  Order.qty := WebSpinEdit1.Value;
  WebLabel5.Caption := TotalCost.ToString;
end;

end.
