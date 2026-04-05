unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.ExtDlgs, Vcl.StdCtrls,
  Vcl.ExtCtrls, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet,
  Data.Bind.Components, Data.Bind.DBScope, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Vcl.Imaging.pngimage, Vcl.Menus;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DBNavigator1: TDBNavigator;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo1: TMemo;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    Edit4: TEdit;
    Image1: TImage;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    OpenPictureDialog1: TOpenPictureDialog;
    Edit5: TEdit;
    LinkControlToField7: TLinkControlToField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LinkPropertyToField1: TLinkPropertyToField;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses Unit3, Jpeg, OKCANCL2, Winapi.ShellAPI;

procedure TForm5.Button1Click(Sender: TObject);
var
  s: string;
  png: TPngImage;
  pic: TPicture;
  bmp: TBitmap;
begin
  if OpenPictureDialog1.Execute then
  begin
    pic := TPicture.Create;
    bmp := TBitmap.Create;
    png := TPngImage.Create;
    try
      pic.LoadFromFile(OpenPictureDialog1.FileName);
      bmp.Assign(pic.Graphic);
      png.Assign(bmp);
      Image1.Picture.Assign(png);
    finally
      png.Free;
      bmp.Free;
      pic.Free;
    end;
  end;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm5.Edit5Change(Sender: TObject);
begin
  if Edit5.Text = '0' then
    Edit5.Color:=clActiveCaption
  else
    Edit5.Color:=clWindow;
end;

procedure TForm5.N2Click(Sender: TObject);
var
  min, max: integer;
  bmp: TBitmap;
begin
  if OKRightDlg.ShowModal = mrOK then
  begin
    min:=StrToInt(OKRightDlg.Edit1.Text);
    max:=StrToInt(OKRightDlg.Edit2.Text);
    bmp:=TBitmap.Create;
    try
      Bmp.SetSize(2480, 3508); // A4 300dpi
      bmp.SaveToFile('A4_Print.png');
      ShellExecute(0, 'open', PChar('A4_Print.png'), nil, nil, SW_SHOWNORMAL);
    finally
      bmp.Free;
    end;
  end;
end;

end.
