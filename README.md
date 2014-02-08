[NHK 番組表 API を触る為の Ruby クライアント作った](http://mitukiii.hatenablog.com/entry/2014/02/07/015233)というエントリを見てて気になったので、Titanium Mobileで同じようなことが実現できなかとサンプルアプリ作ってみました。



## 使い方

Resources/model以下にconfig.jsonというファイルを作ります

```javascript
{
    "apikey":"NHK APIを利用するためのキーを入力",

}
```

あとはこんな感じで利用できますがまだ全部実装していません・・

```coffee
NHKProgram = require("model/nhk")
config = Titanium.Filesystem.getFile(Titanium.Filesystem.resourcesDirectory, "model/config.json")
file = config.read().toString()
config = JSON.parse(file)
client = new NHKProgram(config)


client.now('東京',"ＮＨＫ総合１",(result) ->
  Ti.API.info result)
```

