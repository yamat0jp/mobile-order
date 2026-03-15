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
  private
    { Private declarations }
  public
    { Public declarations }
    constructor CreateNew(Sender: TComponent; AOrder: TOrderData); overload;
  end;

var
  Form3: TForm3;
  Order: TOrderData;

implementation

{$R *.dfm}

constructor TForm3.CreateNew(Sender: TComponent; AOrder: TOrderData);
begin
  inherited Create(Sender);
  Order.Assign(AOrder);
  WebLabel1.Caption:=Order.name;
  WebLabel1.Caption:=Order.qty;
  WebLabel1.Caption:=Order.price.ToString;
  WebSpinEdit1.Value:=Order.count;
end;

procedure TForm3.WebButton1Click(Sender: TObject);
begin
  WebHttpRequest1.Execute;
end;

procedure TForm3.WebButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm3.WebSpinEdit1Change(Sender: TObject);
begin
  Order.count:=WebSpinEdit1.Value;
  WebLabel5.Caption:=(Order.count*Order.price).ToString;
end;

end.