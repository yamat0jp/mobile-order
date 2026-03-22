object WebModule1: TWebModule1
  Actions = <
    item
      Default = True
      MethodType = mtGet
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = 'WebActionItem1'
      PathInfo = '/test'
      OnAction = WebModule1WebActionItem1Action
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
      MethodType = mtGet
      Name = 'WebActionItem2'
      PathInfo = '/download'
      OnAction = WebModule1WebActionItem2Action
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 230
  Width = 415
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=E:\fuke\GitHub\mobile-order\data.sdb'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'JournalMode=WAL'
      'DriverID=SQLite')
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
  end
  object FDTable2: TFDTable
    Active = True
    Filtered = True
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'kitchen'
    Left = 72
    Top = 120
  end
  object FDTable3: TFDTable
    Active = True
    IndexFieldNames = 'id'
    MasterSource = DataSource1
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'item'
    Left = 184
    Top = 120
  end
  object DataSource1: TDataSource
    DataSet = FDTable2
    Left = 272
    Top = 120
  end
end
