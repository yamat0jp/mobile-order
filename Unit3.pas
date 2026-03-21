unit Unit3;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TDataModule3 = class(TDataModule)
    FDQuery1: TFDQuery;
    FDTable1: TFDTable;
    FDConnection1: TFDConnection;
    DataSource1: TDataSource;
    FDTable1id: TFDAutoIncField;
    FDTable1category: TWideMemoField;
    FDTable1name: TWideMemoField;
    FDTable1comment: TWideMemoField;
    FDTable1price: TIntegerField;
    FDTable1qty: TIntegerField;
    FDTable1fileext: TWideMemoField;
    FDTable1image: TBlobField;
    FDTable1cnt: TIntegerField;
    procedure FDTable1BeforePost(DataSet: TDataSet);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  DataModule3: TDataModule3;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Unit5;

{$R *.dfm}

procedure TDataModule3.FDTable1BeforePost(DataSet: TDataSet);
begin
  FDTable1.FieldByName('fileext').AsString := 'png';
end;

end.
