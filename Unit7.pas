unit Unit7;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FMX.Controls.Presentation, FMX.StdCtrls, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FMX.ListBox, FMX.Layouts, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, Data.Bind.EngExt, FMX.Bind.DBEngExt, FMX.Bind.Grid,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, System.Actions, FMX.ActnList;

type
  TLocalClass = class
    orderID: integer;
    price: integer;
    count: integer;
    time: TTime;
  end;

  TForm7 = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    FDConnection1: TFDConnection;
    DataSource1: TDataSource;
    FDTable2: TFDTable;
    FDTable2id: TIntegerField;
    FDTable2category: TWideMemoField;
    FDTable2name: TWideMemoField;
    FDTable2comment: TWideMemoField;
    FDTable2price: TIntegerField;
    FDTable2qty: TIntegerField;
    FDTable2cnt: TIntegerField;
    FDTable2fileext: TWideMemoField;
    FDTable2image: TBlobField;
    FDTable1: TFDTable;
    FDTable1tableid: TIntegerField;
    FDTable1orderid: TIntegerField;
    FDTable1id: TIntegerField;
    FDTable1qty: TIntegerField;
    FDTable1status: TIntegerField;
    FDQuery1: TFDQuery;
    Timer1: TTimer;
    Timer2: TTimer;
    Panel1: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Button1: TButton;
    Panel2: TPanel;
    ListBox1: TListBox;
    Label3: TLabel;
    ListBox2: TListBox;
    Button3: TButton;
    Label4: TLabel;
    Button2: TButton;
    ListBox3: TListBox;
    Button4: TButton;
    StyleBook1: TStyleBook;
    ActionList1: TActionList;
    Action1: TAction;
    StringGrid1: TStringGrid;
    IntegerColumn1: TIntegerColumn;
    IntegerColumn2: TIntegerColumn;
    IntegerColumn3: TIntegerColumn;
    TimeColumn1: TTimeColumn;
    CheckColumn1: TCheckColumn;
    IntegerColumn4: TIntegerColumn;
    Action2: TAction;
    Action3: TAction;
    StringColumn1: TStringColumn;
    FDQuery2: TFDQuery;
    Panel3: TPanel;
    Button5: TButton;
    FDTable1timedata: TWideMemoField;
    procedure RadioButton1Change(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Grid1DragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; const ACol, ARow: integer;
      var CanSelect: Boolean);
    procedure StringGrid1EditingDone(Sender: TObject;
      const ACol, ARow: integer);
    procedure Button5Click(Sender: TObject);
  private
    { private 宣言 }
    procedure ListItemClear(AList: TListBox);
  public
    { public 宣言 }
  end;

var
  Form7: TForm7;

implementation

{$R *.fmx}

uses info, FMX.DialogService;

const
  SQL = 'select tableid, orderid, item.name, kitchen.qty, timedata, status from kitchen, item where kitchen.id = item.id %s order by orderid asc;';

procedure TForm7.Action1Execute(Sender: TObject);
var
  s: string;
begin
  ComboBox1.Items.Clear;
  ComboBox1.Items.Add('テーブル番号で選択してください');
  ComboBox1.ItemIndex := 0;
  FDTable1.Filter := 'status = 2';
  FDTable1.First;
  while not FDTable1.Eof do
  begin
    s := FDTable1.FieldByName('tableID').AsString;
    if ComboBox1.Items.IndexOf(s) = -1 then
      ComboBox1.Items.Add(s);
    FDTable1.Next;
  end;

  if RadioButton1.IsChecked then
    Action2.Execute
  else
    Action3.Execute;
  Timer1Timer(nil);
end;

procedure TForm7.Action2Execute(Sender: TObject);
const
  fmt = '%d 番テーブル %s x%d';
var
  local: TLocalClass;
  item: TListBoxItem;
  s: string;
begin
  ListBox3.Clear;
  ListItemClear(ListBox1);
  FDTable1.Filter := 'status = 0';
  FDTable1.Filtered := true;
  FDTable1.First;
  while not FDTable1.Eof do
  begin
    s := Format(fmt, [FDTable1.FieldByName('tableID').AsInteger,
      FDTable2.FieldByName('name').AsString, FDTable1.FieldByName('qty')
      .AsInteger]);
    local := TLocalClass.Create;
    local.orderID := FDTable1.FieldByName('orderID').AsInteger;
    item := TListBoxItem.Create(Self);
    item.Parent := ListBox1;
    item.TagObject := local;
    item.StyledSettings := item.StyledSettings - [TStyledSetting.Size];
    item.TextSettings.Font.Size := 35;
    item.Height := 35;
    item.Text := s;
    FDTable1.Next;
  end;
  for var n := 0 to ListBox2.count - 1 do
  begin
    item := ListBox2.ListItems[n];
    local := item.TagObject as TLocalClass;
    if GetTime - local.time > 5 / (24 * 60) then
    begin
      local.Free;
      item.Free;
    end;
  end;
end;

procedure TForm7.Action3Execute(Sender: TObject);
var
  cnt: integer;
begin
  FDQuery2.Close;
  if RadioButton2.IsChecked then
    FDQuery2.SQL.Text := Format(SQL, [' and status = 2 '])
  else
    FDQuery2.SQL.Text := Format(SQL, ['']);
  for var j := 0 to StringGrid1.RowCount - 1 do
    for var i := 0 to StringGrid1.ColumnCount - 1 do
      StringGrid1.Cells[i, j] := '';
  cnt := 0;
  FDQuery2.Open;
  while not FDQuery2.Eof do
  begin
    StringGrid1.Cells[0, cnt] := FDQuery2.Fields[0].AsString;
    StringGrid1.Cells[1, cnt] := FDQuery2.Fields[1].AsString;
    StringGrid1.Cells[2, cnt] := FDQuery2.Fields[2].AsString;
    StringGrid1.Cells[3, cnt] := FDQuery2.Fields[3].AsString;
    StringGrid1.Cells[4, cnt] := FDQuery2.Fields[4].AsString;
    StringGrid1.Cells[5, cnt] := FDQuery2.Fields[5].AsString;
    StringGrid1.Cells[6, cnt] := '';
    FDQuery2.Next;
    inc(cnt);
  end;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
  if ComboBox1.ItemIndex < 1 then
    Exit;
  FDTable1.First;
  while not FDTable1.Eof do
  begin
    FDTable1.Edit;
    FDTable1.FieldByName('status').AsInteger := Ord(TOrderStatus.archive);
    FDTable1.Post;
  end;
  Action1.Execute;
end;

procedure TForm7.Button3Click(Sender: TObject);
var
  i: integer;
  local: TLocalClass;
  item: TListBoxItem;
begin
  if ListBox1.ItemIndex = -1 then
    Exit;
  i := ListBox1.ItemIndex;
  item := ListBox1.ListItems[i];
  item.Parent := ListBox2;
  item.TextSettings.Font.Size := 15;
  item.Height := 15;
  local := item.TagObject as TLocalClass;
  local.time := GetTime;
  if FDTable1.Locate('orderID', local.orderID) then
  begin
    FDTable1.Edit;
    FDTable1.FieldByName('status').AsInteger := Ord(TOrderStatus.eating);
    FDTable1.Post;
  end;
end;

procedure TForm7.Button4Click(Sender: TObject);
begin
  FDQuery1.SQL.Text := 'select count(*) as cnt from kitchen where status < 4;';
  FDQuery1.Open;
  if FDQuery1.FieldByName('cnt').AsInteger = 0 then
  begin
    FDTable1.First;
    while not FDTable1.Eof do
      FDTable1.Delete;
    Showmessage('終了. おつかれさまでした.');
  end
  else
    Showmessage('オーダーや支払い状態が不正です');
  FDQuery1.Close;
  Action1.Execute;
end;

procedure TForm7.Button5Click(Sender: TObject);
begin
  for var i := 0 to StringGrid1.RowCount - 1 do
    if (StringGrid1.Cells[6, i] = 'false') and
      FDQuery2.Locate('orderID', StringGrid1.Cells[1, i]) then
      FDQuery2.Delete;
  Action1.Execute;
end;

procedure TForm7.ComboBox1Change(Sender: TObject);
var
  cnt, num, total: integer;
  local: TLocalClass;
  item: TListBoxItem;
  kind: string;
begin
  ListBox3.Clear;
  if ComboBox1.ItemIndex < 1 then
    Exit;
  FDTable1.Filter := 'status = 2 and tableID = ' + ComboBox1.Items
    [ComboBox1.ItemIndex];
  kind := '';
  FDTable1.First;
  while not FDTable1.Eof do
  begin
    cnt := FDTable1.FieldByName('qty').AsInteger;
    FDTable2.First;
    while not FDTable2.Eof do
    begin
      kind := FDTable2.FieldByName('name').AsString;
      num := ListBox3.Items.IndexOf(kind);
      if num = -1 then
      begin
        local := TLocalClass.Create;
        local.count := cnt;
        local.price := FDTable2.FieldByName('price').AsInteger;
        item := TListBoxItem.Create(ListBox3);
        item.Parent := ListBox3;
        item.Text := kind;
        item.TagObject := local;
      end
      else
      begin
        local := ListBox3.ListItems[num].TagObject as TLocalClass;
        local.count := Local.count + cnt;
      end;
      FDTable2.Next;
    end;
    FDTable1.Next;
  end;
  total := 0;
  for var i := 0 to ListBox3.count - 1 do
  begin
    local := ListBox3.ListItems[i].TagObject as TLocalClass;
    ListBox3.Items[i] := Format('%s  x %d = %d',
      [ListBox3.Items[i], local.count, local.count * local.price]);
    inc(total, local.count * local.price);
    local.Free;
  end;
  Button1.Text := total.ToString + ' 円';
  ListBox3.Items.Add('----------------------');
  ListBox3.Items.Add(Button1.Text);
end;

procedure TForm7.FormDestroy(Sender: TObject);
begin
  ListItemClear(ListBox1);
  ListItemClear(ListBox2);
end;

procedure TForm7.Grid1DragDrop(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
begin
  FDQuery1.Delete;
end;

procedure TForm7.ListItemClear(AList: TListBox);
begin
  for var i := 0 to AList.count - 1 do
    if Assigned(AList.ListItems[i].TagObject) then
      AList.ListItems[i].TagObject.Free;
  AList.Clear;
end;

procedure TForm7.RadioButton1Change(Sender: TObject);
var
  s: string;
begin
  Panel1.Visible := false;
  ListBox3.Visible := false;

  Panel2.Visible := false;
  StringGrid1.Visible := false;
  Panel3.Visible := false;
  Timer1.Enabled := true;
  if RadioButton1.IsChecked then
  begin
    FDTable1.IndexFieldNames := 'orderID';
    FDTable1.Filter := 'status = 0';
    FDTable1.Filtered := true;
    Panel2.Visible := true;
  end
  else if RadioButton2.IsChecked then
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
    Panel1.Visible := true;;
    StringGrid1.Visible := true;
    StringGrid1.ReadOnly := true;
    ListBox3.Visible := true;
  end
  else if RadioButton3.IsChecked then
  begin
    FDTable1.IndexFieldNames := 'timedata';
    FDTable1.Filtered := false;
    StringGrid1.Visible := true;
    StringGrid1.ReadOnly := false;
    Panel3.Visible := true;
    Timer1.Enabled := false;
  end;
  Action1.Execute;
end;

procedure TForm7.StringGrid1EditingDone(Sender: TObject;
  const ACol, ARow: integer);
begin
  if (StringGrid1.ColumnByIndex(ACol).Header = 'status') and
    FDQuery2.Locate('orderID', StringGrid1.Cells[1, ARow]) then
  begin
    FDQuery2.Edit;
    FDQuery2.Fields[ACol].AsString := StringGrid1.Cells[ACol, ARow];
    FDQuery2.Post;
  end;
end;

procedure TForm7.StringGrid1SelectCell(Sender: TObject;
  const ACol, ARow: integer; var CanSelect: Boolean);
var
  s: string;
begin
  if (ACol <> 6) or (StringGrid1.Cells[1, ARow] = '') then
    Exit;
  CanSelect := false;
  s := StringGrid1.Cells[ACol, ARow];
  if s = '' then
    s := 'false'
  else
    s := '';
  StringGrid1.Cells[ACol, ARow] := s;
end;

procedure TForm7.Timer1Timer(Sender: TObject);
var
  cnt: integer;
begin
  cnt := 0;
  if RadioButton1.IsChecked then
  begin
    FDQuery1.SQL.Text := 'select count(*) from kitchen where status = 0;';
    cnt := ListBox3.count;
  end
  else if RadioButton2.IsChecked then
  begin
    FDQuery1.SQL.Text := 'select count(*) from kitchen where status = 2;';
    cnt := 0;
  end;
  FDQuery1.Open;
  if FDQuery1.Fields[0].AsInteger > cnt then
    Button2.Text := '更新'
  else
    Button2.Text := '';
  FDQuery1.Close;
end;

procedure TForm7.Timer2Timer(Sender: TObject);
begin
  if not FDQuery1.Active then
  begin
    FDQuery1.Open('select count(*) as cnt from kitchen where status = 3');
    Label4.Visible := FDQuery1.FieldByName('cnt').AsInteger > 0;
    FDQuery1.Close;
  end;
end;

end.
