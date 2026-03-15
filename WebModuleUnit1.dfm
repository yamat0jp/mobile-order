object WebModule1: TWebModule1
  Actions = <
    item
      MethodType = mtGet
      Name = 'DefaultHandler'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = 'WebActionItem1'
      PathInfo = '/test'
      OnAction = WebModule1WebActionItem1Action
    end>
  Height = 230
  Width = 415
end
