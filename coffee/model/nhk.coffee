# 以下GitHubのRuby版をベースに作ったNHK Program API CommonJSモジュール
# https://github.com/mitukiii/nhk_program-for-ruby/blob/master/lib/nhk_program/api.rb

class NHKProgram
  constructor: (config) ->
    @apikey = config.apikey
    
    @Genre = [
    	{"id": "0000", "name":"ニュース／報道(定時・総合)"},
    	{"id": "0100", "name":"スポーツ(スポーツニュース)"},
    	{"id": "0205", "name":"情報／ワイドショー(グルメ・料理)"},
    	{"id": "0300", "name":"ドラマ(国内ドラマ)"},
    	{"id": "0409", "name":"音楽(童謡・キッズ)"},
    	{"id": "0502", "name":"バラエティ(トークバラエティ)"},
    	{"id": "0600", "name":"映画(洋画)"},
    	{"id": "0700", "name":"アニメ／特撮(国内アニメ)"},
    	{"id": "0800", "name":"ドキュメンタリー／教養(社会・時事)"},
    	{"id": "0903", "name":"劇場／公演(落語・演芸)"},
    	{"id": "1000", "name":"趣味／教育(旅・釣り・アウトドア)"},
    	{"id": "1100", "name":"福祉(高齢者)"}
    ]
    @areaList = [
      {"id": "010", "name":"札幌"},
      {"id": "011", "name":"函館"},
      {"id": "012", "name":"旭川"},
      {"id": "013", "name":"帯広"},
      {"id": "014", "name":"釧路"},
      {"id": "015", "name":"北見"},
      {"id": "016", "name":"室蘭"},
      {"id": "020", "name":"青森"},
      {"id": "030", "name":"盛岡"},
      {"id": "040", "name":"仙台"},
      {"id": "050", "name":"秋田"},
      {"id": "060", "name":"山形"},
      {"id": "070", "name":"福島"},
      {"id": "080", "name":"水戸"},
      {"id": "090", "name":"宇都宮"},
      {"id": "100", "name":"前橋"},
      {"id": "110", "name":"さいたま"},
      {"id": "120", "name":"千葉"},
      {"id": "130", "name":"東京"},
      {"id": "140", "name":"横浜"},
      {"id": "150", "name":"新潟"},
      {"id": "160", "name":"富山"},
      {"id": "170", "name":"金沢"},
      {"id": "180", "name":"福井"},
      {"id": "190", "name":"甲府"},
      {"id": "200", "name":"長野"},
      {"id": "210", "name":"岐阜"},
      {"id": "220", "name":"静岡"},
      {"id": "230", "name":"名古屋"},
      {"id": "240", "name":"津"},
      {"id": "250", "name":"大津"},
      {"id": "260", "name":"京都"},
      {"id": "270", "name":"大阪"},
      {"id": "280", "name":"神戸"},
      {"id": "290", "name":"奈良"},
      {"id": "300", "name":"和歌山"},
      {"id": "310", "name":"鳥取"},
      {"id": "320", "name":"松江"},
      {"id": "330", "name":"岡山"},
      {"id": "340", "name":"広島"},
      {"id": "350", "name":"山口"},
      {"id": "360", "name":"徳島"},
      {"id": "370", "name":"高松"},
      {"id": "380", "name":"松山"},
      {"id": "390", "name":"高知"},
      {"id": "400", "name":"福岡"},
      {"id": "401", "name":"北九州"},
      {"id": "410", "name":"佐賀"},
      {"id": "420", "name":"長崎"},
      {"id": "430", "name":"熊本"},
      {"id": "440", "name":"大分"},
      {"id": "450", "name":"宮崎"},
      {"id": "460", "name":"鹿児島"},
      {"id": "470", "name":"沖縄"}
    ]

    @serviceList = [
      {"id":"g1", "name":"ＮＨＫ総合１"},
      {"id": "g2", "name":"ＮＨＫ総合２"},
      {"id": "e1", "name":"ＮＨＫＥテレ１"},
      {"id": "e2", "name":"ＮＨＫＥテレ２"},
      {"id": "e3", "name":"ＮＨＫＥテレ３"},
      {"id": "e4", "name":"ＮＨＫワンセグ２"},
      {"id": "s1", "name":"ＮＨＫＢＳ１"},
      {"id": "s2", "name":"ＮＨＫＢＳ１(１０２ｃｈ)"},
      {"id": "s3", "name":"ＮＨＫＢＳプレミアム"},
      {"id": "s4", "name":"ＮＨＫＢＳプレミアム(１０４ｃｈ)"},
      {"id": "r1", "name":"ＮＨＫラジオ第1"},
      {"id": "r2", "name":"ＮＨＫラジオ第2"},
      {"id": "r3", "name":"ＮＨＫＦＭ"},
      {"id": "n1", "name":"ＮＨＫネットラジオ第1"},
      {"id": "n2", "name":"ＮＨＫネットラジオ第2"},
      {"id": "n3", "name":"ＮＨＫネットラジオＦＭ"},
      {"id": "tv", "name":"テレビ全て"},
      {"id": "radio", "name":"ラジオ全て"},
      {"id": "netradio", "name":"ネットラジオ全て"}
    ]  
    return
    
  get:(requestParam,callback) ->
    xhr = Ti.Network.createHTTPClient()
    host = "http://api.nhk.or.jp/"
    base = "v1/pg/"
    Ti.API.info "#{host}#{base}#{requestParam}"
    xhr.open("GET","#{host}#{base}#{requestParam}")
    xhr.onload = ->
      json = JSON.parse(@.responseText)
      Ti.API.info "get result: #{json}"
      callback json    
    xhr.onerror = (e) ->
      error = JSON.parse(@.responseText)
      callback error

    xhr.timeout= 5000
    xhr.send()    

       
  list: (area, service, date,callback) ->
    area = @_parseArea(area)
    service = @_parseService(service)
    date = @_parseDate(date)    
    requestParam = "list/#{area.id}/#{service.id}/#{date}.json?key=#{@apikey}"

    @get(requestParam,(result) ->
      if result
        callback(result)
      else
        Ti.API.info "error. result is #{result}"
    )

    
  genre:(area, service, genre, date,callback) ->
    area = @_parseArea(area)
    service = @_parseService(service)
    genre = @_parseGenre(genre)
    date = @_parseDate(date)    
    requestParam = "genre/#{area.id}/#{service.id}/#{genre.id}/#{date}.json?key=#{@apikey}"
    @get(requestParam,(result) ->
      if result
        callback(result)
      else
        Ti.API.info "error. result is #{result}"
    )

        
  # Get program information
  #
  # @param area [Area, Symbol, String] Area ID (3 bytes)
  # @param service [Service, Symbol, String] Service ID (2 bytes)
  # @param id [String] Program ID (13 bytes)
  # @return [Hashie::Mash]    
  info:(area, service, id,callback) ->
    area = @_parseArea(area)
    service = @_parseService(service)
    requestParam = "info/#{area.id}/#{service.id}/#{id}.json?key=#{@apikey}"
    @get(requestParam,(result) ->
      if result
        callback(result)
      else
        Ti.API.info "error. result is #{result}"
    )
    
  # Get information of program that is on air now
  #
  # @param area [Area, Symbol, String] Area ID (3 bytes)
  # @param service [Service, Symbol, String] Service ID (2 bytes)
  # @return [Hashie::Mash]    
  now:(area,service,callback) ->
    area = @_parseArea(area)
    service = @_parseService(service)
    moment = require("lib/moment")
    
    date = moment().format("YYYY-MM-DD")
    requestParam =  "now/#{area.id}/#{service.id}.json?key=#{@apikey}"    
    @get(requestParam,(result) ->
      if result
        callback(result)
      else
        Ti.API.info "error. result is #{result}"
    )
    
  _parseArea:(area) ->
    _ = require("lib/underscore")
    data = _.where(@areaList,{"name":area})
    result =
      id:data[0].id
      name:data[0].name
    return result
    
  _parseGenre:(genre) ->
    _ = require("lib/underscore")
    data = _.where(@Genre,{"name":genre})
    result =
      id:data[0].id
      name:data[0].name
    result result
    
  _parseService:(service) ->
    _ = require("lib/underscore")
    data = _.where(@serviceList,{"name":service})
    result =
      id:data[0].id
      name:data[0].name
    return result

  _parseDate:(date) ->
    moment = require("lib/moment")
    return moment(date).format("YYYY-MM-DD")
    
module.exports = NHKProgram


