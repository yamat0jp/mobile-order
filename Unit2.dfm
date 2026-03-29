object Form2: TForm2
  Width = 743
  Height = 690
  ElementClassName = 'topbar'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  OnCreate = WebFormCreate
  OnDestroy = WebFormDestroy
  OnShow = WebFormShow
  object WebPanel2: TWebPanel
    Left = 385
    Top = 0
    Width = 358
    Height = 690
    Align = alRight
    ChildOrder = 2
    TabOrder = 0
    object WebPanel3: TWebPanel
      Left = 0
      Top = 546
      Width = 358
      Height = 144
      Align = alBottom
      ChildOrder = 1
      TabOrder = 0
      object WebLabel4: TWebLabel
        Left = 32
        Top = 16
        Width = 82
        Height = 21
        Caption = #12362#25903#25173#38989#65306
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebLabel5: TWebLabel
        Left = 136
        Top = 16
        Width = 77
        Height = 21
        Caption = 'WebLabel5'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object CashButton: TWebButton
        Left = 200
        Top = 64
        Width = 96
        Height = 25
        Caption = #12362#20250#35336
        ChildOrder = 1
        Default = True
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        OnClick = CashButtonClick
      end
      object CancelButton: TWebButton
        Left = 48
        Top = 64
        Width = 96
        Height = 25
        Cancel = True
        Caption = #25147#12427
        ChildOrder = 3
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        OnClick = CancelButtonClick
      end
    end
    object WebPanel1: TWebPanel
      Left = 0
      Top = 0
      Width = 358
      Height = 546
      Align = alClient
      ChildOrder = 1
      TabOrder = 1
      object WebImageControl1: TWebImageControl
        Left = 139
        Top = 136
        Width = 177
        Height = 169
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebLabel1: TWebLabel
        Left = 56
        Top = 56
        Width = 77
        Height = 21
        Caption = 'WebLabel1'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebLabel2: TWebLabel
        Left = 40
        Top = 328
        Width = 77
        Height = 21
        Caption = 'WebLabel2'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebLabel3: TWebLabel
        Left = 83
        Top = 455
        Width = 34
        Height = 21
        Caption = #21336#20385
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
      object WebLabel6: TWebLabel
        Left = 219
        Top = 455
        Width = 77
        Height = 21
        Caption = 'WebLabel6'
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
      end
    end
  end
  object WebScrollBox1: TWebScrollBox
    Left = 0
    Top = 0
    Width = 385
    Height = 690
    Align = alClient
    BorderStyle = bsSingle
    ChildOrder = 3
    object WebListControl1: TWebListControl
      Left = 0
      Top = 0
      Width = 385
      Height = 690
      ElementClassName = 'list-group'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      Align = alClient
      ChildOrder = 2
      DefaultItemClassName = 'list-group-item'
      Items = <>
      OnItemClick = WebListControl1ItemClick
    end
  end
  object WebPanel5: TWebPanel
    Left = 304
    Top = 272
    Width = 150
    Height = 60
    Caption = #12372#27880#25991#12364#12354#12426#12414#12379#12435
    ChildOrder = 2
    TabOrder = 1
  end
  object WebHttpRequest1: TWebHttpRequest
    Command = httpPOST
    Headers.Strings = (
      'Content-Type:application/json')
    URL = 'http://127.0.0.1:8080/checkout'
    OnResponse = WebHttpRequest1Response
    Left = 360
    Top = 392
  end
end
