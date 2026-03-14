unit data;

interface

uses WEBLib.JSON;

type
  TOrderData = class
  private
    FName: string;
    FPrice: integer;
    FQty: string;
    FCount: integer;
    FId: string;
  public
    constructor Create(ajson: TJSONObject); virtual;
    function toJson: TJSONObject;
    procedure Assign(AData: TOrderData);
    property Id: string read FId write FId;
    property name: string read FName write FName;
    property qty: string read FQty write FQty;
    property price: integer read FPrice write FPrice;
    property count: integer read FCount write FCount;
  end;

implementation

{ TOrderData }

procedure TOrderData.Assign(AData: TOrderData);
begin
  FId:=AData.Id;
  FName:=AData.name;
  FQty:=AData.qty;
  FPrice:=AData.price;
  FCount:=AData.count;
end;

constructor TOrderData.Create(ajson: TJSONObject);
begin
  inherited Create;
  FId := ajson.Values['Id'].ToString;
  FName := ajson.Values['name'].ToString;
  FQty := ajson.Values['qty'].ToString;
  FPrice := (ajson.Values['price'] as TJSONNumber).AsInt;
  FCount := (ajson.Values['count'] as TJSONNumber).AsInt;
end;

function TOrderData.toJson: TJSONObject;
begin
  result := TJSONObject.Create;
  result.AddPair('id', FId);
  result.AddPair('name', FName);
  result.AddPair('qty', FQty);
  result.AddPair('price', FPrice);
  result.AddPair('count', FCount);
end;

end.
