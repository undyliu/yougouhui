
#import "ZKHData.h"
#import "ZKHConst.h"
#import "NSString+Utils.h"

#define SHOP_TRADE_TABLE @"e_shop_trade"
#define SHOP_TRADE_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text) ", SHOP_TRADE_TABLE, KEY_UUID, KEY_SHOP_ID, KEY_TRADE_ID]
#define SHOP_TRADE_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@) values (?, ?, ?)", SHOP_TRADE_TABLE, KEY_UUID, KEY_SHOP_ID, KEY_TRADE_ID]

#define SHOP_TABLE @"e_shop"
#define SHOP_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text) ", SHOP_TABLE, KEY_UUID, KEY_NAME, KEY_SHOP_IMG, KEY_LOCATION, KEY_ADDR, KEY_DESC, KEY_BUSI_LICENSE, KEY_OWNER, KEY_REGISTER_TIME, KEY_STATUS, KEY_BARCODE]
#define SHOP_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", SHOP_TABLE, KEY_UUID, KEY_NAME, KEY_SHOP_IMG, KEY_LOCATION, KEY_ADDR, KEY_DESC, KEY_BUSI_LICENSE, KEY_OWNER, KEY_REGISTER_TIME, KEY_STATUS, KEY_BARCODE]

#define SHOP_QUERY_BY_ID_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@ from %@ where %@ = ? ", KEY_UUID, KEY_NAME, KEY_SHOP_IMG, KEY_LOCATION, KEY_ADDR, KEY_DESC, KEY_BUSI_LICENSE, KEY_OWNER, KEY_REGISTER_TIME, KEY_STATUS, KEY_BARCODE, SHOP_TABLE, KEY_UUID]

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

#define SHOP_FIELD_UPDATE_SQL(__FIELD_NAME__) [NSString stringWithFormat:@"update %@ set %@=? where %@=?", SHOP_TABLE, __FIELD_NAME__, KEY_UUID]

- (void)updateShopDesc:(NSString *)uuid desc:(NSString *)desc
{
    [self executeUpdate:SHOP_FIELD_UPDATE_SQL(KEY_DESC) params:@[desc, uuid]];
}

- (void)updateShopName:(NSString *)uuid name:(NSString *)name
{
    [self executeUpdate:SHOP_FIELD_UPDATE_SQL(KEY_NAME) params:@[name, uuid]];
}

- (void)updateShopImage:(NSString *)uuid shopImage:(NSString *)shopImage
{
    [self executeUpdate:SHOP_FIELD_UPDATE_SQL(KEY_SHOP_IMG) params:@[shopImage, uuid]];
}

- (void)updateBusiLicense:(NSString *)uuid busiLicense:(NSString *)busiLicense
{
    [self executeUpdate:SHOP_FIELD_UPDATE_SQL(KEY_BUSI_LICENSE) params:@[busiLicense, uuid]];
}

#define  SHOP_TRADE_DEL_SQL [NSString stringWithFormat:@" delete from %@ where %@=?", SHOP_TRADE_TABLE, KEY_SHOP_ID]
- (void)updateshopTrades:(NSString *)uuid trades:(NSArray *)trades
{
    [self executeUpdate:SHOP_TRADE_DEL_SQL params:@[uuid]];
    
    for (ZKHShopTradeEntity *shopTrade in trades) {
        [self executeUpdate:SHOP_TRADE_UPDATE_SQL params:@[shopTrade.uuid, uuid, shopTrade.trade.uuid]];
    }
}

- (NSMutableArray *)shopTrades:(NSString *)uuid
{
    NSString *sql = @" select st.uuid, st.trade_id, t.code, t.name, t.ord_index from e_trade t, e_shop_trade st where t.uuid = st.trade_id and st.shop_id = ? ";
    NSArray *params =@[uuid];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSLog(@"sql : %@", sql);
    sqlite3 *database = nil;
    @try {
        database = [self openDatabase];
        sqlite3_stmt *stmt;
        
        @try {
            stmt = [self prepareStatement:sql params:params database:database];
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                ZKHShopTradeEntity *shopTrade = [[ZKHShopTradeEntity alloc] init];
                ZKHTradeEntity *trade = [[ZKHTradeEntity alloc] init];
                
                int i = 0;
                shopTrade.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                trade.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                trade.code = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                trade.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                trade.ordIndex = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                shopTrade.trade = trade;
                
                [result addObject:shopTrade];
            }
        }
        @catch (NSException *exception) {
            @throw exception;
        }
        @finally {
            sqlite3_finalize(stmt);
        }
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        [self closeDatabase:database];
    }
    return result;
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHShopEntity *shop = [[ZKHShopEntity alloc] init];
    
    int i = 0;
    shop.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    shop.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    shop.shopImg = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    NSString *location = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    shop.location = [[ZKHLocationEntity alloc] initWithString:location];
    
    shop.addr = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    shop.desc = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    shop.busiLicense = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    shop.owner = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    shop.registerTime = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    shop.status = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    shop.barcode = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    return shop;
}

- (ZKHShopEntity *)shop:(NSString *)uuid
{
    ZKHShopEntity *shop = [self queryOne:SHOP_QUERY_BY_ID_SQL params:@[uuid]];
    shop.trades = [self shopTrades:uuid];
    return shop;
}

@end