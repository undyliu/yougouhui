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
    
    [self reloadData];
}

- (void)reloadData
{
    if ([[ZKHContext getInstance] isAnonymousUserLogined]) {
        moreItems = @[NSLocalizedString(@"LABEL_LOGIN", @"login"),
                      NSLocalizedString(@"LABEL_REGISTER_USER", @"register user"),
                      NSLocalizedString(@"LABEL_BUYING_SHARE", @"share buying")];
    }else{
        moreItems = @[NSLocalizedString(@"LABEL_ADD_FRIENDS", @"add friends"),
                      NSLocalizedString(@"LABEL_BUYING_SHARE", @"share buying")];
    }
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
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = [moreItems count] * 80;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = FALSE;
    //[poplistview setTitle:@"Share to"];
    [poplistview show];
}

- (void) clickProfile: (id)sender
{
    ZKHUserProfileController *controller = [[ZKHUserProfileController alloc] init];
    [self pushViewController:controller animated:YES];
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];
    cell.textLabel.text = moreItems[indexPath.row];
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return [moreItems count];
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %d", __func__, indexPath.row);
    
    if ([[ZKHContext getInstance] isAnonymousUserLogined]) {
        UIViewController *viewController = nil;
        if (indexPath.row == 0) {
            viewController = [[ZKHLoginController alloc] init];
        }else if(indexPath.row == 1){
            viewController = [[ZKHRegiserUserController alloc] init];
        }else if (indexPath.row == 2){
            
        }
        
        if (viewController != nil) {
            [self pushViewController:viewController animated:YES];
        }
    }
   
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
@end
