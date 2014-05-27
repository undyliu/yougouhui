//
//  ZKHEntity.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHEntity.h"
#import "NSString+Utils.h"
#import "ZKHConst.h"
#import "PinYin4Objc.h"

@implementation ZKHEntity

- (BOOL)isEqual:(id)object
{
    return [object isKindOfClass:[self class]] && [self.uuid isEqual:((ZKHEntity *)object).uuid];
}

@end

@implementation ZKHFileEntity

- (NSString *) aliasName
{
    //TODO:
    return _aliasName;
}

- (id)copyWithZone:(NSZone *)zone
{
    ZKHFileEntity *copy = [[[self class] allocWithZone:zone] init];
    copy.uuid = [self.uuid copyWithZone:zone];
    copy.fileUrl = [self.fileUrl copyWithZone:zone];
    copy.aliasName = [self.aliasName copyWithZone:zone];
    return copy;
}

@end

@implementation ZKHModuleEntity

@end

@implementation ZKHChannelEntity

@end

@implementation ZKHUserEntity
- (id)copyWithZone:(NSZone *)zone
{
    ZKHUserEntity *copy = [[[self class] allocWithZone:zone] init];
    copy.uuid = [self.uuid copyWithZone:zone];
    copy.name = [self.name copyWithZone:zone];
    copy.pwd  = [self.pwd copyWithZone:zone];
    copy.phone = [self.phone copyWithZone:zone];
    copy.photo = [self.photo copyWithZone:zone];
    copy.type = [self.type copyWithZone:zone];
    copy.registerTime = [self.registerTime copyWithZone:zone];
    //TODO copy friends
    return copy;
}

- (void) setName:(NSString *)name
{
    _name = name;

    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:ToneTypeWithoutTone];
    [outputFormat setVCharType:VCharTypeWithV];
    [outputFormat setCaseType:CaseTypeUppercase];
    
    _pinyinName = [PinyinHelper toHanyuPinyinStringWithNSString:_name withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[ZKHUserFriendsEntity class]]) {
        return [self isEqual:((ZKHUserFriendsEntity *)object).friend];
    }
    return [super isEqual:object];
}

-(NSMutableArray *)friends
{
    if (_friends == nil) {
        _friends = [[NSMutableArray alloc] init];
    }
    return _friends;
}

@end

@implementation ZKHUserFriendsEntity

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[ZKHUserEntity class]]) {
        return [_friend isEqual:object];
    }
    return [super isEqual:object];
}

@end

@implementation ZKHSettingEntity

@end

@implementation ZKHSyncEntity

@end

@implementation ZKHSaleEntity

@end

@implementation ZKHTradeEntity

@end

@implementation ZKHLocationEntity

- (id)initWithString:(NSString *)value
{
    if (self = [super init]) {
        NSDictionary *json = [value toJSONObject];
        self.radius = [json valueForKey:KEY_RADIUS];
        self.latitude = [json valueForKey:KEY_LATITUDE];
        self.longitude = [json valueForKey:KEY_LONGITUDE];
        self.addr = [json valueForKey:KEY_ADDR];
    }
    return self;
}

- (NSDictionary *)toJSONObject
{
    return @{KEY_RADIUS: self.radius,
             KEY_LATITUDE : self.latitude,
             KEY_LONGITUDE : self.longitude,
             KEY_ADDR : self.addr};
}

@end

@implementation ZKHShopTradeEntity

@end

@implementation ZKHShopEntity

@end
