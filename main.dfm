object Form1: TForm1
  Width = 959
  Height = 959
  Caption = 'sushi'
  OnCreate = WebFormCreate
  object WebLabel2: TWebLabel
    Left = 0
    Top = 297
    Width = 959
    Height = 54
    Align = alTop
    Caption = #20154#27671#12513#12491#12517#12540
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    HTMLType = tH1
    ParentFont = False
    WidthPercent = 100.000000000000000000
    ExplicitWidth = 212
  end
  object WebPanel7: TWebPanel
    Left = 0
    Top = 871
    Width = 959
    Height = 88
    Align = alBottom
    ChildOrder = 3
    Color = 8404992
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object WebLinkLabel1: TWebLinkLabel
      Left = 464
      Top = 24
      Width = 52
      Height = 15
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      Caption = '<a href="rule.html">'#21033#29992#35215#32004'</a>'
    end
    object WebLinkLabel2: TWebLinkLabel
      Left = 578
      Top = 24
      Width = 70
      Height = 15
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      Caption = '<a  href="qanda.html">'#12362#21839#12356#21512#12431#12379'</a>'
    end
    object WebLinkLabel3: TWebLinkLabel
      Left = 320
      Top = 24
      Width = 102
      Height = 15
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      Caption = '<a href="policy.html">'#12503#12521#12452#12496#12471#12540#12509#12522#12471#12540'</a>'
    end
    object WebLabel3: TWebLabel
      Left = 448
      Top = 56
      Width = 38
      Height = 15
      Caption = #169' 2025'
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
  end
  object WebResponsiveGridPanel1: TWebResponsiveGridPanel
    Left = 0
    Top = 0
    Width = 959
    Height = 297
    WidthStyle = ssPercent
    HeightPercent = 25.000000000000000000
    Align = alTop
    ChildOrder = 1
    ControlCollection = <
      item
        Column = 0
        Row = 0
        Control = WebLabel1
      end
      item
        Column = 0
        Row = 0
        Control = WebHTMLDiv2
      end
      item
        Column = 0
        Row = 0
        Control = WebPanel1
      end
      item
        Column = 0
        Row = 0
        Control = WebPanel3
      end
      item
        Column = 0
        Row = 0
        Control = WebPanel2
      end
      item
        Column = 0
        Row = 0
        Control = WebPanel4
      end>
    Color = clWhite
    Layout = <
      item
        Description = 'Tablet'
        Style = '50% 50%'
        Width = 768
      end
      item
        Description = 'smart phone'
        Style = '1fr'
        Width = 530
      end>
    DesignSize = (
      959
      297)
    object WebLabel1: TWebLabel
      Left = 0
      Top = 0
      Width = 70
      Height = 28
      Caption = #12288#12424#12358#12371#12381
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object WebPanel1: TWebPanel
      Left = 0
      Top = 40
      Width = 480
      Height = 125
      ElementClassName = 'category-card'
      WidthStyle = ssAuto
      Caption = #12489#12522#12531#12463
      Color = clRed
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = WebPanel1Click
    end
    object WebPanel4: TWebPanel
      Left = 480
      Top = 165
      Width = 480
      Height = 125
      ElementClassName = 'category-card'
      WidthStyle = ssAuto
      Anchors = []
      Caption = #12513#12491#12517#12540
      ChildOrder = 1
      Color = 9737364
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = WebPanel4Click
    end
    object WebPanel2: TWebPanel
      Left = 0
      Top = 165
      Width = 480
      Height = 125
      ElementClassName = 'category-card'
      WidthStyle = ssAuto
      Anchors = []
      Caption = #12475#12483#12488
      ChildOrder = 2
      Color = 8461085
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = WebPanel1Click
    end
    object WebPanel3: TWebPanel
      Left = 480
      Top = 40
      Width = 480
      Height = 125
      ElementClassName = 'category-card'
      WidthStyle = ssAuto
      Anchors = []
      Caption = #12362#12377#12377#12417
      ChildOrder = 3
      Color = 114686
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = WebPanel1Click
    end
    object WebHTMLDiv2: TWebHTMLDiv
      Left = 480
      Top = 0
      Width = 100
      Height = 40
      Anchors = []
      ChildOrder = 4
      Role = ''
    end
  end
  object WebScrollBox1: TWebScrollBox
    Left = 0
    Top = 351
    Width = 959
    Height = 520
    Align = alClient
    BorderStyle = bsSingle
    ChildOrder = 3
    Color = clWhite
    ScrollBars = ssHorizontal
    ExplicitTop = 345
  end
  object WebHttpRequest1: TWebHttpRequest
    URL = 'http://'
    OnResponse = WebHttpRequest1Response
    Left = 376
    Top = 376
  end
end
