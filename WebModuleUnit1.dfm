object WebModule1: TWebModule1
  Actions = <
    item
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
  OnException = WebModuleException
  Height = 203
  Width = 415
  object DataSource1: TDataSource
    DataSet = FDTable1
    Left = 80
    Top = 40
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=mydb'
      'User_Name=postgres'
      'CharacterSet=UTF8'
      'DriverID=PG')
    Connected = True
    Left = 168
    Top = 40
  end
  object FDTable1: TFDTable
    Active = True
    IndexFieldNames = 'orderid'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'kitchen'
    Left = 80
    Top = 112
    object FDTable1tableid: TIntegerField
      FieldName = 'tableid'
      Origin = 'tableid'
    end
    object FDTable1orderid: TIntegerField
      FieldName = 'orderid'
      Origin = 'orderid'
    end
    object FDTable1id: TIntegerField
      FieldName = 'id'
      Origin = 'id'
    end
    object FDTable1qty: TIntegerField
      FieldName = 'qty'
      Origin = 'qty'
    end
    object FDTable1timedata: TWideMemoField
      FieldName = 'timedata'
      Origin = 'timedata'
      BlobType = ftWideMemo
    end
    object FDTable1status: TIntegerField
      FieldName = 'status'
      Origin = 'status'
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
    Left = 168
    Top = 112
    object FDTable2id: TIntegerField
      FieldName = 'id'
      Origin = 'id'
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
      Origin = '"comment"'
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
  object FDTable3: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'item'
    Left = 264
    Top = 112
    object FDTable3id: TIntegerField
      FieldName = 'id'
      Origin = 'id'
    end
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
  end
  object FDTable4: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'uid'
    Left = 328
    Top = 112
    object FDTable4id: TIntegerField
      FieldName = 'id'
      Origin = 'id'
    end
    object FDTable4tableid: TIntegerField
      FieldName = 'tableid'
      Origin = 'tableid'
    end
    object FDTable4ip: TWideMemoField
      FieldName = 'ip'
      Origin = 'ip'
      BlobType = ftWideMemo
    end
  end
end
