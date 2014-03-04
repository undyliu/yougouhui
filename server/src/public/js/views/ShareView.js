
define([ "jquery", "backbone", "views/BackModelView", "utils" ]
	, function( $, Backbone, CallbackView, Utils ) {
		var shareViewObj = null;
		var geoLocation = null;
		
    var View = CallbackView.extend( {
    		constructor:function(options) {
    			View.__super__.constructor.call(this, options);
    		},
    		
        initialize: function() {
          View.__super__.initialize.call(this);
					shareViewObj = this;
        },

        render: function() {
          View.__super__.render.call(this);
          
          var btnId = 'main-head-share-save-link';          
          var publishBtnItem = $('#' + btnId);
          if(publishBtnItem && publishBtnItem.length > 0){
          	publishBtnItem.css("display", "block");
          }else{
          	var publishBtnHtml = '<a id="' + btnId + '" class="top-header ui-btn ui-btn-inline ui-corner-all ui-icon-lock ui-btn-icon-left">保存</a>';
          	$('#main-head-search-link').after(publishBtnHtml);
          }
              
          Utils.setDomVisibleExcept($('[data-role="header"].app-header div a'), [btnId]);
          
					//弹出拍照和从相册选择照片的pop框
					$( "#share-choose-pic-img" ).on( "click", function() {
						Utils.openPopDiv("#share-choose-pic-pop", $(this));
						//shareViewObj.onPicChooseSuccess('img/friend.png');
					});
										
					//拍照
					$( "#li-share-camera-pic" ).on( "click", function() {
						Utils.closePopDiv('#share-choose-pic-pop');
						navigator.camera.getPicture(shareViewObj.onPicChooseSuccess, shareViewObj.onFail, { quality: 20, allowEdit: true,
							sourceType : Camera.PictureSourceType.CAMERA,
							destinationType: Camera.DestinationType.FILE_URI });
					});
					
					//从相册选择照片
					$( "#li-share-choose-pic" ).on( "click", function() {
						Utils.closePopDiv('#share-choose-pic-pop');
						navigator.camera.getPicture(shareViewObj.onPicChooseSuccess, shareViewObj.onFail, { quality: 20, allowEdit: true,
							sourceType : Camera.PictureSourceType.PHOTOLIBRARY,
							destinationType: Camera.DestinationType.FILE_URI });
					});
									
					//TODO:放到form提交时才获取位置信息
					try{
						//navigator.geolocation.getCurrentPosition(shareViewObj.onGeolocationSuccess
						//	, shareViewObj.ongeolocationError, {timeout: 10000});
					}catch(e){
					}
					
          return this;
        },
				
				onPicChooseSuccess: function(imgUrl){
					var addPicButton = $('#share-choose-pic-div');
					var imageName = imgUrl;
					var pos = imageName.lastIndexOf('.');
					if(pos > 0){
						imageName = imageName.substring(0, pos);
					}
					pos = imageName.lastIndexOf('/');
					if(pos > 0){
						imageName = imageName.substring(pos + 1, imageName.length);
					}
					var imgHrefId = 'share-img-' + imageName;	
					var imgHtml = '<div class="share-choose-pic" style="max-width:20%">'
											+	'<a href="#" data-rel="popup" id="' + imgHrefId + '" data-position-to="window" data-transition="fade" class="share-popup-img"> '
											+ ' <img src="' + imgUrl + '" height="150px" style="margin:5px;max-width:100%"/> '
											+ ' </a> </div>';
					addPicButton.before(imgHtml);	
					
					$("#" + imgHrefId).on( "click", function() {
					  var imgUrl = $(this).find('img').attr('src');
						var popDivId = 'share-pop-img-id-' + imageName;
						
						if($('#' + popDivId).length == 0){
							var popup = ' <div data-role="popup" id="' + popDivId + '" data-overlay-theme="b" data-theme="b" data-corners="false"> '
										+ ' <a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">关闭</a> '
										+ ' <img src="' + imgUrl + '" width="' + $.mobile.activePage.width() + '" height="' + $.mobile.activePage.height() + '"/> '
										+ ' </div>';
							$.mobile.activePage.append( popup ).trigger( "create" );
						}
						
						Utils.openPopDiv("#" + popDivId, $(this));
					});
				},
				
				onFail: function(message) {
					alert('获取照片失败，原因：' + message);
				},
				
				onGeolocationSuccess: function(position){
					geoLocation = position;
				},
				
				ongeolocationError: function(error){
					alert('获取地理位置出错，原因：' + error.message);
				}
    } );

    return View;

} );