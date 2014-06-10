//
//  ZKHTouchView.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-10.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHTouchesDelegate.h"

@interface ZKHTouchView : UIView
@property (strong,nonatomic) id<ZKHTouchesDelegate> delegate;
@end
