program order;

uses
  Vcl.Forms,
  WEBLib.Forms,
  main in 'main.pas' {Form1: TWebForm} {*.html},
  Unit1 in 'Unit1.pas' {Frame1: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
