//
//  ZKHTouchesDelegate.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-10.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZKHTouchesDelegate <NSObject>

- (void)view:(UIView*)view touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;

@end
