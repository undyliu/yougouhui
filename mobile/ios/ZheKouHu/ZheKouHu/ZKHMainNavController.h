//
//  ZKHMainNavController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKHMainNavController : UINavigationController<UIActionSheetDelegate>
{
    UIViewController * rootController;
    UIToolbar *navToolBar;
}

- (void) clickSearch: (id)sender;
- (void) clickMore: (id)sender;
- (void) clickProfile: (id)sender;

@end
