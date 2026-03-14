unit Unit2;

interface

uses
  WEBLib.JSON, System.SysUtils, System.Classes, Web, WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ExtCtrls,
  WEBLib.StdCtrls, Vcl.StdCtrls, Vcl.Controls, WEBLib.REST, data;

type
  TForm2 = class(TWebForm)
    WebScrollBox1: TWebScrollBox;
    WebPanel1: TWebPanel;
    WebImageControl1: TWebImageControl;
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    WebLabel3: TWebLabel;
    WebPanel2: TWebPanel;
    WebPanel3: TWebPanel;
    WebLabel4: TWebLabel;
    WebButton1: TWebButton;
    WebButton2: TWebButton;
    WebSpinEdit1: TWebSpinEdit;
    WebLabel5: TWebLabel;
    WebButton3: TWebButton;
    WebHttpRequest1: TWebHttpRequest;
    procedure WebButton1Click(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
    procedure WebFormDestroy(Sender: TObject);
    procedure WebButton2Click(Sender: TObject);
    procedure WebButton3Click(Sender: TObject);
    procedure WebSpinEdit1Change(Sender: TObject);
    procedure WebFormShow(Sender: TObject);
  private
    { Private declarations }
    function GetTotalPrice: integer;
    procedure ShowData(Index: integer);
    function InOrder(const id: string): integer;
    procedure DeleteItem(id: integer);
  public
    { Public declarations }
    procedure AddItem(AOrder: TOrderData);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Unit3, System.IOUtils, System.Generics.Collections;

var
  ItemIndex: integer;
  List: TObjectList<TWebFrame>;
  orders: TObjectList<TOrderData>;

  { TForm2 }

procedure TForm2.AddItem(AOrder: TOrderData);
begin
  ItemIndex := InOrder(AOrder.id);
  if ItemIndex = -1 then
    orders.Add(AOrder)
  else
    orders[ItemIndex].count := orders[ItemIndex].count + AOrder.count;
end;

procedure TForm2.DeleteItem(id: integer);
begin
  List.Delete(id);
  orders.Delete(id);
  if List.count = 0 then
    ItemIndex := -1
  else
    ItemIndex := 0;
end;

function TForm2.GetTotalPrice: integer;
var
  I: integer;
begin
  result := 0;
  for I := 0 to orders.count - 1 do
    inc(result, orders[I].price * orders[I].count);
end;

function TForm2.InOrder(const id: string): integer;
var
  I: integer;
begin
  for I := 0 to orders.count - 1 do
    if orders[I].id = id then
      Exit(I);
  result := -1;
end;

procedure TForm2.ShowData(Index: integer);
begin
  WebLabel1.Caption := orders[index].name;
  WebLabel2.Caption := orders[index].qty;
end;

procedure TForm2.WebButton1Click(Sender: TObject);
var
  order: TJSONObject;
  Items: TJSONArray;
  I: integer;
begin
  order := TJSONObject.Create;
  order.AddPair('orderID', '00000-001');
  order.AddPair('userID', '');
  Items := TJSONArray.Create;
  for I := 0 to orders.count - 1 do
    Items.Add(orders[I].toJson);
  order.AddPair('items', Items);
  order.AddPair('total', GetTotalPrice);
  order.AddPair('timestamp', Now);
  order.AddPair('status', 'pending');
  WebHttpRequest1.PostData := order.ToString;
  WebHttpRequest1.Execute;
  Close;
end;

procedure TForm2.WebButton2Click(Sender: TObject);
begin
  DeleteItem(ItemIndex);
  if orders.count = 0 then
    Close
  else
  begin
    ItemIndex := 0;
    ShowData(ItemIndex);
    WebLabel5.Caption := GetTotalPrice.ToString;
  end;
end;

procedure TForm2.WebButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.WebFormCreate(Sender: TObject);
begin
  List := TObjectList<TWebFrame>.Create;
  orders := TObjectList<TOrderData>.Create;
  Name := '';
end;

procedure TForm2.WebFormDestroy(Sender: TObject);
begin
  List.Free;
  orders.Free;
end;

procedure TForm2.WebFormShow(Sender: TObject);
var
  obj: TFrame2;
  I: integer;
begin
  for I := 0 to orders.count - 1 do
  begin
    obj := TFrame2.Create(Self);
    obj.LoadFromForm;
    obj.Parent := WebScrollBox1;
    obj.Align := alTop;
    obj.WebLabel1.Caption := orders[I].name;
    obj.WebLabel2.Caption := orders[I].price.ToString;
    obj.WebLabel3.Caption := orders[I].count.ToString;
    List.Add(obj);
  end;
  WebLabel5.Caption := GetTotalPrice.ToString;
end;

procedure TForm2.WebSpinEdit1Change(Sender: TObject);
var
  obj: TFrame2;
  order: TOrderData;
begin
  obj := List[ItemIndex] as TFrame2;
  order := orders[ItemIndex];
  order.count := order.count + WebSpinEdit1.Value;
  obj.WebLabel3.Caption := order.count.ToString;
end;

end.
