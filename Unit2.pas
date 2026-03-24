unit Unit2;

interface

uses
  WEBLib.JSON, System.SysUtils, System.Classes, Web, WEBLib.Graphics,
  System.Generics.Collections,
  WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ExtCtrls,
  WEBLib.StdCtrls, Vcl.StdCtrls, Vcl.Controls, WEBLib.REST, WEBLib.Lists,
  webdata;

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
    CashButton: TWebButton;
    WebLabel5: TWebLabel;
    WebHttpRequest1: TWebHttpRequest;
    WebLabel6: TWebLabel;
    CancelButton: TWebButton;
    WebListControl1: TWebListControl;
    WebPanel5: TWebPanel;
    WebScrollBox1: TWebScrollBox;
    procedure CashButtonClick(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
    procedure WebFormDestroy(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure WebListControl1ItemClick(Sender: TObject; AListItem: TListItem);
    procedure WebHttpRequest1Response(Sender: TObject; AResponse: string);
    procedure WebFormShow(Sender: TObject);
  private
    { Private declarations }
    function GetTotalPrice: integer;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  List: TObjectList<TAdvanceData>;

implementation

{$R *.dfm}

uses System.IOUtils, System.DateUtils, main;

{ TForm2 }

function TForm2.GetTotalPrice: integer;
var
  I: integer;
  order: TOrderData;
begin
  result := 0;
  for I := 0 to List.Count - 1 do
  begin
    order := List[I];
    inc(result, order.price * order.qty);
  end;
end;

procedure TForm2.CashButtonClick(Sender: TObject);
var
  order: TJSONObject;
begin
  order := TJSONObject.Create;
  try
    order.AddPair('userID', main.tableID);
    order.AddPair('status', 2);
    WebHttpRequest1.PostData := order.ToString;
    WebHttpRequest1.Execute;
  finally
    order.Free;
  end;
end;

procedure TForm2.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TForm2.WebFormCreate(Sender: TObject);
const
  detail = '%s x %d  Åè%d :: %s';
var
  I: integer;
  order: TAdvanceData;
begin
  for I := 0 to List.Count - 1 do
  begin
    order := List[I];
    WebListControl1.Items.Add.Text :=
      Format(detail, [order.name, order.qty, order.qty * order.price,
      order.time]);
  end;
  WebLabel1.Caption := '';
  WebLabel2.Caption := '';
  WebLabel6.Caption := '';
  WebImageControl1.URL := '';
end;

procedure TForm2.WebFormDestroy(Sender: TObject);
begin
  List.Free;
end;

procedure TForm2.WebFormShow(Sender: TObject);
begin
  if List.Count = 0 then
  begin
    CashButton.Enabled := false;
    WebPanel5.Visible := true;
  end
  else
  begin
    CashButton.Enabled := true;
    WebPanel5.Visible := false;
    WebListControl1ItemClick(nil, WebListControl1.Items[0]);
  end;
  WebLabel5.Caption := GetTotalPrice.ToString;
end;

procedure TForm2.WebHttpRequest1Response(Sender: TObject; AResponse: string);
begin
  ModalResult := mrOK;
  Close;
end;

procedure TForm2.WebListControl1ItemClick(Sender: TObject;
  AListItem: TListItem);
var
  order: TOrderData;
  I: integer;
begin
  for I := 0 to WebListControl1.Items.Count - 1 do
    if AListItem = WebListControl1.Items[I] then
    begin
      WebListControl1.ItemIndex := I;
      order := List[I];
      WebLabel1.Caption := order.name;
      WebLabel2.Caption := order.comment;
      WebLabel6.Caption := order.price.ToString;
      WebImageControl1.URL := order.ImageBase64;
    end;
end;

end.
