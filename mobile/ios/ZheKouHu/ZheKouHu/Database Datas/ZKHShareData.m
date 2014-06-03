
#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

#define SHARE_TABLE @"e_share"
#define SHARE_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text) ", SHARE_TABLE, KEY_UUID, KEY_CONTENT, KEY_PUBLISHER, KEY_PUBLISH_TIME, KEY_PUBLISH_DATE, KEY_SHOP_ID, KEY_ACCESS_TYPE]
#define SHARE_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?, ?)", SHARE_TABLE, KEY_UUID, KEY_CONTENT, KEY_PUBLISHER, KEY_PUBLISH_TIME, KEY_PUBLISH_DATE, KEY_SHOP_ID, KEY_ACCESS_TYPE]

#define SHARE_IMG_TABLE @"e_share_img"
#define SHARE_IMG_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text) ", SHARE_IMG_TABLE, KEY_UUID, KEY_SHARE_ID, KEY_IMG, KEY_ORD_INDEX]
#define SHARE_IMG_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@) values (?, ?, ?, ?)", SHARE_IMG_TABLE, KEY_UUID, KEY_SHARE_ID, KEY_IMG, KEY_ORD_INDEX]

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
        
        int index = 0;
        NSMutableArray *files = share.imageFiles;
        for (ZKHFileEntity *file in files) {
            [self executeUpdate:SHARE_IMG_UPDATE_SQL params:@[file.uuid, share.uuid, file.aliasName, [NSString stringWithFormat:@"%d", index++]]];
        }
    }
}
@end