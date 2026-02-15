unit qanda;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls,
  WEBLib.ExtCtrls;

type
  TForm3 = class(TWebForm)
    WebLinkLabel1: TWebLinkLabel;
    WebHTMLForm1: TWebHTMLForm;
    WebLabel1: TWebLabel;
    procedure WebLinkLabel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.WebLinkLabel1Click(Sender: TObject);
begin
  Application.GoBack;
end;

end.
