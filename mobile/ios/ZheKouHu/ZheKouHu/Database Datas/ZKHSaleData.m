#import "ZKHData.h"
#import "ZKHConst.h"


#define SALE_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text) ", SALE_TABLE, KEY_UUID, KEY_TITLE, KEY_CONTENT, KEY_IMG, KEY_SHOP_ID, KEY_SHOP_NAME, KEY_START_DATE, KEY_END_DATE, KEY_PUBLISHER, KEY_PUBLISH_TIME, KEY_PUBLISH_DATE, KEY_TRADE_ID, KEY_STATUS, KEY_DIS_COUNT, KEY_VISIT_COUNT, KEY_CHANNEL_ID, KEY_LOCATION]
#define SALE_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", SALE_TABLE, KEY_UUID, KEY_TITLE, KEY_CONTENT, KEY_IMG, KEY_SHOP_ID, KEY_SHOP_NAME, KEY_START_DATE, KEY_END_DATE, KEY_PUBLISHER, KEY_PUBLISH_TIME, KEY_PUBLISH_DATE, KEY_TRADE_ID, KEY_STATUS, KEY_DIS_COUNT, KEY_VISIT_COUNT, KEY_CHANNEL_ID, KEY_LOCATION]
#define SALE_BASE_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@ from %@ ", KEY_UUID, KEY_TITLE, KEY_CONTENT, KEY_IMG, KEY_SHOP_ID, KEY_SHOP_NAME, KEY_START_DATE, KEY_END_DATE, KEY_PUBLISHER, KEY_PUBLISH_TIME, KEY_PUBLISH_DATE, KEY_TRADE_ID, KEY_STATUS, KEY_DIS_COUNT, KEY_VISIT_COUNT, KEY_CHANNEL_ID, KEY_LOCATION, SALE_TABLE]

#define SALE_IMG_TABLE @"e_sale_img"
#define SALE_IMG_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text) ", SALE_IMG_TABLE, KEY_UUID, KEY_SALE_ID, KEY_IMG, KEY_ORD_INDEX]
#define SALE_IMG_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@) values (?, ?, ?, ?)", SALE_IMG_TABLE, KEY_UUID, KEY_SALE_ID, KEY_IMG, KEY_ORD_INDEX]

@implementation ZKHSaleData

- (id)init
{
    if (self = [super init]) {
        [self createTable:SALE_CREATE_SQL];
        [self createTable:SALE_IMG_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    for (ZKHSaleEntity *sale in data) {
        ZKHShopEntity *shop = sale.shop;
        ZKHLocationEntity *location = shop.location;
        ZKHUserEntity *publisher = sale.publisher;
        [self executeUpdate:SALE_UPDATE_SQL params:@[sale.uuid, sale.title, sale.content, sale.img, shop.uuid, shop.name, sale.startDate, sale.endDate, publisher.uuid, sale.publishTime, sale.publishDate, sale.tradeId, sale.status, sale.discussCount, sale.visitCount, sale.channelId, [location toString]]];
        
        NSMutableArray *images = sale.images;
        for (ZKHFileEntity *file in images) {
            [self executeUpdate:SALE_IMG_UPDATE_SQL params:@[file.uuid, sale.uuid, file.aliasName, file.ordIndex]];
        }
    }
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHSaleEntity *sale = [[ZKHSaleEntity alloc] init];
    
    int i = 0;
    
    sale.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sale.title = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sale.content = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sale.img = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    ZKHShopEntity *shop = [[ZKHShopEntity alloc] init];
    shop.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    shop.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    sale.startDate = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sale.endDate = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    ZKHUserEntity *publisher = [[ZKHUserEntity alloc] init];
    publisher.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    sale.publishTime = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sale.publishDate = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sale.tradeId = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sale.status = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sale.discussCount = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sale.visitCount = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    sale.channelId = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    NSString *locString = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    ZKHLocationEntity *location = [[ZKHLocationEntity alloc] initWithString:locString];
    
    shop.location = location;
    sale.shop = shop;
    sale.publisher = publisher;
    
    return sale;
}

- (NSMutableArray *)salesForChannel:(NSString *)channelId
{
    NSMutableString *sql = [[NSMutableString alloc] initWithString:SALE_BASE_QUERY_SQL];
    [sql appendString:@" where status = 1 "];
    if (![channelId isEqualToString:@"0"]) {
        [sql appendString:@" and channel_id = ? "];
    }
    [sql appendString:@" order by publish_time desc "];
    
    NSArray *params = @[channelId];
    return  [self query:sql params:params];
}

- (ZKHSaleEntity *)sale:(NSString *)uuid
{
    NSMutableString *sql = [[NSMutableString alloc] initWithString:SALE_BASE_QUERY_SQL];
    [sql appendString:@" where uuid = ? "];
    NSArray *params = @[uuid];
    return  [self queryOne:sql params:params];
}

@end