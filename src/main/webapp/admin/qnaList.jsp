<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>     LIST11    </title>

	<!-- 슬릭그리드 기본 CSS -->
	<link rel="stylesheet" href="/grid/slick.grid.css" type="text/css"/>
  	<link rel="stylesheet" href="/grid/controls/slick.pager.css" type="text/css"/>
  	<link rel="stylesheet" href="/grid/css/smoothness/jquery-ui-1.8.16.custom.css" type="text/css"/>
  	<link rel="stylesheet" href="/grid/examples.css" type="text/css"/>
  	<link rel="stylesheet" href="/grid/controls/slick.columnpicker.css" type="text/css"/>
	<script src="/js/jquery-1.12.4.js"></script>

</head>

<style>
    .cell-title {
      font-weight: bold;
    }
    .cell-effort-driven {
      text-align: center;
    }
    .cell-selection {
      border-right-color: silver;
      border-right-style: solid;
      background: #f5f5f5;
      color: gray;
      text-align: right;
      font-size: 10px;
    }
    .slick-row.selected .cell-selection {
      background-color: transparent; /* show default selected row background */
    }
</style>

<body>
<div style="position:relative">
  <div style="width:100%;">
    <div class="grid-header" style="width:100%">
      <label>     사원목록 11    </label>
      <span style="float:right" class="ui-icon ui-icon-search" title="Toggle search panel"
            onclick="toggleFilterRow()"></span>
    </div>
    <div id="myGrid" style="width:100%;height:500px;"></div>
    <div id="pager" style="width:100%;height:20px;"></div>
  </div>
</div>
<div id="inlineFilterPanel" style="display:none;background:#dddddd;padding:3px;color:black;">
  Show tasks with title including <input type="text" id="txtSearch2">
  and % at least &nbsp;
  <div style="width:100px;display:inline-block;" id="pcSlider2"></div>
</div>

<!-- jQuery 라이브러리 (jQuery, jQuery.event.drag -->

<script src="/grid/lib/firebugx.js"></script>
<script src="/grid/lib/jquery-1.7.min.js"></script>
<script src="/grid/lib/jquery-ui-1.8.16.custom.min.js"></script>
<script src="/grid/lib/jquery.event.drag-2.2.js"></script>

<script src="/grid/slick.core.js"></script>
<script src="/grid/slick.formatters.js"></script>
<script src="/grid/slick.editors.js"></script>
<script src="/grid/plugins/slick.rowselectionmodel.js"></script>
<script src="/grid/slick.grid.js"></script>
<script src="/grid/slick.dataview.js"></script>
<script src="/grid/controls/slick.pager.js"></script>
<script src="/grid/controls/slick.columnpicker.js"></script>

<script>
var dataView;
var grid;
var data = [];
var columns = [
	{id:"num", name: "#", field: "num", behavior: "select", cssClass: "cell-selection", width: 40, resizable: false, selectable: false },
	{id:"title",name:"제목",field:"title", width: 200, behavior: "select", editor: Slick.Editors.Text, resizable: false,validator: requiredFieldValidator, selectable: false ,sortable: true},
	{id:"name",name:"이름",field:"name", width: 150, minWidth: 120, cssClass: "cell-title", editor: Slick.Editors.Text, sortable: true},
	{id:"userid",name:"아이디",field:"userid", width: 200, editor: Slick.Editors.Text, sortable: true},
	{id:"rdate",name:"등록일",field:"rdate", width: 150, editor: Slick.Editors.Date, sortable: true},
	{id:"hit",name:"조회수",field:"hit", width: 150, editor: Slick.Editors.Text, sortable: true}
];
var options = { 
	editable: true,
	enableAddRow: false,
	enableCellNavigation: true,
	asyncEditorLoading: true,
	forceFitColumns: true,
	enableCellNavigation: true,
    enableColumnReorder: false,
    multiColumnSort: true,
	topPanelHeight: 50
};

var sortcol = "name";
var sortdir = 1;
var percentCompleteThreshold = 0;
var searchString = "";

var sortcol = "title";
var sortdir = 1;
var percentCompleteThreshold = 0;
var searchString = "";

function requiredFieldValidator(value) {
  if (value == null || value == undefined || !value.length) {
    return {valid: false, msg: "This is a required field"};
  }
  else {
    return {valid: true, msg: null};
  }
}

function myFilter(item, args) {
  if (args.searchString != "" && item["name"].indexOf(args.searchString) == -1) {
    return false;
  }

  return true;
}

function percentCompleteSort(a, b) {
  return a["percentComplete"] - b["percentComplete"];
}

function comparer(a, b) {
  var x = a[sortcol], y = b[sortcol];
  return (x == y ? 0 : (x > y ? 1 : -1));
}

function toggleFilterRow() {
	grid.setTopPanelVisibility(!grid.getOptions().showTopPanel);
}


$(".grid-header .ui-icon")
        .addClass("ui-state-default ui-corner-all")
        .mouseover(function (e) {
          $(e.target).addClass("ui-state-hover")
        })
        .mouseout(function (e) {
          $(e.target).removeClass("ui-state-hover")
        });


var gridData = [];
	
$(function(){
	
	$.ajax({
	    type: 'POST',
	    data : '',
	    url: '/selectslickList.do',
	    dataType: 'json',
	    success: function(data){
	    	var num = 1;
	    	for(var i=0; i<data.length; i++) {
	    		gridData[i]={
	    			num:i+1,
	    			title:data[i].title,
	    			name:data[i].name,
	    			userid:data[i].userid,
	    			rdate:data[i].rdate,
	    			hit:data[i].hit
	    		};
	    	} 
	    	//dataView = new Slick.Data.DataView();
	  		grid = new Slick.Grid("#myGrid", gridData, columns, options);
	  		grid.setSelectionModel(new Slick.RowSelectionModel());			
			
	  		
	  		
	  		grid.onClick.subscribe(function (e) {
	  			var cell = grid.getCellFromEvent(e);
	  			if(grid.getColumns()[cell.cell].id == "title") {
	  				//alert(grid.getColumns()[cell.cell].name);
	  			}
			});
	  		grid.onCellChange.subscribe(function (e, args) {
	  			alert(args.data);
	  		/* // Update an existing item.
	  			var item = dataView.getItemById('l4');
	  			item['lang'] = 'Clojure';
	  			dataView.updateItem('l4', item);
	  			//dataView.updateItem(args.item.id, args.item); */
	  		});
	  	  grid.onSort.subscribe(function (e, args) {
	  	      var cols = args.sortCols;
	  	    	gridData.sort(function (dataRow1, dataRow2) {
	  	        for (var i = 0, l = cols.length; i < l; i++) {
	  	          var field = cols[i].sortCol.field;
	  	          var sign = cols[i].sortAsc ? 1 : -1;
	  	          var value1 = dataRow1[field], value2 = dataRow2[field];
	  	          var result = (value1 == value2 ? 0 : (value1 > value2 ? 1 : -1)) * sign;
	  	          if (result != 0) {
	  	            return result;
	  	          }
	  	        }
	  	        return 0;
	  	      });
	  	      grid.invalidate();
	  	      grid.render();
	  	    });
	  		
	    },
	    error: function(request,status,error) {
	    	var code = request.status;
	    	var message = request.responseText;
	    	var err = error;
	    	alert(code + "\n" + message + "\n" + err);
	    }
	}); 
	 
		
});



</script>


</body>
</html>