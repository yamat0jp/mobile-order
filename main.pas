unit main;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ExtCtrls, WEBLib.CSS,
  WEBLib.Controls, WEBLib.StdCtrls, WEBLib.WebCtrls,
  WEBLib.Slider, Unit1, Vcl.Controls, Vcl.StdCtrls, System.Generics.Collections;

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
    procedure WebFormCreate(Sender: TObject);
  private
    { Private declarations }
    List: TObjectList<TWebFrame>;
    procedure ChangeFrameCount(FrameCount: integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function NativeIntToCssColor(AColor: NativeInt): string;
begin
  Result := Format('#%.2x%.2x%.2x', [GetRValue(AColor), GetGValue(AColor),
    GetBValue(AColor)]);
end;

procedure TForm1.ChangeFrameCount(FrameCount: integer);
var
  i: integer;
  obj: TWebFrame;
begin
  List.Clear;
  for i := 0 to FrameCount - 1 do
  begin
    obj := TFrame1.Create(Self);
    List.Add(obj);
    obj.LoadFromForm;
    obj.Parent := WebScrollBox1;
    obj.Align := alLeft;
  end;
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

  List := TObjectList<TWebFrame>.Create;
  ChangeFrameCount(5);
end;

end.
