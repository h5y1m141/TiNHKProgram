(function() {
  var NHKProgram, client, config, file, tableView, win;

  NHKProgram = require("model/nhk");

  config = Titanium.Filesystem.getFile(Titanium.Filesystem.resourcesDirectory, "model/config.json");

  file = config.read().toString();

  config = JSON.parse(file);

  client = new NHKProgram(config);

  client.now('東京', "ＮＨＫ総合１", function(result) {
    return Ti.API.info(result);
  });

  win = Ti.UI.createWindow({
    title: 'NHK program',
    backgroundColor: "#fff"
  });

  tableView = Ti.UI.createTableView();

  win.add(tableView);

  win.open();

}).call(this);
