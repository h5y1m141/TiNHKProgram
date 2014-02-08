(function() {
  var tabGroup;

  tabGroup = (function() {
    function tabGroup() {
      this.tabSetting = {
        "iphone": {
          "list": {
            "icon": "ui/image/listIcon.png",
            "activeIcon": "ui/image/listIconActive.png",
            "windowName": "listWindow"
          },
          "map": {
            "icon": "ui/image/grayPin.png",
            "activeIcon": "ui/image/pin.png",
            "windowName": "mapWindow"
          },
          "myPage": {
            "icon": "ui/image/settingIcon.png",
            "activeIcon": "ui/image/activeSettingIcon.png"
          },
          "score": {
            "icon": "ui/image/graphIcon.png",
            "activeIcon": "ui/image/activegraphIcon.png",
            "windowName": "scoreWindow",
            "windowName": "scoreWindow"
          },
          "vote": {
            "icon": "ui/image/voteGrayIcon.png",
            "activeIcon": "ui/image/voteBlackIcon.png",
            "windowName": "voteWindow"
          }
        }
      };
    }

    tabGroup.prototype.init = function() {
      var ProgramListWindow, programListWindow, programListWindowTab;
      tabGroup = Ti.UI.createTabGroup({
        tabsBackgroundColor: "#f9f9f9",
        shadowImage: "ui/image/shadowimage.png",
        tabsBackgroundImage: "ui/image/tabbar.png",
        activeTabBackgroundImage: "ui/image/activetab.png",
        activeTabIconTint: "#fffBD5"
      });
      tabGroup.addEventListener('focus', function(e) {
        tabGroup._activeTab = e.tab;
        tabGroup._activeTabIndex = e.index;
        if (tabGroup._activeTabIndex === -1) {
          return;
        }
        Ti.API._activeTab = tabGroup._activeTab;
      });
      ProgramListWindow = require("ui/programListWindow");
      programListWindow = new ProgramListWindow();
      programListWindowTab = Titanium.UI.createTab({
        window: programListWindow
      });
      tabGroup.addTab(programListWindowTab);
      tabGroup.open();
    };

    return tabGroup;

  })();

  module.exports = tabGroup;

}).call(this);
