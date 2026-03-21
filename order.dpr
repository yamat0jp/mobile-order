program order;

{$R *.dres}

uses
  Vcl.Forms,
  WEBLib.Forms,
  main in 'main.pas' {Form1: TWebForm} {*.html},
  Unit1 in 'Unit1.pas' {Frame1: TFrame},
  Unit2 in 'Unit2.pas' {Form2: TWebForm} {*.html},
  Unit4 in 'Unit4.pas' {Form3: TWebForm} {*.html},
  webdata in 'webdata.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
