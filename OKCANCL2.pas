unit OKCANCL2;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TOKRightDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  OKRightDlg: TOKRightDlg;

implementation

{$R *.dfm}

end.
