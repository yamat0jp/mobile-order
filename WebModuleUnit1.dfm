object WebModule1: TWebModule1
  OnCreate = WebModuleCreate
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
  AfterDispatch = WebModuleAfterDispatch
  OnException = WebModuleException
  Height = 203
  Width = 415
  object DataSource1: TDataSource
    Left = 144
    Top = 64
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\yamat\scoop\apps\postgresql10\10.23\bin\libpq.dll'
    Left = 192
    Top = 88
  end
  object FDTable1: TFDTable
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'uid'
    Left = 344
    Top = 32
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=mydb'
      'User_Name=postgres'
      'DriverID=PG')
    Connected = True
    Left = 248
    Top = 40
  end
end
