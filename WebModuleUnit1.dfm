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
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 230
  Width = 415
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=mydb'
      'CharacterSet=UTF8'
      'DriverID=PG')
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
    object FDTable1category: TWideMemoField
      FieldName = 'category'
      BlobType = ftWideMemo
    end
    object FDTable1name: TWideMemoField
      FieldName = 'name'
      BlobType = ftWideMemo
    end
    object FDTable1comment: TWideMemoField
      FieldName = 'comment'
      BlobType = ftWideMemo
    end
    object FDTable1price: TIntegerField
      FieldName = 'price'
    end
    object FDTable1qty: TIntegerField
      FieldName = 'qty'
    end
    object FDTable1cnt: TIntegerField
      FieldName = 'cnt'
    end
    object FDTable1fileext: TWideMemoField
      FieldName = 'fileext'
      BlobType = ftWideMemo
    end
    object FDTable1image: TBlobField
      FieldName = 'image'
    end
    object FDTable1id: TIntegerField
      FieldName = 'id'
      Origin = 'id'
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
    object FDTable3category: TWideMemoField
      FieldName = 'category'
      Origin = 'category'
      BlobType = ftWideMemo
    end
    object FDTable3name: TWideMemoField
      FieldName = 'name'
      Origin = 'name'
      BlobType = ftWideMemo
    end
    object FDTable3comment: TWideMemoField
      FieldName = 'comment'
      Origin = '"comment"'
      BlobType = ftWideMemo
    end
    object FDTable3price: TIntegerField
      FieldName = 'price'
      Origin = 'price'
    end
    object FDTable3qty: TIntegerField
      FieldName = 'qty'
      Origin = 'qty'
    end
    object FDTable3cnt: TIntegerField
      FieldName = 'cnt'
      Origin = 'cnt'
    end
    object FDTable3fileext: TWideMemoField
      FieldName = 'fileext'
      Origin = 'fileext'
      BlobType = ftWideMemo
    end
    object FDTable3image: TBlobField
      FieldName = 'image'
      Origin = 'image'
    end
    object FDTable3id: TIntegerField
      FieldName = 'id'
      Origin = 'id'
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
    object FDTable2tableid: TIntegerField
      FieldName = 'tableid'
      Origin = 'tableid'
    end
    object FDTable2orderid: TIntegerField
      FieldName = 'orderid'
      Origin = 'orderid'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDTable2id: TIntegerField
      FieldName = 'id'
      Origin = 'id'
    end
    object FDTable2qty: TIntegerField
      FieldName = 'qty'
      Origin = 'qty'
    end
    object FDTable2timedata: TWideMemoField
      FieldName = 'timedata'
      Origin = 'timedata'
      BlobType = ftWideMemo
    end
    object FDTable2status: TIntegerField
      FieldName = 'status'
      Origin = 'status'
    end
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      '    '
      
        'create table kitchen(tableID integer, orderID serial PRIMARY KEY' +
        ',      '
      '  id integer, qty integer, timedata text, status integer);')
    Left = 280
    Top = 40
  end
end
