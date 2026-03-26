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
  TLocalClass = class
    orderID: integer;
    price: integer;
    count: integer;
    time: TTime;
  end;

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
    Label5: TLabel;
    Timer2: TTimer;
    Button2: TButton;
    Button3: TButton;
    Timer1: TTimer;
    procedure RadioButton1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

uses System.Generics.Collections, info;

const
  title = 'テーブル番号で選択してください';

procedure TForm1.Button1Click(Sender: TObject);
var
  s: string;
  i: integer;
  local: TLocalClass;
begin
  if ListBox3.ItemIndex = -1 then
    Exit;
  i := ListBox3.ItemIndex;
  local := ListBox3.Items.Objects[i] as TLocalClass;
  s := ListBox3.Items[i];
  ListBox3.Items.Delete(i);
  local.time := GetTime;
  ListBox2.AddItem(s, local);
  if FDTable1.Locate('orderID', local.orderID) then
  begin
    FDTable1.Edit;
    FDTable1.FieldByName('status').AsInteger := Ord(TOrderStatus.eating);
    FDTable1.Post;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if ComboBox1.ItemIndex = -1 then
    Exit;
  FDTable1.First;
  while not FDTable1.Eof do
  begin
    FDTable1.Edit;
    FDTable1.FieldByName('status').AsInteger := Ord(TOrderStatus.archive);
    FDTable1.Post;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
const
  fmt = '%d 番テーブル %s x%d';
var
  local: TLocalClass;
  i: integer;
  s: string;
begin
  if not RadioButton1.Checked then
    Exit;
  ListItemClear(ListBox3);
  FDTable1.Filter := 'status = 0';
  FDTable1.Filtered := true;
  FDTable1.First;
  i := 0;
  while not FDTable1.Eof do
  begin
    s := Format(fmt, [FDTable1.FieldByName('tableID').AsInteger,
      FDTable2.FieldByName('name').AsString, FDTable1.FieldByName('qty')
      .AsInteger]);
    local := TLocalClass.Create;
    local.orderID := FDTable1.FieldByName('orderID').AsInteger;
    ListBox3.AddItem(s, local);
    FDTable1.Next;
  end;
  for var n := 0 to ListBox2.Items.count - 1 do
  begin
    local := ListBox2.Items.Objects[n] as TLocalClass;
    if GetTime - local.time > 5 / (24 * 60) then
    begin
      local.Free;
      ListBox2.Items.Delete(n);
    end;
  end;
  Timer1Timer(nil);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  Data, num: integer;
  local: TLocalClass;
  kind: string;
begin
  FDTable1.Filter := 'status = 2 and tableID = ' + ComboBox1.Items
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
        local := TLocalClass.Create;
        local.count := Data;
        local.price := FDTable2.FieldByName('price').AsInteger;
        ListBox1.Items.AddObject(kind, local);
      end
      else
      begin
        local := ListBox1.Items.Objects[num] as TLocalClass;
        local.count := Local.count + Data;
        ListBox1.Items.Objects[num] := local;
      end;
      FDTable2.Next;
    end;
    FDTable1.Next;
  end;
  Data := 0;
  for var i := 0 to ListBox1.Items.count - 1 do
  begin
    local := ListBox1.Items.Objects[i] as TLocalClass;
    ListBox1.Items[i] := Format('%s  x %d = %d',
      [ListBox1.Items[i], local.count, local.count * local.price]);
    inc(Data, local.count * local.price);
    local.Free;
  end;
  Button2.Caption := Data.ToString + ' 円';
  ListBox1.Items.Add('----------------------');
  ListBox1.Items.Add(Button2.Caption);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ListItemClear(ListBox2);
  ListItemClear(ListBox3);
end;

procedure TForm1.ListItemClear(AList: TListBox);
begin
  for var i := 0 to AList.Items.count - 1 do
    if Assigned(AList.Items.Objects[i]) then
      AList.Items.Objects[i].Free;
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
  Timer1.Enabled := false;
  if RadioButton1.Checked then
  begin
    FDTable1.IndexFieldNames := 'orderID';
    FDTable1.Filter := 'status = 0';
    FDTable1.Filtered := true;
    Panel2.Show;
    Timer1.Enabled := true;
  end
  else if RadioButton2.Checked then
  begin
    ListBox1.Items.Clear;
    FDTable1.IndexFieldNames := 'tableID';
    FDTable1.Filter := 'status = 2';
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
begin
  FDQuery1.SQL.Text := 'select count(*) as cnt from kitchen where status = 0;';
  FDQuery1.Open;
  if FDQuery1.FieldByName('cnt').AsInteger > ListBox3.Items.count then
  begin
    Button3.Caption := '更新';
    Button3.Enabled := true;
  end
  else
  begin
    Button3.Caption := '';
    Button3.Enabled := false;
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  FDQuery1.Open('select count(*) as cnt from kitchen where status = 3');
  Label5.Visible := FDQuery1.FieldByName('cnt').AsInteger > 0;
end;

end.
