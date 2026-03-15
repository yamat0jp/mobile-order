unit Unit2;

interface

uses
  WEBLib.JSON, System.SysUtils, System.Classes, Web, WEBLib.Graphics,
  System.Generics.Collections,
  WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ExtCtrls,
  WEBLib.StdCtrls, Vcl.StdCtrls, Vcl.Controls, WEBLib.REST, WEBLib.Lists, data;

type
  TForm2 = class(TWebForm)
    WebPanel1: TWebPanel;
    WebImageControl1: TWebImageControl;
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    WebLabel3: TWebLabel;
    WebPanel2: TWebPanel;
    WebPanel3: TWebPanel;
    WebLabel4: TWebLabel;
    WebButton1: TWebButton;
    WebLabel5: TWebLabel;
    WebHttpRequest1: TWebHttpRequest;
    WebLabel6: TWebLabel;
    WebButton2: TWebButton;
    WebListControl1: TWebListControl;
    procedure WebButton1Click(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
    procedure WebFormDestroy(Sender: TObject);
    procedure WebButton2Click(Sender: TObject);
    procedure WebListControl1ItemClick(Sender: TObject; AListItem: TListItem);
    procedure WebFormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    function GetTotalPrice: integer;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  List: TObjectList<TOrderData>;

implementation

{$R *.dfm}

uses System.IOUtils;

{ TForm2 }

function TForm2.GetTotalPrice: integer;
var
  I: integer;
  order: TOrderData;
begin
  result := 0;
  for I := 0 to WebListControl1.Items.count - 1 do
  begin
    order := List[WebListControl1.ItemIndex];
    inc(result, order.price * order.count);
  end;
end;

procedure TForm2.WebButton1Click(Sender: TObject);
var
  order: TJSONObject;
  Items: TJSONArray;
  I: integer;
begin
  order := TJSONObject.Create;
  try
    order.AddPair('orderID', '00000-001');
    order.AddPair('userID', '');
    Items := TJSONArray.Create;
    for I := 0 to List.count - 1 do
      Items.Add(List[I].toJson);
    order.AddPair('items', Items);
    order.AddPair('total', GetTotalPrice);
    order.AddPair('timestamp', Now);
    order.AddPair('status', 'pending');
    WebHttpRequest1.PostData := order.ToString;
    WebHttpRequest1.Execute;
  finally
    order.Free;
  end;
  Close;
end;

procedure TForm2.WebButton2Click(Sender: TObject);
begin
  Hide;
end;

procedure TForm2.WebFormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := false;
  Hide;
end;

procedure TForm2.WebFormCreate(Sender: TObject);
begin
  List := TObjectList<TOrderData>.Create;
  Name := '';
  WebLabel5.Caption := GetTotalPrice.ToString;
end;

procedure TForm2.WebFormDestroy(Sender: TObject);
begin
  List.Free;
end;

procedure TForm2.WebListControl1ItemClick(Sender: TObject;
  AListItem: TListItem);
var
  order: TOrderData;
begin
  order := List[WebListControl1.ItemIndex];
  WebLabel1.Caption := order.name;
  WebLabel2.Caption := order.qty;
end;

end.
