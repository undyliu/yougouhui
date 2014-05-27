
#import "ZKHData.h"
#import "ZKHConst.h"
#import "NSString+Utils.h"
#import "NSDate+Utils.h"

#define KEY_LOGIN_SETTING @"login_setting"
#define ENV_TABLE @"e_env"
#define ENV_CREATE_SQL [NSString stringWithFormat:@" create table if not exists %@ (%@ text primary key, %@ text, %@ text) ", ENV_TABLE, KEY_PHONE, KEY_LOGIN_SETTING, KEY_LAST_MODIFY_TIME]
#define ENV_UPDATE_SQL [NSString stringWithFormat:@" insert or replace into %@ (%@, %@, %@) values (?, ?, ?)", ENV_TABLE, KEY_PHONE, KEY_LOGIN_SETTING, KEY_LAST_MODIFY_TIME]
#define ENV_QUERY_SQL [NSString stringWithFormat:@" select %@ from %@ where %@ = ? order by %@ desc", KEY_LOGIN_SETTING, ENV_TABLE, KEY_PHONE, KEY_LAST_MODIFY_TIME]
#define ENV_LAST_TIME_QUERY_SQL [NSString stringWithFormat:@" select %@ from %@ order by %@ desc", KEY_LOGIN_SETTING, ENV_TABLE, KEY_LAST_MODIFY_TIME]
#define ENV_DEL_QUERY_SQL [NSString stringWithFormat:@" delete from %@ where %@= ? ", ENV_TABLE, KEY_PHONE]

@implementation ZKHEnvData

- (id)init
{
    if (self = [super init]) {
        [self createTable:ENV_CREATE_SQL];
    }
    return self;
}

- (void)saveLoginEnv:(NSString *)phone value:(NSMutableDictionary *)value
{
    NSString *setting = [NSString stringWithJSONObject:value];
    NSString *currentTime = [NSDate currentTimeString];
    [self executeUpdate:ENV_UPDATE_SQL params:@[phone, setting, currentTime]];
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    int i = 0;
    return [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(stmt, i++)];
}

- (NSMutableDictionary *)loginEnv:(NSString *)phone
{
    NSString *loginSetting = [self queryOne:ENV_QUERY_SQL params:@[phone]];
    NSDictionary * tmp = [loginSetting toJSONObject];
    
    return [[NSMutableDictionary alloc] initWithDictionary:tmp];
}

- (NSMutableDictionary *)lastLoginEnv
{
    NSString *loginSetting = [self queryOne:ENV_LAST_TIME_QUERY_SQL params:nil];
    return [[NSMutableDictionary alloc] initWithDictionary:[loginSetting toJSONObject]];
}

- (void)deleteLoginEnv:(NSString *)phone
{
    [self executeUpdate:ENV_DEL_QUERY_SQL params:@[phone]];
}

@end