object Form2: TForm2
  Width = 733
  Height = 608
  OnCreate = WebFormCreate
  OnDestroy = WebFormDestroy
  object WebPanel2: TWebPanel
    Left = 375
    Top = 0
    Width = 358
    Height = 608
    Align = alRight
    Caption = 'WebPanel2'
    ChildOrder = 2
    TabOrder = 0
    object WebPanel3: TWebPanel
      Left = 0
      Top = 496
      Width = 358
      Height = 112
      Align = alBottom
      Caption = 'WebPanel3'
      ChildOrder = 1
      TabOrder = 0
      object WebLabel4: TWebLabel
        Left = 32
        Top = 16
        Width = 58
        Height = 15
        Caption = 'WebLabel4'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebLabel5: TWebLabel
        Left = 136
        Top = 16
        Width = 58
        Height = 15
        Caption = 'WebLabel5'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebButton1: TWebButton
        Left = 200
        Top = 56
        Width = 96
        Height = 25
        Caption = 'WebButton1'
        ChildOrder = 1
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        OnClick = WebButton1Click
      end
      object WebButton2: TWebButton
        Left = 48
        Top = 56
        Width = 96
        Height = 25
        Caption = 'WebButton2'
        ChildOrder = 3
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        OnClick = WebButton2Click
      end
    end
    object WebPanel1: TWebPanel
      Left = 0
      Top = 0
      Width = 358
      Height = 496
      Align = alClient
      Caption = 'WebPanel1'
      ChildOrder = 1
      TabOrder = 1
      object WebImageControl1: TWebImageControl
        Left = 144
        Top = 81
        Width = 177
        Height = 169
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebLabel1: TWebLabel
        Left = 56
        Top = 136
        Width = 58
        Height = 15
        Caption = 'WebLabel1'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebLabel2: TWebLabel
        Left = 56
        Top = 176
        Width = 58
        Height = 15
        Caption = 'WebLabel2'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebLabel3: TWebLabel
        Left = 88
        Top = 328
        Width = 58
        Height = 15
        Caption = 'WebLabel3'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebLabel6: TWebLabel
        Left = 224
        Top = 328
        Width = 58
        Height = 15
        Caption = 'WebLabel6'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
    end
  end
  object WebListControl1: TWebListControl
    Left = 0
    Top = 0
    Width = 375
    Height = 608
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    Align = alClient
    ChildOrder = 2
    Items = <
      item
        Items = <>
        Text = 'Item 0'
      end
      item
        Items = <>
        Text = 'Item 1'
      end
      item
        Items = <>
        Text = 'Item 2'
      end
      item
        Items = <>
      end
      item
        Items = <>
      end
      item
        Items = <>
      end
      item
        Items = <>
      end
      item
        Items = <>
      end
      item
        Items = <>
      end
      item
        Items = <>
      end
      item
        Items = <>
      end
      item
        Items = <>
      end
      item
        Items = <>
      end
      item
        Items = <>
      end>
    OnItemClick = WebListControl1ItemClick
  end
  object WebHttpRequest1: TWebHttpRequest
    Command = httpPOST
    Headers.Strings = (
      'Content-Type=application/json')
    URL = 'http://localhost:8080/checkout'
    Left = 320
    Top = 288
  end
end
