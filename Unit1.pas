unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  WEBLib.Controls, WEBLib.ExtCtrls, WEBLib.Forms, WEBLib.Graphics,
  WEBLib.StdCtrls, Vcl.StdCtrls, Vcl.Controls, Vcl.Imaging.jpeg;

type
  TFrame1 = class(TWebFrame)
    WebImageControl1: TWebImageControl;
    WebPanel1: TWebPanel;
    WebButton1: TWebButton;
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    WebLabel3: TWebLabel;
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

implementation

{$R *.dfm}

end.
