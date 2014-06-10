
#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"
#import "NSString+Utils.h"

#define SHARE_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text) ", SHARE_TABLE, KEY_UUID, KEY_CONTENT, KEY_PUBLISHER, KEY_PUBLISH_TIME, KEY_PUBLISH_DATE, KEY_SHOP_ID, KEY_ACCESS_TYPE]
#define SHARE_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?, ?)", SHARE_TABLE, KEY_UUID, KEY_CONTENT, KEY_PUBLISHER, KEY_PUBLISH_TIME, KEY_PUBLISH_DATE, KEY_SHOP_ID, KEY_ACCESS_TYPE]

#define SHARE_IMG_TABLE @"e_share_img"
#define SHARE_IMG_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text) ", SHARE_IMG_TABLE, KEY_UUID, KEY_SHARE_ID, KEY_IMG, KEY_ORD_INDEX]
#define SHARE_IMG_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@) values (?, ?, ?, ?)", SHARE_IMG_TABLE, KEY_UUID, KEY_SHARE_ID, KEY_IMG, KEY_ORD_INDEX]

static NSString *shareQuery_base = @" select s.uuid, s.content, s.publish_time, s.publish_date "
                                    ", s.shop_id, sh.name, sh.location "
                                    ", s.publisher, u.name as publisher_name, u.photo "
                                    " from e_share s "
                                    " inner join e_user u on s.publisher = u.uuid "
                                    " left join e_shop sh on s.shop_id = sh.uuid ";
@implementation ZKHShareData

- (id)init
{
    if (self = [super init]) {
        [self createTable:SHARE_CREATE_SQL];
        [self createTable:SHARE_IMG_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    for (ZKHShareEntity *share in data) {
        ZKHUserEntity *publisher = share.publisher;
        ZKHShopEntity *shop = share.shop;
        [self executeUpdate:SHARE_UPDATE_SQL params:@[share.uuid, share.content, publisher.uuid, share.publishTime, share.publishDate, (shop == nil? @"" : shop.uuid), share.accessType]];
        
        //发布者
        [[[ZKHUserData alloc] init] saveNoPwd:@[publisher]];
        
        //图片
        int index = 0;
        NSMutableArray *files = share.imageFiles;
        for (ZKHFileEntity *file in files) {
            [self executeUpdate:SHARE_IMG_UPDATE_SQL params:@[file.uuid, share.uuid, file.aliasName, [NSString stringWithFormat:@"%d", index++]]];
        }
        
        //评论
        NSMutableArray *comments = share.comments;
        [[[ZKHShareCommentData alloc] init] save:comments];
        
        //商铺
        if (shop) {
            [[[ZKHShopData alloc] init] save:@[shop]];
        }
    }
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHShareEntity *share = [[ZKHShareEntity alloc] init];
    
    int i = 0;
    
    share.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    share.content = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    share.publishTime = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    share.publishDate = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    NSString *shopId = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    if (![NSString isNull:shopId]) {
        share.shop = [[ZKHShopEntity alloc] init];
        share.shop.uuid = shopId;
        share.shop.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
        
        share.shop.location = [[ZKHLocationEntity alloc] initWithString:[[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)]];
    }else{
        i += 2;
    }
    
    ZKHUserEntity *publisher = [[ZKHUserEntity alloc] init];
    publisher.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    publisher.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    publisher.photo = [[ZKHFileEntity alloc] init];
    publisher.photo.aliasName = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    share.publisher = publisher;
    
    share.comments = [[[ZKHShareCommentData alloc] init] commentsForShare:share.uuid];
    
    share.imageFiles = [self shareImages:share.uuid];
    
    return share;
}

- (NSMutableArray *)friendShares:(NSString *)userId offset:(int)offset
{
    NSMutableString *sql = [NSMutableString stringWithString:shareQuery_base];
    [sql appendString:@" where (s.access_type = 1) "];
    [sql appendString:@" or ((s.access_type = 2 and (u.uuid = ? or u.uuid in (select f.friend_id from e_friend f where f.user_id = ?)))) "];
    [sql appendString:@" order by s.publish_time desc "];
    [sql appendFormat:@" limit %d offset %d ", DEFAULT_PAGE_SIZE, offset];
    
    NSArray *params = @[userId, userId];
    
    return [self query:sql params:params];
}

- (NSMutableArray *)shareImages:(NSString *)shareId
{
    NSString *sql = @" select uuid, img, ord_index from e_share_img where share_id = ? order by ord_index ";
    NSMutableArray *params = [[NSMutableArray alloc] init];
    [params addObject:shareId];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSLog(@"sql : %@", sql);
    sqlite3 *database = nil;
    @try {
        database = [self openDatabase];
        sqlite3_stmt *stmt;
        
        @try {
            stmt = [self prepareStatement:sql params:params database:database];
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                ZKHFileEntity *file = [[ZKHFileEntity alloc] init];
                
                int i = 0;
                file.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                file.aliasName = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                file.ordIndex = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
                
                [result addObject:file];
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

- (void)deleteShare:(NSString *)uuid
{
    NSString *sql = @" delete from e_share where uuid = ?";
    NSArray *params = @[uuid];
    [self executeUpdate:sql params:params];
    
    //删除图片
    sql = @" delete from e_share_img where share_id = ? ";
    [self executeUpdate:sql params:params];
    
    //删除评论
    [[[ZKHShareCommentData alloc] init] deleteCommentsByShare:uuid];
    
    //删除商家回复
    
}
@end