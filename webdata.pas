unit webdata;

interface

uses WEBLib.JSON;

type
  TOrderData = class
  private
    FName: string;
    FPrice: integer;
    FQty: integer;
    FId: string;
    FCategory: string;
    FImageBase64: string;
    FComment: string;
    FCount: integer;
  public
    constructor Create(AJson: TJSONObject); overload;
    function toJson: TJSONObject;
    procedure Assign(AData: TOrderData);
    property Id: string read FId write FId;
    property name: string read FName write FName;
    property qty: integer read FQty write FQty;
    property count: integer read FCount write FCount;
    property price: integer read FPrice write FPrice;
    property comment: string read FComment write FComment;
    property category: string read FCategory write FCategory;
    property ImageBase64: string read FImageBase64 write FImageBase64;
  end;

implementation

{ TOrderData }

procedure TOrderData.Assign(AData: TOrderData);
begin
  FCategory := AData.category;
  FId := AData.Id;
  FName := AData.name;
  FQty := AData.qty;
  FCount := AData.count;
  FPrice := AData.price;
  FComment := AData.comment;
  FImageBase64 := AData.ImageBase64;
end;

constructor TOrderData.Create(AJson: TJSONObject);
begin
  inherited Create;
  FCategory := AJson.GetValue('category').ToString;
  FId := AJson.GetValue('id').ToString;
  FName := AJson.GetValue('name').ToString;
  FQty := (AJson.GetValue('qty') as TJSONNumber).AsInt;
  FCount := (AJson.GetValue('count') as TJSONNumber).AsInt;
  FPrice := (AJson.GetValue('price') as TJSONNumber).AsInt;
  FComment := AJson.GetValue('comment').ToString;
  FImageBase64 := AJson.GetValue('image').Value;
end;

function TOrderData.toJson: TJSONObject;
begin
  result := TJSONObject.Create;
  result.AddPair('category', FCategory);
  result.AddPair('id', FId);
  result.AddPair('name', FName);
  result.AddPair('qty', FQty);
  result.AddPair('count', FCount);
  result.AddPair('price', FPrice);
  result.AddPair('comment', FComment);
  result.AddPair('image', FImageBase64);
end;

end.
