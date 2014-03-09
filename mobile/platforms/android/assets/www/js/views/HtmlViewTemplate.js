define(function () {
	return {
		getSearchHtml : function () {
			return '<div data-role="popup" id="popupSearch" data-theme="a" class="ui-corner-all" style="margin-top:3.5em;">'
			 + '<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>'
			 + '<form>'
			 + '<div style="padding:10px 20px;">'
			 + '<label for="un" class="ui-hidden-accessible">searchWord</label>'
			 + '<input type="search" id="searchWorld" name="searchWorld" id="un" value="" placeholder="请输入关键字" data-theme="a">'
			//+  '<a href="#" class="ui-btn ui-corner-all ui-shadow ui-btn-b ui-btn-icon-left ui-icon-check ui-btn-inline">搜索</a>'
			 + '</div>'
			 + '</form>'
			 + '</div>';
		}
	};
});
