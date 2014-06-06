
#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

#define TRADE_TABLE @"e_trade"
#define TRADE_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ integer) ", TRADE_TABLE, KEY_UUID, KEY_CODE, KEY_NAME,  KEY_ORD_INDEX]
#define TRADE_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@) values (?, ?, ?, ?)", TRADE_TABLE, KEY_UUID, KEY_CODE, KEY_NAME, KEY_ORD_INDEX]
#define TRADE_BASE_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@ from %@ ", KEY_UUID, KEY_CODE, KEY_NAME, KEY_ORD_INDEX, TRADE_TABLE]

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

- (NSMutableArray *)trades
{
    NSString *sql = [NSString stringWithFormat:@"%@ order by %@", TRADE_BASE_QUERY_SQL, KEY_ORD_INDEX];
    return [self query:sql params:nil];
}

- (ZKHTradeEntity *)trade:(NSString *)tradeId
{
    NSString *sql = [NSString stringWithFormat:@"%@ where uuid = ?", TRADE_BASE_QUERY_SQL];
    return [self queryOne:sql params:@[tradeId]];
}

@end