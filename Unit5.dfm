object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'DataBase'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  TextHeight = 15
  object Image1: TImage
    Left = 344
    Top = 48
    Width = 105
    Height = 105
    Proportional = True
    Stretch = True
  end
  object Label1: TLabel
    Left = 36
    Top = 72
    Width = 37
    Height = 15
    Caption = #12459#12486#12468#12522
  end
  object Label2: TLabel
    Left = 40
    Top = 123
    Width = 26
    Height = 15
    Caption = #21517#31216
  end
  object Label3: TLabel
    Left = 40
    Top = 179
    Width = 26
    Height = 15
    Caption = #20385#26684
  end
  object Label4: TLabel
    Left = 40
    Top = 235
    Width = 26
    Height = 15
    Caption = #21336#20301
  end
  object Label5: TLabel
    Left = 40
    Top = 291
    Width = 26
    Height = 15
    Caption = #22312#24235
  end
  object Label6: TLabel
    Left = 250
    Top = 72
    Width = 3
    Height = 15
  end
  object Label7: TLabel
    Left = 491
    Top = 208
    Width = 56
    Height = 15
    Caption = #30331#37682#12508#12479#12531
  end
  object Button1: TButton
    Left = 360
    Top = 183
    Width = 75
    Height = 25
    Caption = #36984#25246
    TabOrder = 7
    TabStop = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 472
    Top = 336
    Width = 75
    Height = 25
    Caption = #32066#20102
    TabOrder = 8
    OnClick = Button2Click
  end
  object DBNavigator1: TDBNavigator
    Left = 283
    Top = 240
    Width = 240
    Height = 25
    DataSource = DataModule3.DataSource1
    TabOrder = 6
  end
  object Edit1: TEdit
    Left = 88
    Top = 69
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 88
    Top = 120
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 88
    Top = 176
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 250
    Top = 312
    Width = 185
    Height = 89
    TabOrder = 5
  end
  object Edit4: TEdit
    Left = 88
    Top = 232
    Width = 121
    Height = 23
    TabOrder = 3
  end
  object Edit5: TEdit
    Left = 88
    Top = 288
    Width = 121
    Height = 23
    TabOrder = 4
    OnChange = Edit5Change
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = DataModule3.FDTable1
    ScopeMappings = <>
    Left = 264
    Top = 184
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
    object LinkControlToField1: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB1
      FieldName = 'category'
      Control = Edit1
      Track = True
    end
    object LinkControlToField2: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB1
      FieldName = 'name'
      Control = Edit2
      Track = True
    end
    object LinkControlToField3: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB1
      FieldName = 'price'
      Control = Edit3
      Track = True
    end
    object LinkControlToField4: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB1
      FieldName = 'comment'
      Control = Memo1
      Track = False
    end
    object LinkControlToField5: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB1
      FieldName = 'image'
      Control = Image1
      Track = False
    end
    object LinkControlToField6: TLinkControlToField
      Category = #12463#12452#12483#12463' '#12496#12452#12531#12487#12451#12531#12464
      DataSource = BindSourceDB1
      FieldName = 'qty'
      Control = Edit4
      Track = True
    end
    object LinkControlToField7: TLinkControlToField
      DataSource = BindSourceDB1
      FieldName = 'cnt'
      Control = Edit5
      Track = True
    end
    object LinkPropertyToField1: TLinkPropertyToField
      DataSource = BindSourceDB1
      FieldName = 'id'
      Component = Label6
      ComponentProperty = 'Caption'
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 368
    Top = 120
  end
  object MainMenu1: TMainMenu
    Left = 256
    Top = 8
    object N1: TMenuItem
      Caption = #21021#26399#35373#23450
      object N2: TMenuItem
        Caption = #12486#12540#12502#12523#30058#21495
        OnClick = N2Click
      end
    end
  end
end
