NHKProgram = require("model/nhk")
config = Titanium.Filesystem.getFile(Titanium.Filesystem.resourcesDirectory, "model/config.json")
file = config.read().toString()
config = JSON.parse(file)
client = new NHKProgram(config)


# client.now('東京',"ＮＨＫ総合１",(result) ->
#   Ti.API.info result    
# )
win = Ti.UI.createWindow
  title:'NHK program'
  backgroundColor:"#fff"
  
win.open()   

client.list('東京',"ＮＨＫ総合１","2014-02-09",(result) ->
  for program in result.list.g1
    Ti.API.info program.id + program.title
)

# みんなのうたの番組詳細取得
client.info('東京',"ＮＨＫ総合１",'2014020903005',(result) ->
  
  Ti.API.info result.list.g1[0].title
  Ti.API.info result.list.g1[0].subtitle
)
