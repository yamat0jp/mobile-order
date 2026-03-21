object WebModule1: TWebModule1
  Actions = <
    item
      Default = True
      MethodType = mtGet
      Name = 'DefaultHandler'
      PathInfo = '/popular'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = 'WebActionItem1'
      PathInfo = '/test'
      OnAction = WebModule1WebActionItem1Action
    end
    item
      Name = 'WebActionItem2'
      PathInfo = '/setmenu'
    end
    item
      Name = 'WebActionItem3'
      PathInfo = '/drink'
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
    IndexFieldNames = 'id'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'item'
    Left = 72
    Top = 40
  end
  object FDTable2: TFDTable
    Connection = FDConnection1
    Left = 72
    Top = 120
  end
end
