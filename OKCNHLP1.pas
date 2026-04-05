unit OKCNHLP1;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, OKCANCL1;

type
  TOKHelpBottomDlg = class(TOKBottomDlg)
    HelpBtn: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure HelpBtnClick(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  OKHelpBottomDlg: TOKHelpBottomDlg;

implementation

{$R *.dfm}

procedure TOKHelpBottomDlg.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
 
