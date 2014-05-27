
#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

#define USER_TABLE @"e_user"
#define USER_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text, %@ text, %@ text, %@ text, %@ text) ", USER_TABLE, KEY_UUID, KEY_NAME, KEY_PWD, KEY_TYPE, KEY_PHONE, KEY_PHOTO, KEY_REGISTER_TIME]
#define USER_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?, ?)", USER_TABLE, KEY_UUID, KEY_NAME, KEY_PWD, KEY_TYPE, KEY_PHONE, KEY_PHOTO, KEY_REGISTER_TIME]
#define USER_UPDATE_NO_PWD_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@, %@, %@, %@) values (?, ?, ?, ?, ?, ?)", USER_TABLE, KEY_UUID, KEY_NAME, KEY_TYPE, KEY_PHONE, KEY_PHOTO, KEY_REGISTER_TIME]
#define USER_BY_PHONE_QUERY_SQL [NSString stringWithFormat:@" select %@, %@, %@, %@, %@, %@, %@ from %@ where %@ = ? ", KEY_UUID, KEY_NAME, KEY_PWD, KEY_TYPE, KEY_PHONE, KEY_PHOTO, KEY_REGISTER_TIME, USER_TABLE, KEY_PHONE]

#define USER_FRIEND_TABLE @"e_friend"
#define USER_FRIEND_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text) ", USER_FRIEND_TABLE, KEY_UUID, KEY_USER_ID, KEY_FRIEND_ID]
#define USER_FRIEND_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@) values (?, ?, ?)", USER_FRIEND_TABLE, KEY_UUID, KEY_USER_ID, KEY_FRIEND_ID]

@implementation ZKHUserData

- (id)init
{
    if (self = [super init]) {
        [self createTable:USER_CREATE_SQL];
        [self createTable:USER_FRIEND_CREATE_SQL];
    }
    return self;
}

- (void)save:(NSArray *)data
{
    if (data == nil || [data count] == 0) {
        return;
    }
    
    for (ZKHUserEntity *user in data) {
        NSObject *photo = user.photo == nil ?  @"": user.photo.aliasName;
        [self executeUpdate:USER_UPDATE_SQL params:@[user.uuid, user.name, user.pwd, user.type, user.phone, photo, user.registerTime]];
        
        [self saveFriends:user.uuid friends:[user.friends copy]];
    }
}

- (void)saveNoPwd:(NSArray *)users
{
    if (users == nil || [users count] == 0) {
        return;
    }
    
    for (ZKHUserEntity *user in users) {
        NSObject *photo = user.photo == nil ?  @"": user.photo.aliasName;
        [self executeUpdate:USER_UPDATE_NO_PWD_SQL params:@[user.uuid, user.name, user.type, user.phone, photo, user.registerTime]];
    }
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    ZKHUserEntity *user = [[ZKHUserEntity alloc] init];
    
    int i = 0;
    user.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    user.name = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    //user.pwd = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    char * pwd = (char*)sqlite3_column_text(stmt, i++);
    if (pwd != NULL) {
        user.pwd = [[NSString alloc] initWithUTF8String:pwd];
    }
    
    user.type = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    user.phone = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    ZKHFileEntity *photo = [[ZKHFileEntity alloc] init];
    photo.aliasName = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    user.photo = photo;
    
    user.registerTime = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
    
    return user;
}

- (ZKHUserEntity *)user:(NSString *)phone
{
    return (ZKHUserEntity *)[self queryOne:USER_BY_PHONE_QUERY_SQL params:@[phone]];
}

#define USER_FIELD_UPDATE_SQL(__FIELD_NAME__) [NSString stringWithFormat:@"update %@ set %@=? where %@=?", USER_TABLE, __FIELD_NAME__, KEY_UUID]

- (void)updateUserName:(NSString *)uuid name:(NSString *)name
{
    [self executeUpdate:USER_FIELD_UPDATE_SQL(KEY_NAME) params:@[name, uuid]];
}

- (void)updateUserPwd:(NSString *)uuid pwd:(NSString *)pwd
{
    [self executeUpdate:USER_FIELD_UPDATE_SQL(KEY_PWD) params:@[pwd, uuid]];
}

- (void)updateUserPhoto:(NSString *)uuid photo:(NSString *)photo
{
    [self executeUpdate:USER_FIELD_UPDATE_SQL(KEY_PHOTO) params:@[photo, uuid]];
}

- (NSMutableArray *)friends:(NSString *)userId
{
    NSString *sql = @"select f.friend_id, u.name, u.pwd, u.type, u.phone, u.photo, u.register_time, f.uuid   from e_user u, e_friend f where u.uuid = f.friend_id and f.user_id = ? ";
    NSArray *params =@[userId];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSLog(@"sql : %@", sql);
    sqlite3 *database = nil;
    @try {
        database = [self openDatabase];
        sqlite3_stmt *stmt;
        
        @try {
            stmt = [self prepareStatement:sql params:params database:database];
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                ZKHUserFriendsEntity *userFriend = [[ZKHUserFriendsEntity alloc] init];
                userFriend.friend = [self processRow:stmt];
                userFriend.uuid = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, 7)];
                
                [result addObject:userFriend];
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

- (void)saveFriends:(NSString *)userId friends:(NSArray *)friends
{
    for (ZKHUserFriendsEntity *userFriend in friends) {
        ZKHUserEntity *friend = userFriend.friend;
        [self executeUpdate:USER_FRIEND_UPDATE_SQL params:@[userFriend.uuid, userId, friend.uuid]];
        
        [self saveNoPwd:@[friend]];
    }
}

@end