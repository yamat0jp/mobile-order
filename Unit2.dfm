object Form2: TForm2
  Width = 838
  Height = 608
  OnCreate = WebFormCreate
  OnDestroy = WebFormDestroy
  OnShow = WebFormShow
  object WebPanel1: TWebPanel
    Left = 0
    Top = 0
    Width = 480
    Height = 608
    Align = alClient
    Caption = 'WebPanel1'
    ChildOrder = 1
    TabOrder = 0
    object WebImageControl1: TWebImageControl
      Left = 184
      Top = 48
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
      Top = 256
      Width = 58
      Height = 15
      Caption = 'WebLabel3'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebButton2: TWebButton
      Left = 160
      Top = 352
      Width = 96
      Height = 25
      Caption = 'WebButton2'
      ChildOrder = 4
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = WebButton2Click
    end
    object WebSpinEdit1: TWebSpinEdit
      Left = 224
      Top = 249
      Width = 46
      Height = 22
      AutoSize = False
      BorderStyle = bsSingle
      ChildOrder = 5
      Color = clWhite
      Increment = 1
      MaxValue = 10
      MinValue = 1
      Role = ''
      Value = 1
      OnChange = WebSpinEdit1Change
    end
    object WebButton4: TWebButton
      Left = 160
      Top = 408
      Width = 96
      Height = 25
      Caption = 'WebButton4'
      ChildOrder = 6
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = WebButton4Click
    end
  end
  object WebPanel2: TWebPanel
    Left = 480
    Top = 0
    Width = 358
    Height = 608
    Align = alRight
    Caption = 'WebPanel2'
    ChildOrder = 2
    TabOrder = 1
    object Frame2Parent: TWebScrollBox
      Left = 0
      Top = 0
      Width = 358
      Height = 496
      Align = alClient
      BorderStyle = bsSingle
      ScrollBars = ssVertical
    end
    object WebPanel3: TWebPanel
      Left = 0
      Top = 496
      Width = 358
      Height = 112
      Align = alBottom
      Caption = 'WebPanel3'
      ChildOrder = 1
      TabOrder = 1
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
        Left = 128
        Top = 64
        Width = 96
        Height = 25
        Caption = 'WebButton1'
        ChildOrder = 1
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        OnClick = WebButton1Click
      end
      object WebButton3: TWebButton
        Left = 18
        Top = 64
        Width = 96
        Height = 25
        Caption = 'WebButton3'
        ChildOrder = 3
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        OnClick = WebButton3Click
      end
    end
  end
  object WebHttpRequest1: TWebHttpRequest
    Command = httpPOST
    Headers.Strings = (
      'Content-Type:application/json')
    URL = 'http://'
    Left = 312
    Top = 296
  end
end
