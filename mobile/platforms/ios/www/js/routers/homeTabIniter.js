define(["jquery","collections/ChannelCollection","views/HomeTabView"],function(b,a,c){return{init:function(e){var d=new c({el:".home-page #homepage-tabs",collection:new a([],{})});if(!d.collection.length){d.collection.fetch({success:function(i,f,g){i.trigger("added");var h=e.success;if(h){h(i.toJSON())}},error:function(){alert("加载频道数据失败.")}}).done(function(){})}}}});