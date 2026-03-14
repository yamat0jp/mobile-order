unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, WEBLib.JSON,
  WEBLib.Controls, WEBLib.ExtCtrls, WEBLib.Forms, WEBLib.Graphics,
  WEBLib.StdCtrls, Vcl.StdCtrls, Vcl.Controls, Vcl.Imaging.jpeg, data;

type
  TFrame1 = class(TWebFrame)
    WebImageControl1: TWebImageControl;
    WebPanel1: TWebPanel;
    WebButton1: TWebButton;
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    WebLabel3: TWebLabel;
    procedure WebButton1Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
    procedure RegisterItem(AData: TOrderData);
  end;

implementation

{$R *.dfm}

uses Unit2;

var
  order: TOrderData;

procedure TFrame1.RegisterItem(AData: TOrderData);
begin
  order.Assign(AData);
  WebLabel1.Caption := AData.name;
  WebLabel2.Caption := AData.qty;
  WebLabel3.Caption := AData.price.ToString;
end;

procedure TFrame1.WebButton1Click(Sender: TObject);
begin
  Form2 := TForm2.Create(Application);
  Form2.AddItem(order);
  Form2.Load;
  Form2.Execute;
end;

end.
