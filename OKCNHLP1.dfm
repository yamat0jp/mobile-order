inherited OKHelpBottomDlg: TOKHelpBottomDlg
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  object Label1: TLabel [1]
    Left = 150
    Top = 75
    Width = 13
    Height = 15
    Caption = #65374
  end
  object Label2: TLabel [2]
    Left = 40
    Top = 40
    Width = 68
    Height = 15
    Caption = #12486#12540#12502#12523#30058#21495
  end
  inherited OKBtn: TButton
    Left = 70
    ExplicitLeft = 70
  end
  inherited CancelBtn: TButton
    Left = 150
    ExplicitLeft = 150
  end
  object HelpBtn: TButton
    Left = 230
    Top = 180
    Width = 75
    Height = 25
    Caption = #12504#12523#12503'(&H)'
    TabOrder = 2
    OnClick = HelpBtnClick
  end
  object Edit1: TEdit
    Left = 40
    Top = 72
    Width = 73
    Height = 23
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 200
    Top = 72
    Width = 73
    Height = 23
    TabOrder = 4
  end
end
