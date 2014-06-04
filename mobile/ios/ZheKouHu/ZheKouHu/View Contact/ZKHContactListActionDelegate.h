//
//  ZKHContactListActionDelegate.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-3.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZKHContactListActionDelegate <NSObject>
- (void) confirm:(NSMutableArray *) users viewController:(UIViewController *)viewController;
@end
