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
  TextHeight = 15
  object DBNavigator1: TDBNavigator
    Left = 344
    Top = 48
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 56
    Top = 183
    Width = 921
    Height = 498
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
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
  object FDTable1: TFDTable
    Active = True
    IndexFieldNames = 'orderID'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'kitchen'
    Left = 648
    Top = 256
    object FDTable1tableID: TIntegerField
      FieldName = 'tableID'
      Origin = 'tableID'
    end
    object FDTable1id: TIntegerField
      FieldName = 'id'
      Origin = 'id'
    end
    object FDTable1category: TWideMemoField
      FieldName = 'category'
      Origin = 'category'
      BlobType = ftWideMemo
    end
    object FDTable1name: TWideMemoField
      FieldName = 'name'
      Origin = 'name'
      BlobType = ftWideMemo
    end
    object FDTable1qty: TIntegerField
      FieldName = 'qty'
      Origin = 'qty'
    end
    object FDTable1image: TBlobField
      FieldName = 'image'
      Origin = 'image'
    end
    object FDTable1timedata: TSQLTimeStampField
      FieldName = 'timedata'
      Origin = 'timedata'
    end
    object FDTable1status: TIntegerField
      FieldName = 'status'
      Origin = 'status'
    end
    object FDTable1orderID: TIntegerField
      FieldName = 'orderID'
      Origin = 'orderID'
    end
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
      
        'create table kitchen(orderID integer, tableID integer, id intege' +
        'r, '
      '  category text, name text, image blob, qty integer,'
      '  timedata timestamp, status integer);')
    Left = 600
    Top = 184
  end
end
