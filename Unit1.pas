unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, WEBLib.JSON,
  WEBLib.Controls, WEBLib.ExtCtrls, WEBLib.Forms, WEBLib.Graphics,
  WEBLib.StdCtrls, Vcl.StdCtrls, Vcl.Controls, Vcl.Imaging.jpeg, webdata;

type
  TFrame1 = class(TWebFrame)
    WebImageControl1: TWebImageControl;
    WebPanel1: TWebPanel;
    WebButton1: TWebButton;
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    WebLabel3: TWebLabel;
    WebLabel4: TWebLabel;
    procedure WebButton1Click(Sender: TObject);
  private
    FOnOrder: TNotifyEvent;
    FOrder: TOrderData;
    { Private éŒ¾ }
  public
    { Public éŒ¾ }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RegisterItem(AData: TOrderData);
    property OnOrder: TNotifyEvent read FOnOrder write FOnOrder;
    property Order: TOrderData read FOrder;
  end;

implementation

{$R *.dfm}

uses main;

constructor TFrame1.Create(AOwner: TComponent);
begin
  inherited;
  FOrder := TOrderData.Create;
end;

destructor TFrame1.Destroy;
begin
  FOrder.Free;
  inherited;
end;

procedure TFrame1.RegisterItem(AData: TOrderData);
begin
  FOrder.Assign(AData);
  WebLabel1.Caption := AData.name;
  WebLabel2.Caption := AData.comment;
  WebLabel3.Caption := AData.price.ToString;
  WebImageControl1.URL := AData.ImageBase64;
  if AData.count >= AData.qty then
  begin
    WebLabel4.Caption := '”Ì”„’†';
    WebButton1.Enabled := true;
    OnOrder := @Form1.Order;
  end
  else
  begin
    WebLabel4.Caption := '”„‚èØ‚ê';
    WebButton1.Enabled := false;
  end;
end;

procedure TFrame1.WebButton1Click(Sender: TObject);
begin
  if Assigned(FOnOrder) then
    FOnOrder(Self);
end;

end.
