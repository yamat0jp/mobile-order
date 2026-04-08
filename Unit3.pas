unit Unit3;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef;

type
  TDataModule3 = class(TDataModule)
    FDTable1: TFDTable;
    FDConnection1: TFDConnection;
    DataSource1: TDataSource;
    FDTable1CATEGORY: TWideStringField;
    FDTable1NAME: TWideStringField;
    FDTable1COMMENT: TWideStringField;
    FDTable1PRICE: TIntegerField;
    FDTable1QTY: TIntegerField;
    FDTable1CNT: TIntegerField;
    FDTable1FILEEXT: TWideStringField;
    FDTable1IMAGE: TBlobField;
    FDTable1ID: TIntegerField;
    procedure FDTable1BeforePost(DataSet: TDataSet);
    procedure FDTable1BeforeInsert(DataSet: TDataSet);
    procedure FDTable1AfterInsert(DataSet: TDataSet);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;

var
  DataModule3: TDataModule3;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Unit5;

{$R *.dfm}

var
  id: integer;

procedure TDataModule3.FDTable1AfterInsert(DataSet: TDataSet);
begin
  FDTable1.FieldByName('id').AsInteger := id;
end;

procedure TDataModule3.FDTable1BeforeInsert(DataSet: TDataSet);
begin
  FDTable1.Last;
  id := FDTable1.FieldByName('id').AsInteger + 1;
end;

procedure TDataModule3.FDTable1BeforePost(DataSet: TDataSet);
begin
  FDTable1.FieldByName('fileext').AsString := 'png';
end;

end.
