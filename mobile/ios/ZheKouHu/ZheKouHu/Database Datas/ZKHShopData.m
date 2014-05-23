
#import "ZKHData.h"
#import "ZKHConst.h"
#import "NSString+Utils.h"

#define SHOP_TRADE_TABLE @"e_shop_trade"
#define SHOP_TRADE_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text) ", SHOP_TRADE_TABLE, KEY_UUID, KEY_SHOP_ID, KEY_TRADE_ID]
#define SHOP_TRADE_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@) values (?, ?, ?)", SHOP_TRADE_TABLE, KEY_UUID, KEY_SHOP_ID, KEY_TRADE_ID]

#define SHOP_TABLE @"e_shop"
#define SHOP_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text) ", SHOP_TABLE, KEY_UUID, KEY_NAME, KEY_SHOP_IMG, KEY_LOCATION, KEY_ADDR, KEY_DESC, KEY_BUSI_LICENSE, KEY_OWNER, KEY_REGISTER_TIME, KEY_STATUS, KEY_BARCODE]
#define SHOP_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", SHOP_TABLE, KEY_UUID, KEY_NAME, KEY_SHOP_IMG, KEY_LOCATION, KEY_ADDR, KEY_DESC, KEY_BUSI_LICENSE, KEY_OWNER, KEY_REGISTER_TIME, KEY_STATUS, KEY_BARCODE]

@implementation ZKHShopData

- (id)init
{
    if (self = [super init]) {
        [self createTable:SHOP_TRADE_CREATE_SQL];
        [self createTable:SHOP_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    if (data == nil || [data count] == 0) {
        return;
    }
    
    for (ZKHShopEntity *shop in data) {
        if ([shop.trades count] > 0) {
            ZKHTradeData *tradeData = [[ZKHTradeData alloc] init];
            for (ZKHShopTradeEntity *shopTrade in shop.trades) {
                ZKHTradeEntity *trade = shopTrade.trade;
                [tradeData save: @[trade]];
                [self executeUpdate:SHOP_TRADE_UPDATE_SQL params:@[shopTrade.uuid, shop.uuid, trade.uuid]];
            }
        }
        
        NSString *location = [NSString stringWithJSONObject:[shop.location toJSONObject]];
        [self executeUpdate:SHOP_UPDATE_SQL params:@[shop.uuid, shop.name, shop.shopImg, location, shop.addr, shop.desc, shop.busiLicense, shop.owner, shop.registerTime, shop.status, shop.barcode]];
    }
}

@end