define(["jquery","backbone","models/CommonModel","config"],function(d,e,c,a){var b=e.Collection.extend({initialize:function(g,f){this.channelCode=f.channelCode;this.channelId=f.channelId;this.channelName=f.channelName;this.parentId=f.parentId},model:c,url:function(){if("other"==this.channelCode){return a.getBaseUrl()+"/getActiveChannels/"+this.channelId}else{return a.getBaseUrl()+"/getActivities/"+this.channelId}}});return b});