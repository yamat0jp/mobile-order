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
    constructor Create(AJson: TJSONObject); overload;
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
  FId := AData.Id;
  FName := AData.name;
  FQty := AData.qty;
  FPrice := AData.price;
  FCount := AData.count;
end;

constructor TOrderData.Create(AJson: TJSONObject);
begin
  inherited Create;
  FId := AJson.GetValue('id').ToString;
  FName := AJson.GetValue('name').ToString;
  FQty := AJson.GetValue('qty').ToString;
  FPrice := (AJson.GetValue('price') as TJSONNumber).AsInt;
  FCount := (AJson.GetValue('count') as TJSONNumber).AsInt;
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
