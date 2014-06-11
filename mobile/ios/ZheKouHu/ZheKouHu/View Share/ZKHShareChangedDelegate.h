//
//  ZKHShareChangedDelegate.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-11.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKHEntity.h"

@protocol ZKHShareChangedDelegate <NSObject>

- (void) shareDeleted:(ZKHShareEntity *)share;

@end
