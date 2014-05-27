//
//  NSString+JSON.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

//json
- (NSDictionary *) toJSONObject;
+ (NSString *) stringWithJSONObject:(NSDictionary *) jsonObject;

//boolean
- (Boolean) isTrue;

//判断是否为nil，nsnull以及空串
- (Boolean) isNull;

@end
