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

const
  tableID = 0;

var
  Form3: TForm3;
  Order: TOrderData;

implementation

{$R *.dfm}

uses Unit2, WEBLib.JSON;

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
    data.AddPair('userID', tableID);
    data.AddPair('qty', Order.qty);
//    Order.count := Order.count - Order.qty;
    Hide;
    WebHttpRequest1.PostData := data.ToString;
  finally
    data.Free;
  end;
  WebHttpRequest1.Execute;
  ModalResult := mrOK;
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
  WebSpinEdit1Change(nil);
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
  Order.qty := WebSpinEdit1.Value;
  WebLabel5.Caption := TotalCost.ToString;
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
