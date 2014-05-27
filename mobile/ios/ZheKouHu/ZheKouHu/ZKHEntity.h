//
//  ZKHEntity.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKHEntity : NSObject
@property (strong, nonatomic) NSString *uuid;
@end

//文件
@interface ZKHFileEntity : ZKHEntity<NSCopying>
@property (strong, nonatomic) NSString *fileUrl;
@property (strong, nonatomic) NSString *aliasName;
@end

//功能模块
@interface ZKHModuleEntity : ZKHEntity
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *ordIndex;

@end

//栏目
@interface ZKHChannelEntity : ZKHEntity
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *parentId;
@property (strong, nonatomic) NSString *ordIndex;
@end

//用户
@interface ZKHUserEntity : ZKHEntity<NSCopying>
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *pwd;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) ZKHFileEntity *photo;
@property (strong, nonatomic) NSString *registerTime;
@property (strong, nonatomic) NSMutableArray *friends;

@property (strong, nonatomic, readonly) NSString *pinyinName;
@end

//用户的朋友对象，依附于用户，进行包含有朋友对象
@interface ZKHUserFriendsEntity : ZKHEntity
@property (strong, nonatomic) ZKHUserEntity *friend;
@end

//设置
@interface ZKHSettingEntity : ZKHEntity
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *img;
@property (strong, nonatomic) NSString *ordIndex;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *userId;
@end

//本地与远程同步记录
@interface ZKHSyncEntity : ZKHEntity
@property (strong, nonatomic) NSString *tableName;
@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) NSString *updateTime;
@end

//活动
@class ZKHShopEntity;
@interface ZKHSaleEntity : ZKHEntity
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *startDate;
@property (strong, nonatomic) NSString *endDate;
@property (strong, nonatomic) NSString *tradeId;
@property (strong, nonatomic) NSString *visitCount;
@property (strong, nonatomic) NSString *discussCount;
@property (strong, nonatomic) NSString *publishTime;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *img;
@property (strong, nonatomic) ZKHShopEntity *shop;
@property (strong, nonatomic) ZKHUserEntity *publisher;
@property (strong, nonatomic) NSMutableArray *images;
@end

//主营业务
@interface ZKHTradeEntity : ZKHEntity
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ordIndex;
@end

//地理位置
@interface ZKHLocationEntity : NSObject
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *radius;
@property (strong, nonatomic) NSString *addr;

- (id) initWithString:(NSString *)value;
- (NSDictionary *)toJSONObject;
@end

//商铺的主营业务对象，依附于商铺，仅需包含有主营业务对象
@interface ZKHShopTradeEntity : ZKHEntity
@property (strong, nonatomic) ZKHTradeEntity *trade;
@end

//商铺
@interface ZKHShopEntity : ZKHEntity
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *addr;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *shopImg;
@property (strong, nonatomic) NSString *busiLicense;
@property (strong, nonatomic) NSString *registerTime;
@property (strong, nonatomic) NSString *owner;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *barcode;
@property (strong, nonatomic) ZKHLocationEntity *location;
@property (strong, nonatomic) NSMutableArray *trades;
@property (strong, nonatomic) NSMutableArray *employees;
@end