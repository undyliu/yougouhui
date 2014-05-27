//
//  ZKHData.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-20.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHData.h"
#import "ZKHConst.h"
#import "ZKHEntity.h"

@implementation ZKHData

- (NSString *) dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [paths objectAtIndex:0];
    return [documentDir stringByAppendingPathComponent:@"zhekouhu.sqlite"];
}

- (sqlite3 *)openDatabase
{
    sqlite3 *database = nil;
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    return database;
}

- (void)closeDatabase:(sqlite3 *)database
{
    if (database != nil) {
        sqlite3_close(database);
    }
}

- (void)createTable:(NSString *)sql
{
    NSLog(@"sql:%@", sql);
    sqlite3 *database = nil;
    @try {
        database = [self openDatabase];
        char *errorMsg;
        if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            NSAssert(0, @"Error create table: %s", errorMsg);
        }
    }
    @catch (NSException *exception) {
        @throw exception;
    }
    @finally {
        [self closeDatabase:database];
    }
}

- (sqlite3_stmt *)prepareStatement:(NSString *)sql params:(NSArray *)params database:(sqlite3 *)db
{
    sqlite3_stmt * stmt = nil;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK){
        if (params != nil && [params count] > 0) {
            int i = 1;
            for (NSObject *value in params) {
                if (value == nil || [value isKindOfClass:[NSNull class]]) {
                    //sqlite3_bind_null(stmt, i++);
                    sqlite3_bind_text(stmt, i++, [@"" UTF8String], -1, NULL);
                }else if ([value isKindOfClass:[NSNumber class]]) {
                    sqlite3_bind_int(stmt, i++, [(NSNumber *)value intValue]);
                }else{
                    sqlite3_bind_text(stmt, i++, [(NSString *)value UTF8String], -1, NULL);
                }
            }
        }
    }
    return stmt;
}

- (void)executeUpdate:(NSString *)sql params:(NSArray *)params
{
    NSLog(@"sql :%@", sql);
    
    sqlite3 *database = nil;
    @try {
        database = [self openDatabase];
        char *errorMsg = NULL;
        sqlite3_stmt *stmt;
        
        @try {
            stmt = [self prepareStatement:sql params:params database:database];
            if (sqlite3_step(stmt) != SQLITE_DONE) {
                NSAssert(0, @"Error updating table : @s", errorMsg);
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
}

- (NSMutableArray *)query:(NSString *)sql params:(NSArray *)params
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSLog(@"sql : %@", sql);
    sqlite3 *database = nil;
    @try {
        database = [self openDatabase];
        sqlite3_stmt *stmt;
        
        @try {
            stmt = [self prepareStatement:sql params:params database:database];
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                ZKHEntity *entity = [self processRow:stmt];
                if (entity != nil) {
                    [result addObject:[self processRow:stmt]];
                }
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

- (id)queryOne:(NSString *)sql params:(NSArray *)params
{
    NSLog(@"sql : %@", sql);
    sqlite3 *database = nil;
    @try {
        database = [self openDatabase];
        sqlite3_stmt *stmt;
        
        @try {
            stmt = [self prepareStatement:sql params:params database:database];
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                return [self processRow:stmt];
                
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
    return nil;
}

- (id)processRow:(sqlite3_stmt *)stmt
{
    //子类处理
    return nil;
}
@end

