program pwa;

{$R *.dres}

uses
  Vcl.Forms,
  WEBLib.Forms,
  Unit1 in 'Unit1.pas' {Frame1: TWebFrame},
  info in 'info.pas',
  webdata in 'webdata.pas',
  Unit4 in 'Unit4.pas' {Form3: TWebForm} {*.html},
  Unit2 in 'Unit2.pas' {Form2: TWebForm} {*.html},
  main in 'main.pas' {Form1: TWebForm} {*.html};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
