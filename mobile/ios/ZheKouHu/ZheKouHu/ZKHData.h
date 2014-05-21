//
//  ZKHData.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-20.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ZKHEntity.h"

@protocol ZKHEntityUpdater <NSObject>

@optional
- (void) save:(NSArray *) data;

@end

@interface ZKHData : NSObject

- (sqlite3 *)openDatabase;
- (void) closeDatabase: (sqlite3 *) database;
- (sqlite3_stmt *) prepareStatement:(NSString *) sql params:(NSArray *) params database:(sqlite3 *) db;

- (void) createTable:(NSString *) sql;
- (void) executeUpdate: (NSString *) sql params:(NSArray *) params;
- (NSMutableArray *) query: (NSString *) sql params:(NSArray *) params;
- (id) queryOne: (NSString *) sql params:(NSArray *) params;
- (id) processRow:(sqlite3_stmt *)stmt;

@end

@interface ZKHModuleData : ZKHData <ZKHEntityUpdater>
- (NSMutableArray *) getModules: (NSString *) type;
@end

@interface ZKHChannelData : ZKHData <ZKHEntityUpdater>
- (NSMutableArray *) getChannels;
@end

@interface ZKHUserData : ZKHData <ZKHEntityUpdater>
- (ZKHUserEntity *) getUser: (NSString *)phone;

@end

@interface ZKHEnvData : ZKHData
- (void) saveLoginEnv:(NSString *)phone value:(NSMutableDictionary *) value;
- (NSMutableDictionary *) getLoginEnv:(NSString *)phone;
- (NSMutableDictionary *) getLastLoginEnv;

@end