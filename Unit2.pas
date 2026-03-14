unit Unit2;

interface

uses
  WEBLib.JSON, System.SysUtils, System.Classes, Web, WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ExtCtrls,
  WEBLib.StdCtrls, Vcl.StdCtrls, Vcl.Controls, WEBLib.REST, data;

type
  TForm2 = class(TWebForm)
    Frame2Parent: TWebScrollBox;
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
    WebButton4: TWebButton;
    procedure WebButton1Click(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
    procedure WebFormDestroy(Sender: TObject);
    procedure WebButton2Click(Sender: TObject);
    procedure WebButton3Click(Sender: TObject);
    procedure WebSpinEdit1Change(Sender: TObject);
    procedure WebFormShow(Sender: TObject);
    procedure WebButton4Click(Sender: TObject);
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
  List: TObjectList<TFrame2>;

  { TForm2 }

procedure TForm2.AddItem(AOrder: TOrderData);
begin
  ItemIndex := InOrder(AOrder.id);
  if ItemIndex = -1 then
  begin
    ItemIndex:=List.Add(TFrame2.Create(Self));
    List[ItemIndex].WriteOrder(AOrder);
  end
  else
    List[ItemIndex].Order.count := List[ItemIndex].Order.count + AOrder.count;
  ShowData(ItemIndex);
end;

procedure TForm2.DeleteItem(id: integer);
begin
  List.Delete(id);
  if List.count = 0 then
  begin
    ItemIndex := -1;
    Close;
  end
  else
  begin
    ItemIndex := 0;
    ShowData(ItemIndex);
  end;
end;

function TForm2.GetTotalPrice: integer;
var
  I: integer;
begin
  result := 0;
  for I := 0 to List.count - 1 do
    inc(result, List[I].Order.price * List[I].Order.count);
end;

function TForm2.InOrder(const id: string): integer;
var
  I: integer;
begin
  for I := 0 to List.count - 1 do
    if List[I].Order.id = id then
      Exit(I);
  result := -1;
end;

procedure TForm2.ShowData(Index: integer);
begin
  WebLabel1.Caption := List[index].Order.name;
  WebLabel2.Caption := List[index].Order.qty;
end;

procedure TForm2.WebButton1Click(Sender: TObject);
var
  Order: TJSONObject;
  Items: TJSONArray;
  I: integer;
begin
  Order := TJSONObject.Create;
  Order.AddPair('orderID', '00000-001');
  Order.AddPair('userID', '');
  Items := TJSONArray.Create;
  for I := 0 to List.count - 1 do
    Items.Add(List[I].Order.toJson);
  Order.AddPair('items', Items);
  Order.AddPair('total', GetTotalPrice);
  Order.AddPair('timestamp', Now);
  Order.AddPair('status', 'pending');
  WebHttpRequest1.PostData := Order.ToString;
  WebHttpRequest1.Execute;
  Close;
end;

procedure TForm2.WebButton2Click(Sender: TObject);
begin
  DeleteItem(ItemIndex);
  WebLabel5.Caption := GetTotalPrice.ToString;
end;

procedure TForm2.WebButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.WebButton4Click(Sender: TObject);
begin
  // Hide;
end;

procedure TForm2.WebFormCreate(Sender: TObject);
begin
  List := TObjectList<TFrame2>.Create;
  Name := '';
end;

procedure TForm2.WebFormDestroy(Sender: TObject);
begin
  List.Free;
end;

procedure TForm2.WebFormShow(Sender: TObject);
var
  obj: TFrame2;
  I: integer;
begin
  for I := 0 to List.count - 1 do
  begin
    obj := TFrame2.Create(Self);
    obj.LoadFromForm;
    obj.Parent := Frame2Parent;
    obj.Align := alTop;
    List.Add(obj);
  end;
  WebLabel5.Caption := GetTotalPrice.ToString;
end;

procedure TForm2.WebSpinEdit1Change(Sender: TObject);
var
  obj: TFrame2;
  Order: TOrderData;
begin
  obj := List[ItemIndex] as TFrame2;
  Order := List[ItemIndex].Order;
  Order.count := Order.count + WebSpinEdit1.Value;
  obj.WebLabel3.Caption := Order.count.ToString;
end;

end.
