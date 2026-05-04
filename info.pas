unit info;

interface

type
  TOrderStatus = (pending, eating, billing, error, archive);

const
{$IFDEF DEBUG}
  server = 'localhost:8080';
{$ELSE}
  server = 'localhost:88/myapp/Project1.dll/?category=softdrink';
{$ENDIF}
  myurl = 'http://localhost:88/js/pwa.html';

implementation

end.
