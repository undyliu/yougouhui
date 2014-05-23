
#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

#define TRADE_TABLE @"e_trade"
#define TRADE_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ integer) ", TRADE_TABLE, KEY_UUID, KEY_CODE, KEY_NAME,  KEY_ORD_INDEX]
#define TRADE_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@) values (?, ?, ?, ?)", TRADE_TABLE, KEY_UUID, KEY_CODE, KEY_NAME, KEY_ORD_INDEX]
#define TRADE_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@ from %@ order by %@ ", KEY_UUID, KEY_CODE, KEY_NAME, KEY_ORD_INDEX, TRADE_TABLE, KEY_ORD_INDEX]

@implementation ZKHTradeData

- (id)init
{
    if (self = [super init]) {
        [self createTable:TRADE_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    if (data == nil || [data count] == 0) {
        return;
    }
    
    for (ZKHTradeEntity *trade in data) {
        [self executeUpdate:TRADE_UPDATE_SQL params:@[trade.uuid, trade.code, trade.name, trade.ordIndex]];
    }
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHTradeEntity *trade = [[ZKHTradeEntity alloc] init];
    
    int i = 0;
    trade.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    trade.code = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    trade.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    trade.ordIndex = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    return trade;
}

- (NSMutableArray *)getTrades
{
    return [self query:TRADE_QUERY_SQL params:nil];
}

@end