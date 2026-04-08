object DataModule3: TDataModule3
  Height = 281
  Width = 413
  object FDTable1: TFDTable
    BeforeInsert = FDTable1BeforeInsert
    AfterInsert = FDTable1AfterInsert
    BeforePost = FDTable1BeforePost
    IndexFieldNames = 'id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'item'
    Left = 312
    Top = 64
    object FDTable1ID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object FDTable1CATEGORY: TWideStringField
      FieldName = 'CATEGORY'
      Origin = 'CATEGORY'
      Required = True
      Size = 256
    end
    object FDTable1NAME: TWideStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 256
    end
    object FDTable1COMMENT: TWideStringField
      FieldName = 'COMMENT'
      Origin = 'COMMENT'
      Size = 1024
    end
    object FDTable1PRICE: TIntegerField
      FieldName = 'PRICE'
      Origin = 'PRICE'
      Required = True
    end
    object FDTable1QTY: TIntegerField
      FieldName = 'QTY'
      Origin = 'QTY'
      Required = True
    end
    object FDTable1CNT: TIntegerField
      FieldName = 'CNT'
      Origin = 'CNT'
      Required = True
    end
    object FDTable1FILEEXT: TWideStringField
      FieldName = 'FILEEXT'
      Origin = 'FILEEXT'
      Size = 32
    end
    object FDTable1IMAGE: TBlobField
      FieldName = 'IMAGE'
      Origin = 'IMAGE'
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=E:\fuke\GitHub\2026\mobile-order\MOBILE.IB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=UTF8'
      'OpenMode=OpenOrCreate'
      'Protocol=TCPIP'
      'DriverID=IB')
    Left = 160
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 296
    Top = 176
  end
end
