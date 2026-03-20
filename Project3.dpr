program Project3;

uses
  Vcl.Forms,
  Unit5 in 'Unit5.pas' {Form5},
  Unit3 in 'Unit3.pas' {DataModule3: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TDataModule3, DataModule3);
  Application.Run;
end.
