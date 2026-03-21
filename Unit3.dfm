object DataModule3: TDataModule3
  Height = 480
  Width = 640
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'drop table item;'
      'create table item(id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '  category text, name text, comment text,'
      '  price integer, qty integer, '
      '  fileext text, image blob);'
      '  ')
    Left = 520
    Top = 72
  end
  object FDTable1: TFDTable
    Active = True
    BeforePost = FDTable1BeforePost
    IndexFieldNames = 'id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'item'
    Left = 312
    Top = 64
    object FDTable1id: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
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
    object FDTable1comment: TWideMemoField
      FieldName = 'comment'
      Origin = 'comment'
      BlobType = ftWideMemo
    end
    object FDTable1price: TIntegerField
      FieldName = 'price'
      Origin = 'price'
    end
    object FDTable1qty: TIntegerField
      FieldName = 'qty'
      Origin = 'qty'
    end
    object FDTable1fileext: TWideMemoField
      FieldName = 'fileext'
      Origin = 'fileext'
      BlobType = ftWideMemo
    end
    object FDTable1image: TBlobField
      FieldName = 'image'
      Origin = 'image'
    end
    object FDTable1cnt: TIntegerField
      FieldName = 'cnt'
      Origin = 'cnt'
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=E:\fuke\GitHub\mobile-order\data.sdb'
      'OpenMode=ReadWrite'
      'JournalMode=WAL'
      'BusyTimeout=30000'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    Left = 160
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 296
    Top = 176
  end
end
