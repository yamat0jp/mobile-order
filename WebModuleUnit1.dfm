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
end
