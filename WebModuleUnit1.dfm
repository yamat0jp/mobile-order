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
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 230
  Width = 415
end
