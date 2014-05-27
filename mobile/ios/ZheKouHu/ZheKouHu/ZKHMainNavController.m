//
//  ZKHMainNavController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-19.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHMainNavController.h"
#import "ZKHLoginController.h"
#import "ZKHRegiserUserController.h"
#import "ZKHContext.h"
#import "ZKHUserProfileController.h"
#import "ZKHAddFriendController.h"

@interface ZKHMainNavController ()

@end

@implementation ZKHMainNavController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if(self){
        rootController = rootViewController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, self.navigationBar.frame.size.height + 1)];
    [tools setTintColor:[self.navigationController.navigationBar tintColor]];
    [tools setAlpha:[self.navigationController.navigationBar alpha]];
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickSearch:)];
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickMore:)];
    UIBarButtonItem *profileButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(clickProfile:)];
    
    
    [buttons addObject:searchButton];
    [buttons addObject:moreButton];
    [buttons addObject:profileButton];
    
    [tools setItems:buttons animated:NO];
    
    UIBarButtonItem *myBtn = [[UIBarButtonItem alloc] initWithCustomView:tools];
    rootController.navigationItem.rightBarButtonItem = myBtn;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) clickSearch: (id)sender
{
   
}

- (void) clickMore: (id)sender
{
    UIActionSheet *actionSheet;
    if ([[ZKHContext getInstance] isAnonymousUserLogined]) {
        actionSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:self
                       cancelButtonTitle:@"取消"
                       destructiveButtonTitle:nil
                       otherButtonTitles:NSLocalizedString(@"LABEL_LOGIN", @"login"),
                       NSLocalizedString(@"LABEL_REGISTER_USER", @"register user"),
                       NSLocalizedString(@"LABEL_BUYING_SHARE", @"share buying"),
                       nil];
    }else{
        actionSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:self
                       cancelButtonTitle:@"取消"
                       destructiveButtonTitle:nil
                       otherButtonTitles:NSLocalizedString(@"LABEL_ADD_FRIENDS", @"add friends"),
                       NSLocalizedString(@"LABEL_BUYING_SHARE", @"share buying"),
                       nil];
    }
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

- (void) clickProfile: (id)sender
{
    ZKHUserProfileController *controller = [[ZKHUserProfileController alloc] init];
    [self pushViewController:controller animated:YES];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIViewController *controller;
    if ([[ZKHContext getInstance] isAnonymousUserLogined]) {
        switch (buttonIndex) {
            case 0://login
                controller = [[ZKHLoginController alloc] init];
                break;
            case 1://register user
                controller = [[ZKHRegiserUserController alloc] init];
                break;
            case 2://share
                break;
            default:
                break;
        }
    }else{
        switch (buttonIndex) {
            case 0://add friend
                controller = [[ZKHAddFriendController alloc] init];
                break;
            case 1://share
                break;
            default:
                break;
        }
    }
    
    if (controller != nil) {
        [self pushViewController:controller animated:YES];
    }
}
@end
