//
//  ZKHRegisterShopController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-21.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHRegisterShopController.h"
#import "ZKHSwitchCell.h"
#import "ZKHAppDelegate.h"
#import "ZKHEntity.h"
static NSString *switchCellIdentifier = @"SwitchCell";

@interface ZKHRegisterShopController ()<ViewPagerDataSource, ViewPagerDelegate>

@end

@implementation ZKHRegisterShopController

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
    
    self.title = NSLocalizedString(@"LABEL_REGISTER_SHOP", @"register shop");
    
    pageTabs = @[NSLocalizedString(@"LABEL_SHOP_LICENSE", @"register shop license info"),
                 NSLocalizedString(@"LABEL_SHOP_INFO", @"register shop base info"),
                 @"主营业务",
                 NSLocalizedString(@"LABEL_SHOP_OWNER", @"register shop owner info")];
    
    NSBundle *bundle = [NSBundle mainBundle];
    [bundle loadNibNamed:@"ZKHRegisterShopLicense" owner:self options:nil];
    [bundle loadNibNamed:@"ZKHRegisterShopTrades" owner:self options:nil];
    [bundle loadNibNamed:@"ZKHRegisterShopInfo" owner:self options:nil];
    [bundle loadNibNamed:@"ZKHRegisterShopOwner" owner:self options:nil];
    
    self.dataSource = self;
    self.delegate = self;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(registerShop:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.tradesController.tableView.delegate = self;
    self.tradesController.tableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"ZKHSwitchCell" bundle:nil];
    [self.tradesController.tableView registerNib:nib forCellReuseIdentifier:switchCellIdentifier];
    
    [ApplicationDelegate.zkhProcessor trades:true completionHandler:^(NSMutableArray *trades) {
        _trades = trades;
        [self.tradesController.tableView reloadData];
    } errorHandler:^(NSError *error) {
        
    }];
    
    [self setExtraCellLineHidden:self.tradesController.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(loadContent) withObject:nil afterDelay:1.0];
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)loadContent {
}

- (void)registerShop:(id)sender
{
    
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return [pageTabs count];
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = pageTabs[index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return self.licenseController;
        case 1:
            return self.baseInfoController;
        case 2:
            return self.tradesController;
        default:
            return self.ownerController;
    }
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 1.0;
        case ViewPagerOptionTabHeight:
            return 49.0;
        case ViewPagerOptionTabOffset:
            return 36.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 1.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 1.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_trades count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:switchCellIdentifier];
    ZKHTradeEntity *trade = _trades[indexPath.row];
    cell.cellLabel.text = trade.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
