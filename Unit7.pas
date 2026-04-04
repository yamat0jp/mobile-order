unit Unit7;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListBox, FMX.Layouts, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, Data.Bind.EngExt, FMX.Bind.DBEngExt, FMX.Bind.Grid,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, System.Actions, FMX.ActnList,
  ZAbstractTable, ZDataset, ZAbstractRODataset, ZAbstractDataset,
  ZAbstractConnection, ZConnection;

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
    DataSource1: TDataSource;
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
    ListBoxItem1: TListBoxItem;
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
    Panel3: TPanel;
    Button5: TButton;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    ZTable1: TZTable;
    ZTable2: TZTable;
    ZTable1tableid: TZIntegerField;
    ZTable1orderid: TZIntegerField;
    ZTable1id: TZIntegerField;
    ZTable1qty: TZIntegerField;
    ZTable1timedata: TZUnicodeCLobField;
    ZTable1status: TZIntegerField;
    ZTable2id: TZIntegerField;
    ZTable2category: TZUnicodeCLobField;
    ZTable2name: TZUnicodeCLobField;
    ZTable2comment: TZUnicodeCLobField;
    ZTable2price: TZIntegerField;
    ZTable2qty: TZIntegerField;
    ZTable2cnt: TZIntegerField;
    ZTable2fileext: TZUnicodeCLobField;
    ZTable2image: TZBlobField;
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
begin
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
  ZTable1.Filter := 'status = 0';
  ZTable1.Filtered := true;
  ZTable1.First;
  while not ZTable1.Eof do
  begin
    s := Format(fmt, [ZTable1.FieldByName('tableID').AsInteger,
      ZTable2.FieldByName('name').AsString, ZTable1.FieldByName('qty')
      .AsInteger]);
    local := TLocalClass.Create;
    local.orderID := ZTable1.FieldByName('orderID').AsInteger;
    item := TListBoxItem.Create(Self);
    item.Parent := ListBox1;
    item.TagObject := local;
    item.StyledSettings := item.StyledSettings - [TStyledSetting.Size];
    item.TextSettings.Font.Size := 35;
    item.Height := 35;
    item.Text := s;
    ZTable1.Next;
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
  ZQuery2.Close;
  if RadioButton2.IsChecked then
    ZQuery2.SQL.Text := Format(SQL, [' and status = 2 '])
  else
    ZQuery2.SQL.Text := Format(SQL, ['']);
  for var j := 0 to StringGrid1.RowCount - 1 do
    for var i := 0 to StringGrid1.ColumnCount - 1 do
      StringGrid1.Cells[i, j] := '';
  cnt := 0;
  ZQuery2.Open;
  while not ZQuery2.Eof do
  begin
    StringGrid1.Cells[0, cnt] := ZQuery2.Fields[0].AsString;
    StringGrid1.Cells[1, cnt] := ZQuery2.Fields[1].AsString;
    StringGrid1.Cells[2, cnt] := ZQuery2.Fields[2].AsString;
    StringGrid1.Cells[3, cnt] := ZQuery2.Fields[3].AsString;
    StringGrid1.Cells[4, cnt] := ZQuery2.Fields[4].AsString;
    StringGrid1.Cells[5, cnt] := ZQuery2.Fields[5].AsString;
    StringGrid1.Cells[6, cnt] := '';
    ZQuery2.Next;
    inc(cnt);
  end;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
  if ComboBox1.ItemIndex < 1 then
    Exit;
  ZTable1.First;
  while not ZTable1.Eof do
  begin
    ZTable1.Edit;
    ZTable1.FieldByName('status').AsInteger := Ord(TOrderStatus.archive);
    ZTable1.Post;
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
  if ZTable1.Locate('orderID', local.orderID,[]) then
  begin
    ZTable1.Edit;
    ZTable1.FieldByName('status').AsInteger := Ord(TOrderStatus.eating);
    ZTable1.Post;
  end;
end;

procedure TForm7.Button4Click(Sender: TObject);
begin
  ZQuery1.SQL.Text := 'select count(*) as cnt from kitchen where status < 4;';
  ZQuery1.Open;
  if ZQuery1.FieldByName('cnt').AsInteger = 0 then
  begin
    ZTable1.First;
    while not ZTable1.Eof do
      ZTable1.Delete;
    Showmessage('終了. おつかれさまでした.');
  end
  else
    Showmessage('オーダーや支払い状態が不正です');
  ZQuery1.Close;
  Action1.Execute;
end;

procedure TForm7.Button5Click(Sender: TObject);
begin
  for var i := 0 to StringGrid1.RowCount - 1 do
    if (StringGrid1.Cells[6, i] = 'false') and
      ZQuery2.Locate('orderID', StringGrid1.Cells[1, i],[]) then
      ZQuery2.Delete;
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
  ZTable1.Filter := 'status = 2 and tableID = ' + ComboBox1.Items
    [ComboBox1.ItemIndex];
  kind := '';
  ZTable1.First;
  while not ZTable1.Eof do
  begin
    cnt := ZTable1.FieldByName('qty').AsInteger;
    ZTable2.First;
    while not ZTable2.Eof do
    begin
      kind := ZTable2.FieldByName('name').AsString;
      num := ListBox3.Items.IndexOf(kind);
      if num = -1 then
      begin
        local := TLocalClass.Create;
        local.count := cnt;
        local.price := ZTable2.FieldByName('price').AsInteger;
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
      ZTable2.Next;
    end;
    ZTable1.Next;
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
  ZQuery1.Delete;
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
  ComboBox1.ItemIndex := 0;

  Panel2.Visible := false;
  StringGrid1.Visible := false;
  Panel3.Visible := false;
  Timer1.Enabled := true;
  if RadioButton1.IsChecked then
  begin
    ZTable1.IndexFieldNames := 'orderID';
    ZTable1.Filter := 'status = 0';
    ZTable1.Filtered := true;
    Panel2.Visible := true;
  end
  else if RadioButton2.IsChecked then
  begin
    ListBox1.Items.Clear;
    ZTable1.IndexFieldNames := 'tableID';
    ZTable1.Filter := 'status = 2';
    ZTable1.Filtered := true;
    ZTable1.First;
    while not ZTable1.Eof do
    begin
      s := ZTable1.FieldByName('tableID').AsString;
      if ComboBox1.Items.IndexOf(s) = -1 then
        ComboBox1.Items.Add(s);
      ZTable1.Next;
    end;
    Panel1.Visible := true;;
    StringGrid1.Visible := true;
    StringGrid1.ReadOnly := true;
    ListBox3.Visible := true;
  end
  else if RadioButton3.IsChecked then
  begin
    ZTable1.IndexFieldNames := 'timedata';
    ZTable1.Filtered := false;
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
    ZQuery2.Locate('orderID', StringGrid1.Cells[1, ARow],[]) then
  begin
    ZQuery2.Edit;
    ZQuery2.Fields[ACol].AsString := StringGrid1.Cells[ACol, ARow];
    ZQuery2.Post;
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
    ZQuery1.SQL.Text := 'select count(*) from kitchen where status = 0;';
    cnt := ListBox3.count;
  end
  else if RadioButton2.IsChecked then
  begin
    ZQuery1.SQL.Text := 'select count(*) from kitchen where status = 2;';
    cnt := 0;
  end;
  ZQuery1.Open;
  if ZQuery1.Fields[0].AsInteger > cnt then
    Button2.Text := '更新'
  else
    Button2.Text := '';
  ZQuery1.Close;
end;

procedure TForm7.Timer2Timer(Sender: TObject);
begin
  if not ZQuery1.Active then
  begin
    ZQuery1.SQL.Text:= 'select count(*) as cnt from kitchen where status = 3';
    ZQuery1.Open;
    Label4.Visible := ZQuery1.FieldByName('cnt').AsInteger > 0;
    ZQuery1.Close;
  end;
end;

end.
