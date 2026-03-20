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
  Vcl.Bind.Editors;

type
  TForm5 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
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
    procedure Button2Click(Sender: TObject);
    procedure FDTable1AfterPost(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses Unit3;

procedure TForm5.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm5.FDTable1AfterPost(DataSet: TDataSet);
begin
  Label1.Caption := Format('%.5d_%s',
    [DataModule3.FDTable1.FieldByName('id').AsInteger, Edit2.Text]);
end;

end.
