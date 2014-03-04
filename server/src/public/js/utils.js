
define(function () {
	return {
		setDomVisibleExcept : function (jqObj, exceptDomIds) {
			for (var i = 0; i < jqObj.length; i++) {
				var obj = jqObj[i];
				var id = obj.getAttribute("id");
				$('#' + id).css('display', 'none');
			}

			for (var i = 0; i < exceptDomIds.length; i++) {
				$('#' + exceptDomIds[i]).css('display', 'block');
			}
		},

		openPopDiv : function (popDivId, $link) {
			if (!popDivId) {
				popDivId = $link.attr('href');
			}
			var popup = $(popDivId);
			if (popup && popup.length > 0) {
				var options = {
					transition : $link.jqmData("transition"),
					positionTo : $link.jqmData("position-to")
				};
				var positionTo = $link.jqmData("position-to");
				if(positionTo != 'window'){
					var offset = $link.offset();
					options.x = offset.left + $link.outerWidth() / 2;
					options.y = offset.top + $link.outerHeight() / 2;
				}
				popup.popup("open", options);
			}
		},
		
		closePopDiv: function(popDivId){
			var popup = $(popDivId);
			popup.popup( "close" );
		}
	};
});
