class tabGroup
  constructor:() ->
    @tabSetting =
      "iphone":
        "list":
          "icon":"ui/image/listIcon.png"
          "activeIcon":"ui/image/listIconActive.png"
          "windowName":"listWindow"
        ,  
        "map":
          "icon": "ui/image/grayPin.png",
          "activeIcon": "ui/image/pin.png",
          "windowName": "mapWindow"
        ,  
        "myPage":
          "icon":"ui/image/settingIcon.png"
          "activeIcon":"ui/image/activeSettingIcon.png"      
        ,  
        "score":
          "icon":"ui/image/graphIcon.png"
          "activeIcon":"ui/image/activegraphIcon.png"      
          "windowName":"scoreWindow"
          "windowName":"scoreWindow"
        ,
        
        "vote":
          "icon":"ui/image/voteGrayIcon.png"
          "activeIcon":"ui/image/voteBlackIcon.png"      
          "windowName":"voteWindow"          

  init:() ->
    tabGroup = Ti.UI.createTabGroup
      tabsBackgroundColor:"#f9f9f9"
      shadowImage:"ui/image/shadowimage.png"
      tabsBackgroundImage:"ui/image/tabbar.png"
      activeTabBackgroundImage:"ui/image/activetab.png"  
      activeTabIconTint:"#fffBD5"

    tabGroup.addEventListener('focus',(e) ->
      tabGroup._activeTab = e.tab
      tabGroup._activeTabIndex = e.index
      if tabGroup._activeTabIndex is -1
        return

      Ti.API._activeTab = tabGroup._activeTab;

      # ページビューを取得したいので以下を参考にしてイベントリスナー設定  
      # http://hirofukami.com/2013/05/31/titanium-google-analytics/


      return
    )

    ProgramListWindow = require("ui/programListWindow")
    programListWindow = new ProgramListWindow()
    programListWindowTab = Titanium.UI.createTab
      window:programListWindow

    tabGroup.addTab programListWindowTab

    tabGroup.open()
    return
    
    
module.exports = tabGroup
