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
  Height = 245
  Width = 415
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=mydb'
      'User_Name=postgres'
      'CharacterSet=UTF8'
      'Server='
      'DriverID=PG')
    Connected = True
    Left = 168
    Top = 40
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 280
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 48
    Top = 48
  end
end
