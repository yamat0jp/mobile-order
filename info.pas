unit info;

interface

type
  TOrderStatus = (pending, eating, billing, error, archive);

const
{$IFDEF LOCAL}
  server = 'localhost:8080';
{$ELSE}
  server = '192.168.68.54:88/myapp/cgi.exe';
{$ENDIF}
  myurl = 'https://react-firebase-9329b.web.app/pwa.html';

implementation

end.
