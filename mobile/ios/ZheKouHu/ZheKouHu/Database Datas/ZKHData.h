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
- (int)queryCount:(NSString *)sql params:(NSArray *)params;

@end

@interface ZKHModuleData : ZKHData <ZKHEntityUpdater>
- (NSMutableArray *) modules: (NSString *) type;
@end

@interface ZKHChannelData : ZKHData <ZKHEntityUpdater>
- (NSMutableArray *) channels;
@end

@interface ZKHUserData : ZKHData <ZKHEntityUpdater>
- (ZKHUserEntity *) user: (NSString *)phone;
- (void) updateUserName:(NSString *)uuid name:(NSString *)name;
- (void) updateUserPwd:(NSString *) uuid pwd:(NSString *)pwd;
- (void) updateUserPhoto:(NSString *) uuid photo:(NSString *)photo;
- (NSMutableArray *) friends:(NSString *)userId;
- (void) saveFriends:(NSString *)userId friends:(NSArray *) friends;
- (void) saveNoPwd:(NSArray *)users;
- (void) deleteFriend:(NSString *)userId friendId:(NSString *)friendId;

@end

@interface ZKHEnvData : ZKHData
- (void) saveLoginEnv:(NSString *)phone value:(NSMutableDictionary *) value;
- (NSMutableDictionary *) loginEnv:(NSString *)phone;
- (NSMutableDictionary *) lastLoginEnv;
- (void) deleteLoginEnv:(NSString *)phone;

@end

@interface ZKHSettingData : ZKHData <ZKHEntityUpdater>
- (NSMutableArray *) settings:(NSString *)userId;
- (ZKHSettingEntity *) setting:(NSString *)code userId:(NSString *)userId;
@end

@interface ZKHSyncData : ZKHData <ZKHEntityUpdater>
- (ZKHSyncEntity *) syncEntity:(NSString *)tableName itemId:(NSString *)itemId;

@end

#define SALE_TABLE @"e_sale"
@interface ZKHSaleData : ZKHData<ZKHEntityUpdater>
- (NSMutableArray *) salesForChannel:(NSString *)channelId;
- (ZKHSaleEntity *) sale:(NSString *)uuid;
@end

#define SALE_DISC_TABLE @"e_sale_discuss"
@interface ZKHSaleDiscussData : ZKHData<ZKHEntityUpdater>
- (NSMutableArray *) discussesForSale:(NSString *)saleId;
@end

@interface ZKHTradeData : ZKHData<ZKHEntityUpdater>
- (NSMutableArray *) trades;
@end

@interface ZKHShopData : ZKHData<ZKHEntityUpdater>
- (void)updateShopName:(NSString *)uuid name:(NSString *)name;
- (void)updateShopDesc:(NSString *)uuid desc:(NSString *)desc;
- (void)updateShopImage:(NSString *)uuid shopImage:(NSString *)shopImage;
- (void)updateBusiLicense:(NSString *)uuid busiLicense:(NSString *)busiLicense;
- (void)updateshopTrades:(NSString *)uuid trades:(NSArray *)trades;
- (NSMutableArray *) shopTrades:(NSString *)shopId;
- (ZKHShopEntity *) shop:(NSString *)uuid;
@end

@interface ZKHSaleFavoritData : ZKHData<ZKHEntityUpdater>
- (NSMutableArray *) saleFavorits:(NSString *)userId;
- (Boolean) isUserFavorie:(NSString *)userId saleId:(NSString *)saleId;
- (void) deleteFavorit:(NSString *)userId saleId:(NSString *)saleId;
@end

@interface ZKHShopFavoritData : ZKHData<ZKHEntityUpdater>
- (NSMutableArray *) shopFavorits:(NSString *)userId;
- (Boolean) isUserFavorie:(NSString *)userId shopId:(NSString *)shopId;
- (void) deleteFavorit:(NSString *)userId shopId:(NSString *)shopId;
@end

@interface ZKHShareData : ZKHData<ZKHEntityUpdater>

@end