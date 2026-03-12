unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg,
  WEBLib.Controls, WEBLib.ExtCtrls,
  Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TFrame1 = class(TFrame)
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
