unit main;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ExtCtrls, WEBLib.CSS,
  WEBLib.Controls, WEBLib.StdCtrls, WEBLib.WebCtrls, Vcl.Controls, Vcl.StdCtrls,
  WEBLib.Slider, Vcl.Forms, Unit1;

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
    WebLinkLabel3: TWebLinkLabel;
    WebLabel3: TWebLabel;
    Frame11: TFrame1;
    WebHTMLDiv2: TWebHTMLDiv;
    procedure WebFormCreate(Sender: TObject);
    procedure WebLinkLabel3Click(Sender: TObject);
    procedure WebLinkLabel2Click(Sender: TObject);
    procedure WebLinkLabel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses policy, qanda, rule;

var
  Frames: TArray<TFrame1>;

function NativeIntToCssColor(AColor: NativeInt): string;
begin
  Result := Format('#%.2x%.2x%.2x', [GetRValue(AColor), GetGValue(AColor),
    GetBValue(AColor)]);
end;

procedure TForm1.WebFormCreate(Sender: TObject);
const
  FRAME_COUNT = 5;
var
  panel: TWebPanel;
  color: string;
  i: integer;
begin
  for i := 0 to WebResponsiveGridPanel1.ControlCollection.count - 1 do
    if WebResponsiveGridPanel1.ControlCollection.Items[i].Control is TWebPanel
    then
    begin
      panel := WebResponsiveGridPanel1.ControlCollection.Items[i]
        .Control as TWebPanel;
      color := NativeIntToCssColor(panel.color);
      panel.ElementHandle.style.setProperty('background-color', color);
    end;

//  Frame11.Hide;
  SetLength(Frames, FRAME_COUNT);
  for i := 0 to High(Frames) do
  begin
    Frames[i] := TFrame1.Create(Self);
    with Frames[i] do
    begin
      Parent := Self;
      Align := alLeft;
    end;
  end;
end;

procedure TForm1.WebLinkLabel1Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm1.WebLinkLabel2Click(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.WebLinkLabel3Click(Sender: TObject);
begin
  Form2.Show;
end;

end.
