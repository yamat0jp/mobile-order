object OKRightDlg: TOKRightDlg
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = #12480#12452#12450#12525#12464
  ClientHeight = 179
  ClientWidth = 384
  Color = clBtnFace
  ParentFont = True
  Position = poScreenCenter
  TextHeight = 15
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 281
    Height = 161
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 40
    Top = 46
    Width = 68
    Height = 15
    Caption = #12486#12540#12502#12523#30058#21495
  end
  object Label2: TLabel
    Left = 136
    Top = 78
    Width = 13
    Height = 15
    Caption = #65374
  end
  object OKBtn: TButton
    Left = 300
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 300
    Top = 38
    Width = 75
    Height = 25
    Cancel = True
    Caption = #12461#12515#12531#12475#12523
    ModalResult = 2
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 40
    Top = 75
    Width = 74
    Height = 23
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 176
    Top = 75
    Width = 74
    Height = 23
    TabOrder = 3
  end
end
