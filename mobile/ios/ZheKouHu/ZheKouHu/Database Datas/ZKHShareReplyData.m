#import "ZKHData.h"
#import "ZKHConst.h"

//#define SALE_DISC_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text) ", SALE_DISC_TABLE, KEY_UUID, KEY_SALE_ID, KEY_CONTENT, KEY_PUBLISHER, KEY_PUBLISH_TIME]
//#define SALE_DISC_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@,  %@) values (?, ?, ?, ?,?)", SALE_DISC_TABLE, KEY_UUID, KEY_SALE_ID, KEY_CONTENT, KEY_PUBLISHER, KEY_PUBLISH_TIME]
//#define SALE_DISC_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@, %@ from %@ where %@ = ? order by %@ desc ", KEY_UUID, KEY_SALE_ID, KEY_CONTENT, KEY_PUBLISHER, KEY_PUBLISH_TIME, SALE_DISC_TABLE, KEY_SALE_ID, KEY_PUBLISH_TIME]

@implementation ZKHShareReplyData

//- (id)init
//{
//    if (self = [super init]) {
//        [self createTable:SALE_DISC_CREATE_SQL];
//    }
//    return  self;
//}
//
//- (void)save:(NSArray *)data
//{
//    if ([data count] > 0) {
//        ZKHUserData *userData = [[ZKHUserData alloc] init];
//        for (ZKHSaleDiscussEntity *dis in data) {
//            ZKHUserEntity *publisher = dis.publisher;
//            [self executeUpdate:SALE_DISC_UPDATE_SQL params:@[dis.uuid, dis.sale.uuid, dis.content, publisher.uuid, dis.publishTime]];
//            [userData saveNoPwd:@[publisher]];
//        }
//    }
//    
//}
//
//- (id)processRow:(sqlite3_stmt *)stmt
//{
//    ZKHSaleDiscussEntity *dis = [[ZKHSaleDiscussEntity alloc] init];
//    
//    int i = 0;
//    
//    dis.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
//    dis.sale = [[ZKHSaleEntity alloc] init];
//    dis.sale.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
//    dis.content = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
//    dis.publishTime = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
//    
//    ZKHUserEntity *publisher = [[ZKHUserEntity alloc] init];
//    publisher.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
//    publisher.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
//    publisher.phone = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
//    
//    publisher.photo = [[ZKHFileEntity alloc] init];
//    publisher.photo.aliasName = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
//    
//    dis.publisher = publisher;
//    
//    return dis;
//}
@end