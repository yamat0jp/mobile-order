object Form3: TForm3
  Width = 640
  Height = 480
  Color = clNone
  ElementClassName = 'dummy'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  OnShow = WebFormShow
  object WebPanel1: TWebPanel
    Left = 448
    Top = 0
    Width = 192
    Height = 480
    Align = alRight
    TabOrder = 0
    object WebLabel5: TWebLabel
      Left = 48
      Top = 232
      Width = 93
      Height = 25
      Caption = 'WebLabel5'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebButton1: TWebButton
      Left = 32
      Top = 316
      Width = 113
      Height = 37
      Caption = #27770#23450
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = WebButton1Click
    end
    object WebSpinEdit1: TWebSpinEdit
      Left = 64
      Top = 169
      Width = 54
      Height = 31
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
      Width = 113
      Height = 41
      Caption = #12461#12515#12531#12475#12523
      ChildOrder = 2
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = WebButton2Click
    end
  end
  object WebPanel2: TWebPanel
    Left = 0
    Top = 0
    Width = 448
    Height = 480
    Align = alClient
    ChildOrder = 1
    TabOrder = 1
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
      Width = 93
      Height = 25
      Caption = 'WebLabel1'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebLabel2: TWebLabel
      Left = 160
      Top = 211
      Width = 93
      Height = 25
      Caption = 'WebLabel2'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebLabel3: TWebLabel
      Left = 160
      Top = 253
      Width = 93
      Height = 25
      Caption = 'WebLabel3'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebLabel4: TWebLabel
      Left = 288
      Top = 248
      Width = 93
      Height = 25
      Caption = 'WebLabel4'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
  end
  object WebHttpRequest1: TWebHttpRequest
    Command = httpPUT
    Headers.Strings = (
      'Content-Type:application/json')
    Timeout = 3500
    URL = 'http://localhost:8080/order'
    OnError = WebHttpRequest1Error
    OnResponse = WebHttpRequest1Response
    OnTimeout = WebHttpRequest1Timeout
    Left = 432
    Top = 208
  end
end
