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