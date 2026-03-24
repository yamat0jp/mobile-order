object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 720
  ClientWidth = 1046
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = RadioButton1Click
  OnDestroy = FormDestroy
  TextHeight = 15
  object Label5: TLabel
    Left = 248
    Top = 117
    Width = 445
    Height = 28
    Caption = #12458#12540#12480#12540#12398#21040#30528#12375#12390#12356#12394#12356#12362#23458#27096#12364#20986#12414#12375#12383' : status 3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 33023
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object DBGrid1: TDBGrid
    Left = 56
    Top = 175
    Width = 601
    Height = 498
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 368
    Top = 64
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 1
  end
  object RadioButton1: TRadioButton
    Left = 104
    Top = 32
    Width = 113
    Height = 17
    Caption = #21416#25151
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 104
    Top = 90
    Width = 113
    Height = 17
    Caption = #12524#12472
    TabOrder = 3
    OnClick = RadioButton1Click
  end
  object RadioButton3: TRadioButton
    Left = 104
    Top = 144
    Width = 113
    Height = 17
    Caption = #12510#12473#12479#12540
    TabOrder = 4
    OnClick = RadioButton1Click
  end
  object Panel1: TPanel
    Left = 726
    Top = 64
    Width = 266
    Height = 148
    Caption = 'Panel1'
    TabOrder = 5
    object Label1: TLabel
      Left = 26
      Top = 26
      Width = 87
      Height = 15
      Caption = #20250#35336#20013#12398#12362#23458#27096
    end
    object Label2: TLabel
      Left = 50
      Top = 104
      Width = 63
      Height = 15
      Caption = #12362#20250#35336#37329#38989
    end
    object Label3: TLabel
      Left = 159
      Top = 101
      Width = 34
      Height = 15
      Caption = 'Label3'
    end
    object ComboBox1: TComboBox
      Left = 24
      Top = 61
      Width = 201
      Height = 23
      TabOrder = 0
      Text = #12486#12540#12502#12523#30058#21495#12391#36984#25246#12375#12390#12367#12384#12373#12356
      OnChange = ComboBox1Change
    end
  end
  object ListBox1: TListBox
    Left = 726
    Top = 248
    Width = 243
    Height = 425
    ItemHeight = 15
    TabOrder = 6
  end
  object Panel2: TPanel
    Left = 32
    Top = 218
    Width = 960
    Height = 377
    Caption = 'Panel2'
    TabOrder = 7
    object Label4: TLabel
      Left = 720
      Top = 152
      Width = 28
      Height = 15
      Caption = #23653#27508
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 744
      Top = 40
      Width = 75
      Height = 25
      Caption = #12391#12365#12383
      TabOrder = 0
      OnClick = Button1Click
    end
    object ListBox2: TListBox
      Left = 716
      Top = 208
      Width = 236
      Height = 145
      ItemHeight = 15
      TabOrder = 1
    end
    object ListBox3: TListBox
      Left = 24
      Top = 56
      Width = 625
      Height = 297
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemHeight = 37
      ParentFont = False
      TabOrder = 2
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=E:\fuke\GitHub\mobile-order\data.sdb'
      'LockingMode=Normal'
      'OpenMode=ReadWrite'
      'JournalMode=WAL'
      'DriverID=SQLite')
    Connected = True
    Left = 552
    Top = 256
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 752
    Top = 256
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'drop table kitchen;'
      
        'create table kitchen(tableID integer, orderID integer PRIMARY KE' +
        'Y AUTOINCREMENT, '
      '  id integer, qty integer, timedata timestamp, status integer);')
    Left = 600
    Top = 184
  end
  object FDTable1: TFDTable
    Active = True
    IndexFieldNames = 'tableid'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'kitchen'
    Left = 656
    Top = 256
    object FDTable1tableID: TIntegerField
      FieldName = 'tableID'
      Origin = 'tableID'
    end
    object FDTable1orderID: TFDAutoIncField
      FieldName = 'orderID'
      Origin = 'orderID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object FDTable1qty: TIntegerField
      FieldName = 'qty'
      Origin = 'qty'
    end
    object FDTable1timedata: TSQLTimeStampField
      FieldName = 'timedata'
      Origin = 'timedata'
    end
    object FDTable1status: TIntegerField
      FieldName = 'status'
      Origin = 'status'
    end
    object FDTable1id: TIntegerField
      FieldName = 'id'
      Origin = 'id'
    end
  end
  object FDTable2: TFDTable
    Active = True
    IndexFieldNames = 'id'
    MasterSource = DataSource1
    MasterFields = 'id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'item'
    Left = 656
    Top = 352
    object FDTable2id: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object FDTable2category: TWideMemoField
      FieldName = 'category'
      Origin = 'category'
      BlobType = ftWideMemo
    end
    object FDTable2name: TWideMemoField
      FieldName = 'name'
      Origin = 'name'
      BlobType = ftWideMemo
    end
    object FDTable2comment: TWideMemoField
      FieldName = 'comment'
      Origin = 'comment'
      BlobType = ftWideMemo
    end
    object FDTable2price: TIntegerField
      FieldName = 'price'
      Origin = 'price'
    end
    object FDTable2qty: TIntegerField
      FieldName = 'qty'
      Origin = 'qty'
    end
    object FDTable2cnt: TIntegerField
      FieldName = 'cnt'
      Origin = 'cnt'
    end
    object FDTable2fileext: TWideMemoField
      FieldName = 'fileext'
      Origin = 'fileext'
      BlobType = ftWideMemo
    end
    object FDTable2image: TBlobField
      FieldName = 'image'
      Origin = 'image'
    end
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 416
    Top = 256
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 336
    Top = 256
  end
end
