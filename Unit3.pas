unit Unit3;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls,
  WEBLib.ExtCtrls;

type
  TFrame2 = class(TWebFrame)
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    WebLabel3: TWebLabel;
    WebPanel1: TWebPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frame2: TFrame2;

implementation

{$R *.dfm}

end.