object WebModule1: TWebModule1
  OnCreate = WebModuleCreate
  Actions = <
    item
      Default = True
      MethodType = mtGet
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      MethodType = mtPut
      Name = 'WebActionItem4'
      PathInfo = '/order'
      OnAction = WebModule1WebActionItem4Action
    end
    item
      MethodType = mtPost
      Name = 'WebActionItem5'
      PathInfo = '/checkout'
      OnAction = WebModule1WebActionItem5Action
    end
    item
      MethodType = mtPost
      Name = 'WebActionItem2'
      PathInfo = '/download'
      OnAction = WebModule1WebActionItem2Action
    end
    item
      MethodType = mtGet
      Name = 'WebActionItem1'
      PathInfo = '/uid'
      OnAction = WebModule1WebActionItem1Action
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 230
  Width = 415
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=E:\fuke\GitHub\2026\mobile-order\MOBILE.IB'
      'CharacterSet=UTF8'
      'OpenMode=OpenOrCreate'
      'DriverID=IB')
    Connected = True
    Left = 160
    Top = 40
  end
  object FDTable1: TFDTable
    Active = True
    Filtered = True
    Filter = 'category = '#39'popular'#39
    IndexFieldNames = 'id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'item'
    Left = 72
    Top = 40
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
    object FDTable1IMAGE: TWideMemoField
      FieldName = 'IMAGE'
      Origin = 'IMAGE'
      BlobType = ftWideMemo
    end
  end
  object FDTable3: TFDTable
    Active = True
    IndexFieldNames = 'id'
    MasterSource = DataSource1
    MasterFields = 'id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'item'
    Left = 184
    Top = 120
    object FDTable3ID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object FDTable3CATEGORY: TWideStringField
      FieldName = 'CATEGORY'
      Origin = 'CATEGORY'
      Required = True
      Size = 256
    end
    object FDTable3NAME: TWideStringField
      FieldName = 'NAME'
      Origin = 'NAME'
      Required = True
      Size = 256
    end
    object FDTable3COMMENT: TWideStringField
      FieldName = 'COMMENT'
      Origin = 'COMMENT'
      Size = 1024
    end
    object FDTable3PRICE: TIntegerField
      FieldName = 'PRICE'
      Origin = 'PRICE'
      Required = True
    end
    object FDTable3QTY: TIntegerField
      FieldName = 'QTY'
      Origin = 'QTY'
      Required = True
    end
    object FDTable3CNT: TIntegerField
      FieldName = 'CNT'
      Origin = 'CNT'
      Required = True
    end
    object FDTable3FILEEXT: TWideStringField
      FieldName = 'FILEEXT'
      Origin = 'FILEEXT'
      Size = 32
    end
    object FDTable3IMAGE: TWideMemoField
      FieldName = 'IMAGE'
      Origin = 'IMAGE'
      BlobType = ftWideMemo
    end
  end
  object DataSource1: TDataSource
    DataSet = FDTable2
    Left = 272
    Top = 120
  end
  object FDTable2: TFDTable
    Active = True
    Filtered = True
    Filter = 'status <> 2'
    IndexFieldNames = 'orderID'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'kitchen'
    Left = 80
    Top = 120
    object FDTable2TABLEID: TIntegerField
      FieldName = 'TABLEID'
      Origin = 'TABLEID'
      Required = True
    end
    object FDTable2ORDERID: TIntegerField
      FieldName = 'ORDERID'
      Origin = 'ORDERID'
      Required = True
    end
    object FDTable2ID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object FDTable2QTY: TIntegerField
      FieldName = 'QTY'
      Origin = 'QTY'
      Required = True
    end
    object FDTable2TIMEDATA: TWideStringField
      FieldName = 'TIMEDATA'
      Origin = 'TIMEDATA'
      Required = True
      Size = 40
    end
    object FDTable2STATUS: TIntegerField
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Required = True
    end
  end
  object FDTable4: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'uid'
    Left = 296
    Top = 40
    object FDTable4ID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDTable4TABLEID: TIntegerField
      FieldName = 'TABLEID'
      Origin = 'TABLEID'
      Required = True
    end
    object FDTable4IP: TWideStringField
      FieldName = 'IP'
      Origin = 'IP'
      Required = True
      Size = 1024
    end
  end
end
