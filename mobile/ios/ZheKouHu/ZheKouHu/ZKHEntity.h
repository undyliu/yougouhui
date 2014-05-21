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


@interface ZKHModuleEntity : ZKHEntity
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *ordIndex;

@end

@interface ZKHChannelEntity : ZKHEntity
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *parentId;
@property (strong, nonatomic) NSString *ordIndex;
@end

@interface ZKHUserEntity : ZKHEntity
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *pwd;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *photo;
@property (strong, nonatomic) NSString *registerTime;
@end

@interface ZKHSettingEntity : ZKHEntity
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *img;
@property (strong, nonatomic) NSString *ordIndex;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *userId;
@end

@interface ZKHSyncEntity : ZKHEntity
@property (strong, nonatomic) NSString *tableName;
@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) NSString *updateTime;
@end

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
@end