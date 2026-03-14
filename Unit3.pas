unit Unit3;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls,
  WEBLib.ExtCtrls, data;

type
  TFrame2 = class(TWebFrame)
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    WebLabel3: TWebLabel;
    WebPanel1: TWebPanel;
  private
    FOrder: TOrderData;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteOrder(AOrder: TOrderData);
    property Order: TOrderData read FOrder;
  end;

var
  Frame2: TFrame2;

implementation

{$R *.dfm}
{ TFrame2 }

constructor TFrame2.Create(AOwner: TComponent);
begin
  inherited;
  FOrder := TOrderData.Create;
end;

destructor TFrame2.Destroy;
begin
  FOrder.Free;
  inherited;
end;

procedure TFrame2.WriteOrder(AOrder: TOrderData);
begin
  FOrder.Assign(AOrder);
  WebLabel1.Caption := AOrder.name;
  WebLabel2.Caption := AOrder.price.ToString;
  WebLabel3.Caption := AOrder.count.ToString;
end;

end.
