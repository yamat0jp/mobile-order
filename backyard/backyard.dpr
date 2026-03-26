program backyard;

uses
  Vcl.Forms,
  Unit6 in 'Unit6.pas' {Form1},
  info in '..\info.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
