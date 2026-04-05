program menu;

uses
  Vcl.Forms,
  Unit5 in 'Unit5.pas' {Form5},
  Unit3 in 'Unit3.pas' {DataModule3: TDataModule},
  webdata in 'webdata.pas',
  OKCANCL1 in 'c:\program files (x86)\embarcadero\studio\23.0\ObjRepos\JA\DelphiWin32\OKCANCL1.PAS' {OKBottomDlg},
  OKCNHLP1 in 'OKCNHLP1.pas' {OKHelpBottomDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TDataModule3, DataModule3);
  Application.CreateForm(TOKHelpBottomDlg, OKHelpBottomDlg);
  Application.Run;
end.
