unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.ExtDlgs, Vcl.StdCtrls,
  Vcl.ExtCtrls, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet,
  Data.Bind.Components, Data.Bind.DBScope, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Vcl.Imaging.pngimage, Vcl.Menus;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DBNavigator1: TDBNavigator;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo1: TMemo;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    Edit4: TEdit;
    Image1: TImage;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    OpenPictureDialog1: TOpenPictureDialog;
    Edit5: TEdit;
    LinkControlToField7: TLinkControlToField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LinkPropertyToField1: TLinkPropertyToField;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private 宣言 }
    procedure Barcode(min, max: integer);
  public
    { Public 宣言 }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses Unit3, Jpeg, OKCANCL2, Winapi.ShellAPI, DelphiZXingQRCode;

procedure GenerateQRCode(const Text: string; const Stream: TStream;
  Size: integer = 300);
var
  QRCode: TDelphiZXingQRCode;
  Bitmap: TBitmap;
  Row, Col: integer;
begin
  QRCode := TDelphiZXingQRCode.Create;
  try
    QRCode.Data := Text; // QRコードに埋め込む文字列（URL、テキストなど）
    // QRCode.Encoding := TQRCodeEncoding.Auto; // または Numeric, Alphanumeric, UTF8 など
    QRCode.QuietZone := 4; // 余白（Quiet Zone）
    // QRCode.ErrorCorrectionLevel := TQRCodeErrorCorrectionLevel.M; // L/M/Q/H で調整可能

    Bitmap := TBitmap.Create;
    try
      Bitmap.SetSize(QRCode.Columns, QRCode.Rows); // QRのドットサイズに合わせる
      Bitmap.Canvas.Brush.Color := clWhite;
      Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));

      for Row := 0 to QRCode.Rows - 1 do
        for Col := 0 to QRCode.Columns - 1 do
          if QRCode.IsBlack[Row, Col] then
            Bitmap.Canvas.Pixels[Col, Row] := clBlack;

      // サイズを拡大（見た目を良くするため）
      with TBitmap.Create do
        try
          SetSize(Size, Size);
          Canvas.StretchDraw(Rect(0, 0, Width, Height), Bitmap);
          SaveToStream(Stream); // PNG/BMPなどで保存
        finally
          Free;
        end;
    finally
      Bitmap.Free;
    end;
  finally
    QRCode.Free;
  end;
end;

procedure TForm5.Barcode(min, max: integer);
const
  A4Width = 2480; // 300dpi
  A4Height = 3508;
  QRSize = 300; // 1個のQRコードのサイズ
var
  bmpA4: TBitmap;
  QRbmp: TBitmap;
  st: TMemoryStream;
  pos: TPoint;
  num: integer;
begin
  // A4キャンバス
  bmpA4 := TBitmap.Create;
  bmpA4.SetSize(A4Width, A4Height);
  bmpA4.Canvas.Font.Size := 50;
  bmpA4.Canvas.Font.Color := clGreen;
  bmpA4.Canvas.Brush.Color := clWhite;
  bmpA4.Canvas.FillRect(Rect(0, 0, A4Width, A4Height));

  st := TMemoryStream.Create;
  // QRコード生成

  QRbmp := TBitmap.Create;
  QRbmp.SetSize(QRSize, QRSize);
  bmpA4.Canvas.PenPos := TPoint.Create(10, 20);
  for var i := min to max do
    with bmpA4.Canvas do
    begin
      pos := PenPos;
      TextOut(pos.X + QRSize div 2, pos.Y, i.ToString);
      st.Position := 0;
      GenerateQRCode('http://192.168.68.54:8080/uid?table=' +
        i.ToString, st);
      st.Position := 0;
      QRbmp.LoadFromStream(st);
      num := pos.Y + Font.Size + 25;
      Draw(pos.X, num, QRbmp);
      if pos.X + 2 * QRSize > bmpA4.Width then
      begin
        pos.X := 0;
        pos.Y := num + QRSize;
        PenPos := pos;
      end
      else
      begin
        pos.X := pos.X + QRSize;
        PenPos := pos;
      end;
    end;

  bmpA4.SaveToFile('A4_QR.png');

  st.Free;
  QRbmp.Free;
  bmpA4.Free;
end;

procedure TForm5.Button1Click(Sender: TObject);
var
  png: TPngImage;
  pic: TPicture;
  bmp: TBitmap;
begin
  if OpenPictureDialog1.Execute then
  begin
    pic := TPicture.Create;
    bmp := TBitmap.Create;
    png := TPngImage.Create;
    try
      pic.LoadFromFile(OpenPictureDialog1.FileName);
      bmp.Assign(pic.Graphic);
      png.Assign(bmp);
      Image1.Picture.Assign(png);
    finally
      png.Free;
      bmp.Free;
      pic.Free;
    end;
  end;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm5.Edit5Change(Sender: TObject);
begin
  if Edit5.Text = '0' then
    Edit5.Color := clActiveCaption
  else
    Edit5.Color := clWindow;
end;

procedure TForm5.N2Click(Sender: TObject);
begin
  if OKRightDlg.ShowModal = mrOK then
  begin
    Barcode(StrToInt(OKRightDlg.Edit1.Text), StrToInt(OKRightDlg.Edit2.Text));
    ShellExecute(0, 'open', PChar('A4_QR.png'), nil, nil, SW_SHOWNORMAL);
  end;
end;

end.
