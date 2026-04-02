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
  Vcl.Bind.Editors, Vcl.Imaging.pngimage;

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
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses Unit3, Jpeg;

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

end.
