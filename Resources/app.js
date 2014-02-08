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
    var program, _i, _len, _ref, _results;
    _ref = result.list.g1;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      program = _ref[_i];
      _results.push(Ti.API.info(program.id + program.title));
    }
    return _results;
  });

  client.info('東京', "ＮＨＫ総合１", '2014020903005', function(result) {
    Ti.API.info(result.list.g1[0].title);
    return Ti.API.info(result.list.g1[0].subtitle);
  });

}).call(this);
