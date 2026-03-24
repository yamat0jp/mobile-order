unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    DataSource1: TDataSource;
    FDQuery1: TFDQuery;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    FDTable1: TFDTable;
    FDTable1tableID: TIntegerField;
    FDTable1orderID: TFDAutoIncField;
    FDTable1qty: TIntegerField;
    FDTable1timedata: TSQLTimeStampField;
    FDTable1status: TIntegerField;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    FDTable2: TFDTable;
    FDTable1id: TIntegerField;
    FDTable2id: TFDAutoIncField;
    FDTable2category: TWideMemoField;
    FDTable2name: TWideMemoField;
    FDTable2comment: TWideMemoField;
    FDTable2price: TIntegerField;
    FDTable2qty: TIntegerField;
    FDTable2cnt: TIntegerField;
    FDTable2fileext: TWideMemoField;
    FDTable2image: TBlobField;
    Panel1: TPanel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    Panel2: TPanel;
    Button1: TButton;
    Label4: TLabel;
    Timer1: TTimer;
    procedure RadioButton1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private 宣言 }
    procedure ListItemClear(AList: TListBox);
  public
    { Public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses System.Generics.Collections;

const
  title = 'テーブル番号で選択してください';

var
  basestr: string;

procedure TForm1.Button1Click(Sender: TObject);
var
  s: string;
  i, j: integer;
  p: PInteger;
  t: ^TTime;
begin
  if ListBox3.ItemIndex = -1 then
    Exit;
  i := ListBox3.ItemIndex;
  p := PInteger(ListBox3.Items.Objects[i]);
  j := p^;
  Dispose(p);
  s := ListBox3.Items[i];
  ListBox3.Items.Delete(i);
  New(t);
  t^ := GetTime;
  ListBox2.AddItem(s, Pointer(t));
  if FDTable1.Locate('orderID', j) then
  begin
    FDTable1.Edit;
    FDTable1.FieldByName('status').AsInteger := 1;
    FDTable1.Post;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  Data, num: integer;
  pair: ^TPair<integer, integer>;
  kind: string;
begin
  FDTable1.Filter := basestr + ' and tableID = ' + ComboBox1.Items
    [ComboBox1.ItemIndex];
  kind := '';
  ListBox1.Items.Clear;
  FDTable1.First;
  while not FDTable1.Eof do
  begin
    Data := FDTable1.FieldByName('qty').AsInteger;
    FDTable2.First;
    while not FDTable2.Eof do
    begin
      kind := FDTable2.FieldByName('name').AsString;
      num := ListBox1.Items.IndexOf(kind);
      if num = -1 then
      begin
        New(pair);
        pair^ := TPair<integer, integer>.Create(Data,
          FDTable2.FieldByName('price').AsInteger);
        ListBox1.Items.AddObject(kind, Pointer(pair));
      end
      else
      begin
        pair := Pointer(ListBox1.Items.Objects[num]);
        pair^.Key := pair^.Key + Data;
        ListBox1.Items.Objects[num] := Pointer(pair);
      end;
      FDTable2.Next;
    end;
    FDTable1.Next;
  end;
  Data := 0;
  for var i := 0 to ListBox1.Items.Count - 1 do
  begin
    pair := Pointer(ListBox1.Items.Objects[i]);
    inc(Data, pair^.Key * pair^.Value);
    ListBox1.Items[i] := Format('%s  x %d = %d', [ListBox1.Items[i], pair^.Key,
      pair^.Value]);
    Dispose(pair);
  end;
  Label3.Caption := Data.ToString + ' 円';
  ListBox1.Items.Add('----------------------');
  ListBox1.Items.Add(Label3.Caption);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ListItemClear(ListBox2);
  ListItemClear(ListBox3);
end;

procedure TForm1.ListItemClear(AList: TListBox);
begin
  for var i := 0 to AList.Items.Count - 1 do
    if Assigned(AList.Items.Objects[i]) then
      Dispose(Pointer(AList.Items.Objects[i]));
  AList.Items.Clear;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
var
  s: string;
begin
  Panel1.Hide;
  ListBox1.Hide;
  DBGrid1.Hide;
  Panel2.Hide;
  DBNavigator1.Hide;
  ComboBox1.Text := title;
  if RadioButton1.Checked then
  begin
    FDTable1.IndexFieldNames := 'orderID';
    FDTable1.Filter := 'status = 0';
    FDTable1.Filtered := true;
    Panel2.Show;
  end
  else if RadioButton2.Checked then
  begin
    ListBox1.Items.Clear;
    FDTable1.IndexFieldNames := 'tableID';
    basestr := 'status = 2';
    FDTable1.Filter := basestr;
    FDTable1.Filtered := true;
    FDTable1.First;
    while not FDTable1.Eof do
    begin
      s := FDTable1.FieldByName('tableID').AsString;
      if ComboBox1.Items.IndexOf(s) = -1 then
        ComboBox1.Items.Add(s);
      FDTable1.Next;
    end;
    Panel1.Show;
    ListBox1.Show;
    DBGrid1.Show;
  end
  else if RadioButton3.Checked then
  begin
    FDTable1.IndexFieldNames := 'timedata';
    FDTable1.Filtered := false;
    DBGrid1.Show;
    DBNavigator1.Show;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  fmt = '%d 番テーブル %s x%d';
var
  s: string;
  p: PInteger;
  t: ^TTime;
  i: integer;
begin
  if not RadioButton1.Checked then
    Exit;
  i := ListBox3.ItemIndex;
  ListItemClear(ListBox3);
  FDTable1.Filter:='status = 0';
  FDTable1.Filtered:=true;
  FDTable1.First;
  while not FDTable1.Eof do
  begin
    s := Format(fmt, [FDTable1.FieldByName('tableID').AsInteger,
      FDTable2.FieldByName('name').AsString, FDTable1.FieldByName('qty')
      .AsInteger]);
    New(p);
    p^:=FDTable1.FieldByName('orderID').AsInteger;
    ListBox3.AddItem(s,Pointer(p));
    FDTable1.Next;
  end;
  if ListBox3.Items.Count > i then
    ListBox3.ItemIndex := i;
  for var n := 0 to ListBox2.Items.Count - 1 do
  begin
    t := Pointer(ListBox2.Items.Objects[n]);
    if GetTime - t^ > 5 / (24 * 60) then
    begin
      Dispose(t);
      ListBox2.Items.Delete(n);
    end;
  end;
end;

end.
