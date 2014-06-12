//
//  ZKHViewUtils.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-29.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHViewUtils.h"
#import "CMPopTipView.h"

@implementation ZKHViewUtils

+ (void)setTableViewExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (void)showTipView:(UIView *)targetView message:(NSString *)message dismissTapAnywhere:(BOOL) dismissTapAnywhere autoDismissInvertal:(NSTimeInterval)autoDismissInvertal
{
    CMPopTipView *popTipView = [[CMPopTipView alloc] initWithMessage:message];
    popTipView.animation = arc4random() % 2;
    popTipView.has3DStyle = (BOOL)(arc4random() % 2);
    popTipView.dismissTapAnywhere = dismissTapAnywhere;
    if (autoDismissInvertal > 0) {
        [popTipView autoDismissAnimated:YES atTimeInterval:autoDismissInvertal];
    }
    
    [popTipView presentPointingAtView:targetView inView:targetView.superview animated:YES];
}
@end
