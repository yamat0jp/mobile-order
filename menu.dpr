program menu;

uses
  Vcl.Forms,
  Unit5 in 'Unit5.pas' {Form5},
  Unit3 in 'Unit3.pas' {DataModule3: TDataModule},
  webdata in 'webdata.pas',
  OKCANCL2 in 'OKCANCL2.pas' {OKRightDlg},
  info in 'info.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TDataModule3, DataModule3);
  Application.CreateForm(TOKRightDlg, OKRightDlg);
  Application.Run;
end.
