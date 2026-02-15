program order;

uses
  Vcl.Forms,
  WEBLib.Forms,
  main in 'main.pas' {Form1: TWebForm} {*.html},
  qanda in 'qanda.pas' {Form3: TWebForm} {*.html},
  policy in 'policy.pas' {Form2: TWebForm} {*.html},
  rule in 'rule.pas' {Form4: TWebForm} {*.html},
  Unit1 in 'Unit1.pas' {Frame1: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;

end.
