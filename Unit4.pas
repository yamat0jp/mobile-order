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
    procedure WebFormDestroy(Sender: TObject);
    procedure WebFormShow(Sender: TObject);
    procedure WebHttpRequest1Response(Sender: TObject; AResponse: string);
    procedure WebFormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
  Order := TOrderData.Create;
  Order.Assign(AOrder);
end;

function TForm3.GetTotalCost: integer;
begin
  result := Order.count * Order.price;
end;

procedure TForm3.WebButton1Click(Sender: TObject);
begin
  WebHttpRequest1.PostData := Order.toJson.ToString;
  WebHttpRequest1.Execute;
  ModalResult := mrOK;
  Close;
end;

procedure TForm3.WebButton2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TForm3.WebFormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := false;
  Hide;
end;

procedure TForm3.WebFormDestroy(Sender: TObject);
begin
  Order.Free;
end;

procedure TForm3.WebFormShow(Sender: TObject);
begin
  WebLabel1.Caption := Order.name;
  WebLabel2.Caption := Order.qty;
  WebLabel3.Caption := Order.price.ToString;
  WebSpinEdit1.Value := Order.count;
  WebLabel5.Caption := TotalCost.ToString;
end;

procedure TForm3.WebHttpRequest1Response(Sender: TObject; AResponse: string);
begin
  Unit2.List.Add(Order);
end;

procedure TForm3.WebSpinEdit1Change(Sender: TObject);
begin
  Order.count := WebSpinEdit1.Value;
  WebLabel5.Caption := TotalCost.ToString;
end;

end.
