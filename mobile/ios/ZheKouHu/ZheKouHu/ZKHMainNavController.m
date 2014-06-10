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
#import "ZKHShareController.h"
#import "TSActionSheet.h"

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
    [self initializeNavigationItem];
}

- (void)updateNavToolBarFrame
{
    navToolBar.frame = CGRectMake(0, 0, 90, self.navigationBar.frame.size.height + 1);
}

- (void)initializeNavigationItem
{
    navToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, self.navigationBar.frame.size.height + 1)];
    
    [navToolBar setTintColor:[self.navigationController.navigationBar tintColor]];
    [navToolBar setAlpha:[self.navigationController.navigationBar alpha]];
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clickSearch:)];
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickMore:forEvent:)];
    UIBarButtonItem *profileButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(clickProfile:)];
    
    
    [buttons addObject:searchButton];
    [buttons addObject:moreButton];
    [buttons addObject:profileButton];
    
    [navToolBar setItems:buttons animated:NO];
    
    UIBarButtonItem *myBtn = [[UIBarButtonItem alloc] initWithCustomView:navToolBar];
    rootController.navigationItem.rightBarButtonItem = myBtn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) clickSearch: (id)sender
{
   
}

- (void) clickMore: (id)sender forEvent:(UIEvent*)event
{
    TSActionSheet *actionSheet = [[TSActionSheet alloc] initWithTitle:nil];
    if ([[ZKHContext getInstance] isAnonymousUserLogined]) {
        [actionSheet addButtonWithTitle:NSLocalizedString(@"LABEL_LOGIN", @"login") block:^{
            UIViewController *controller = [[ZKHLoginController alloc] init];
            [self pushViewController:controller animated:YES];
        }];
        [actionSheet addButtonWithTitle:NSLocalizedString(@"LABEL_REGISTER_USER", @"register user") block:^{
            UIViewController *controller = [[ZKHRegiserUserController alloc] init];
            [self pushViewController:controller animated:YES];
        }];
    }else{
        [actionSheet addButtonWithTitle:NSLocalizedString(@"LABEL_ADD_FRIENDS", @"add friends") block:^{
            UIViewController *controller = [[ZKHAddFriendController alloc] init];
            [self pushViewController:controller animated:YES];
        }];
        [actionSheet addButtonWithTitle:NSLocalizedString(@"LABEL_BUYING_SHARE", @"share buying") block:^{
            UIViewController *controller = [[ZKHShareController alloc] init];
            [self pushViewController:controller animated:YES];
        }];
    }
    //[actionSheet cancelButtonWithTitle:@"取消" block:nil];
    actionSheet.cornerRadius = 5;
    
    [actionSheet showWithTouch:event];
}

- (void) clickProfile: (id)sender
{
    ZKHUserProfileController *controller = [[ZKHUserProfileController alloc] init];
    [self pushViewController:controller animated:YES];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateNavToolBarFrame];
}
@end
