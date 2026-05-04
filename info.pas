unit info;

interface

type
  TOrderStatus = (pending, eating, billing, error, archive);

const
{$IFDEF DEBUG}
  server = 'localhost:88/myapp/Project1.dll';
  myurl = 'http://localhost:88/js/pwa.html?category=softdrink';
{$ELSE}
  server = '192.168.68.54:88/myapp/Project1.dll';
  myurl = 'http://192.168.68.54:88/js/pwa.html?category=softdrink';
{$ENDIF}

implementation

end.
