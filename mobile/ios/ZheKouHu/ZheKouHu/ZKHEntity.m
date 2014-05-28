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

- (id)initWithJsonObject:(id)jsonShop
{
    if (self = [super init]) {
        self.uuid = [jsonShop valueForKey:KEY_UUID];
        self.name = [jsonShop valueForKey:KEY_NAME];
        self.addr = [jsonShop valueForKey:KEY_ADDR];
        self.desc = [jsonShop valueForKey:KEY_DESC];
        self.shopImg = [jsonShop valueForKey:KEY_SHOP_IMG];
        self.busiLicense = [jsonShop valueForKey:KEY_BUSI_LICENSE];
        self.registerTime = [jsonShop valueForKey:KEY_REGISTER_TIME];
        self.owner = [jsonShop valueForKey:KEY_OWNER];
        self.status = [NSString stringWithFormat:@"%@", [jsonShop valueForKey:KEY_STATUS]];
        self.barcode = [jsonShop valueForKey:KEY_BARCODE];
        
        //处理主营业务
        NSMutableArray *trades = [[NSMutableArray alloc] init];
        id tradeList = [jsonShop valueForKey:KEY_TRADE_LIST];
        for (NSDictionary *jsonTrade in tradeList) {
            ZKHTradeEntity *trade = [[ZKHTradeEntity alloc] init];
            trade.uuid = [jsonTrade valueForKey:KEY_TRADE_ID];
            trade.code = [jsonTrade valueForKey:KEY_CODE];
            trade.name = [jsonTrade valueForKey:KEY_NAME];
            trade.ordIndex = [jsonTrade valueForKey:KEY_ORD_INDEX];
            
            ZKHShopTradeEntity *shopTrade = [[ZKHShopTradeEntity alloc] init];
            shopTrade.uuid = [jsonTrade valueForKey:KEY_UUID];
            shopTrade.trade = trade;
            
            [trades addObject:shopTrade];
        }
        self.trades = trades;
        
        //处理地理位置
        ZKHLocationEntity *location = [[ZKHLocationEntity alloc]
                                       initWithString:[jsonShop valueForKey:KEY_LOCATION]];
        self.location = location;
    }
    return self;
}

@end

@implementation ZKHFavoritEntity

@end
