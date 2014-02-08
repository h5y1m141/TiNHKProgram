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

## License
The MIT License (MIT) Copyright (c) 2014 Hiroshi Oyamada

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
