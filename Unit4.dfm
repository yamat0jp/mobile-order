object Form3: TForm3
  Width = 640
  Height = 480
  object WebPanel1: TWebPanel
    Left = 490
    Top = 0
    Width = 150
    Height = 480
    Align = alRight
    Caption = 'WebPanel1'
    TabOrder = 0
    ExplicitLeft = 248
    ExplicitTop = 208
    ExplicitHeight = 60
    object WebLabel5: TWebLabel
      Left = 48
      Top = 232
      Width = 58
      Height = 15
      Caption = 'WebLabel5'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebButton1: TWebButton
      Left = 32
      Top = 316
      Width = 96
      Height = 25
      Caption = 'WebButton1'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = WebButton1Click
    end
    object WebSpinEdit1: TWebSpinEdit
      Left = 64
      Top = 169
      Width = 54
      Height = 22
      AutoSize = False
      BorderStyle = bsSingle
      ChildOrder = 1
      Color = clWhite
      Increment = 1
      MaxValue = 10
      MinValue = 1
      Role = ''
      Value = 0
      OnChange = WebSpinEdit1Change
    end
    object WebButton2: TWebButton
      Left = 32
      Top = 384
      Width = 96
      Height = 25
      Caption = 'WebButton2'
      ChildOrder = 2
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = WebButton2Click
    end
  end
  object WebPanel2: TWebPanel
    Left = 0
    Top = 0
    Width = 490
    Height = 480
    Align = alClient
    Caption = 'WebPanel2'
    ChildOrder = 1
    TabOrder = 1
    ExplicitLeft = 248
    ExplicitTop = 208
    ExplicitWidth = 150
    ExplicitHeight = 60
    object WebImageControl1: TWebImageControl
      Left = 304
      Top = 80
      Width = 100
      Height = 96
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebLabel1: TWebLabel
      Left = 160
      Top = 176
      Width = 58
      Height = 15
      Caption = 'WebLabel1'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebLabel2: TWebLabel
      Left = 160
      Top = 211
      Width = 58
      Height = 15
      Caption = 'WebLabel2'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebLabel3: TWebLabel
      Left = 160
      Top = 253
      Width = 58
      Height = 15
      Caption = 'WebLabel3'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebLabel4: TWebLabel
      Left = 288
      Top = 248
      Width = 58
      Height = 15
      Caption = 'WebLabel4'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
  end
  object WebHttpRequest1: TWebHttpRequest
    Command = httpPOST
    URL = 'lhttp://localhost:8080/order'
    Left = 432
    Top = 208
  end
end
