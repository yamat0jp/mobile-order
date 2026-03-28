program Project1;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FormUnit1 in 'FormUnit1.pas' {Form2},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  info in 'info.pas',
  webdata in 'webdata.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
