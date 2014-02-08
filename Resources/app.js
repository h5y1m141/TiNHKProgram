(function() {
  var NHKProgram, client, config, file, win;

  NHKProgram = require("model/nhk");

  config = Titanium.Filesystem.getFile(Titanium.Filesystem.resourcesDirectory, "model/config.json");

  file = config.read().toString();

  config = JSON.parse(file);

  client = new NHKProgram(config);

  win = Ti.UI.createWindow({
    title: 'NHK program',
    backgroundColor: "#fff"
  });

  win.open();

  client.list('東京', "ＮＨＫ総合１", "2014-02-09", function(result) {
    return Ti.API.info(result);
  });

}).call(this);
