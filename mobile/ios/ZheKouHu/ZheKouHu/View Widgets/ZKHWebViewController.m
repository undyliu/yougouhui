//
//  ZKHWebViewController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-12.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHWebViewController.h"
#import "ZKHConst.h"

@implementation ZKHWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = nil;
    if ([self.urlString hasPrefix:@"http://"] || [self.urlString hasPrefix:@"https://"]) {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    }else{
        NSString *url = [NSString stringWithFormat:@"http://%@%@", SERVER_BASE_URL, self.urlString];
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    }
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    hud.labelText = @"正在加载..";
    [hud show: YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [hud hide:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //TODO:显示错误信息
    [hud hide:YES];
}

@end
