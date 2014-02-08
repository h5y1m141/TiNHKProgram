class ProgramListWindow
  constructor: () ->
    NHKProgram = require("model/nhk")
    config = Titanium.Filesystem.getFile(Titanium.Filesystem.resourcesDirectory, "model/config.json")
    file = config.read().toString()
    config = JSON.parse(file)
    @client = new NHKProgram(config)
    ActivityIndicator = require("ui/activityIndicator")
    @activityIndicator = new ActivityIndicator()
    @moment = require("lib/moment")
    @area = '東京'
    @service = "ＮＨＫ総合１"
    @date = "2014-02-09"

    win = Ti.UI.createWindow
      title:"#{@area}の#{@service}番組リスト"
      barColor:"#3261AB"
      tabBarHidden:false
      navBarHidden:false
      
    @tableView = Ti.UI.createTableView
      backgroundColor:"#f3f3f3"
      separatorStyle: Titanium.UI.iPhone.TableViewSeparatorStyle.NONE
      width:Ti.UI.FULL
    
    win.add @activityIndicator
    win.add @tableView
    @refreshTable()
    return win
    
  refreshTable:() ->
    @activityIndicator.show()  
    @client.list(@area,@service,@date,(result) =>  
      rows = [] 
      for program in result.list.g1
        row = Ti.UI.createTableViewRow
          width:Ti.UI.FULL
          height:80
          backgroundColor:"f3f3f3"
          programID:program.id
          
        title = Ti.UI.createLabel
          width:220
          height:50
          top:5
          left:70
          textAlign:'left'
          color:"#222"
          font:
            fontSize:14
            fontWeight:'bold'
          text:"#{program.title}"
            
        subtitle = Ti.UI.createLabel
          width:220
          height:20
          top:55
          left:70
          textAlign:'left'
          color:"#999"
          font:
            fontSize:12
          text:"#{program.subtitle}"
          
        timeTable = Ti.UI.createLabel
          width:60
          height:20
          top:20
          left:5
          color:"#007FB1"
          font:
            fontSize:12
            fontWeight:'bold'
          text:"#{@moment(program.start_time).format('HH:mm')}〜"


        row.add title
        row.add subtitle
        row.add timeTable
        rows.push row
      @activityIndicator.hide()      
      return @tableView.setData rows  
    )

module.exports = ProgramListWindow
