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

@interface ZKHMainNavController ()

@end

@implementation ZKHMainNavController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if(self){
        rootController = rootViewController;
        
        UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 90, 45)];
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
        rootViewController.navigationItem.rightBarButtonItem = myBtn;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    CGFloat yHeight = 242.0f;
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
    
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];
    
    int row = indexPath.row;
    
    if(row == 0){
        cell.textLabel.text = NSLocalizedString(@"LABEL_LOGIN", @"login");
        //cell.imageView.image = [UIImage imageNamed:@"ic_facebook.png"];
    }else if (row == 1){
        cell.textLabel.text = NSLocalizedString(@"LABEL_REGISTER_USER", @"register user");
    }else if (row == 2){
        cell.textLabel.text = NSLocalizedString(@"LABEL_BUYING_SHARE", @"share buying");
    }
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %d", __func__, indexPath.row);
    
    UIViewController *viewController = nil;
    if (indexPath.row == 0) {
        viewController = [[ZKHLoginController alloc] init];
    }else if(indexPath.row == 1){
        viewController = [[ZKHRegiserUserController alloc] init];
    }
    if (viewController != nil) {
        [self pushViewController:viewController animated:YES];
    }
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
@end
