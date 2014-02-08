(function() {
  var ProgramListWindow;

  ProgramListWindow = (function() {
    function ProgramListWindow() {
      var ActivityIndicator, NHKProgram, config, file, win;
      NHKProgram = require("model/nhk");
      config = Titanium.Filesystem.getFile(Titanium.Filesystem.resourcesDirectory, "model/config.json");
      file = config.read().toString();
      config = JSON.parse(file);
      this.client = new NHKProgram(config);
      ActivityIndicator = require("ui/activityIndicator");
      this.activityIndicator = new ActivityIndicator();
      this.moment = require("lib/moment");
      this.area = '東京';
      this.service = "ＮＨＫ総合１";
      this.date = "2014-02-09";
      win = Ti.UI.createWindow({
        title: "" + this.area + "の" + this.service + "番組リスト",
        barColor: "#3261AB",
        tabBarHidden: false,
        navBarHidden: false
      });
      this.tableView = Ti.UI.createTableView({
        backgroundColor: "#f3f3f3",
        separatorStyle: Titanium.UI.iPhone.TableViewSeparatorStyle.NONE,
        width: Ti.UI.FULL
      });
      win.add(this.activityIndicator);
      win.add(this.tableView);
      this.refreshTable();
      return win;
    }

    ProgramListWindow.prototype.refreshTable = function() {
      var _this = this;
      this.activityIndicator.show();
      return this.client.list(this.area, this.service, this.date, function(result) {
        var program, row, rows, subtitle, timeTable, title, _i, _len, _ref;
        rows = [];
        _ref = result.list.g1;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          program = _ref[_i];
          row = Ti.UI.createTableViewRow({
            width: Ti.UI.FULL,
            height: 80,
            backgroundColor: "f3f3f3",
            programID: program.id
          });
          title = Ti.UI.createLabel({
            width: 220,
            height: 50,
            top: 5,
            left: 70,
            textAlign: 'left',
            color: "#222",
            font: {
              fontSize: 14,
              fontWeight: 'bold'
            },
            text: "" + program.title
          });
          subtitle = Ti.UI.createLabel({
            width: 220,
            height: 20,
            top: 55,
            left: 70,
            textAlign: 'left',
            color: "#999",
            font: {
              fontSize: 12
            },
            text: "" + program.subtitle
          });
          timeTable = Ti.UI.createLabel({
            width: 60,
            height: 20,
            top: 20,
            left: 5,
            color: "#007FB1",
            font: {
              fontSize: 12,
              fontWeight: 'bold'
            },
            text: "" + (_this.moment(program.start_time).format('HH:mm')) + "〜"
          });
          row.add(title);
          row.add(subtitle);
          row.add(timeTable);
          rows.push(row);
        }
        _this.activityIndicator.hide();
        return _this.tableView.setData(rows);
      });
    };

    return ProgramListWindow;

  })();

  module.exports = ProgramListWindow;

}).call(this);
