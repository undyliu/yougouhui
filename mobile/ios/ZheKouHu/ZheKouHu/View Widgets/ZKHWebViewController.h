//
//  ZKHWebViewController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-12.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ZKHWebViewController : UIViewController<UIWebViewDelegate>
{
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *urlString;

@end
