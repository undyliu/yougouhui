//
//  ZKHViewUtils.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-29.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKHViewUtils : NSObject

+(void)setTableViewExtraCellLineHidden: (UITableView *)tableView;

+(void)showTipView:(UIView *)targetView message:(NSString *)message dismissTapAnywhere:(BOOL) dismissTapAnywhere autoDismissInvertal:(NSTimeInterval)autoDismissInvertal;
@end
