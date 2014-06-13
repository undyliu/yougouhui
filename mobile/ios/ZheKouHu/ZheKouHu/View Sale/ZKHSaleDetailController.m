//
//  ZKHSaleDetailController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-29.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHSaleDetailController.h"
#import "ZKHImageLoader.h"
#import "ZKHShopInfoController.h"
#import "ZKHAppDelegate.h"
#import "ZKHProcessor+Shop.h"
#import "ZKHProcessor+Sale.h"
#import "ZKHProcessor+Sync.h"
#import "ZKHProcessor+Favorit.h"
#import "NSDate+Utils.h"
#import "ZKHImagePreviewController.h"
#import "ZKHData.h"
#import "ZKHViewUtils.h"
#import "ZKHContext.h"
#import "ZKHShareController.h"
#import "ZKHImageListPreviewController.h"


@implementation ZKHSaleDetailController

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
    
    discussListController = [[ZKHSaleDiscussListController alloc] init];
    discussListController.saleDelegate = self;
    
    self.disTableView.delegate = discussListController;
    self.disTableView.dataSource = discussListController;
    self.disTableView.pullDelegate = discussListController;
    
    discussListController.tableView = self.disTableView;
    [discussListController registerTableViewCell];
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.disTableView];
    
    self.title = @"活动详情";
    
    [self initializeNavToolBar];
    
    //初始化值
    self.titleLabel.text = self.sale.title;
    
    self.statusLabel.hidden = true;//TODO
    
    self.shopLabel.text = self.sale.shop.name;
    
    NSDate *startDate = [NSDate dateWithMilliSeconds:[self.sale.startDate longLongValue]];
    NSDate *endDate = [NSDate dateWithMilliSeconds:[self.sale.endDate longLongValue]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 至 %@", [startDate toyyyyMMddString], [endDate toyyyyMMddString]];
    
    [self updateContentLabel];
    [self updateHitLabel];
    
    //设置图片相关
    [ZKHImageLoader showImageForName:self.sale.img imageView:self.saleImageView];
    self.saleImageView.userInteractionEnabled = true;
    [self.saleImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imagePreview:)]];
    
    self.moreImageLabel.userInteractionEnabled = true;
    [self.moreImageLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreImageClick:)]];
    
    //设置商铺点击
    self.shopLabel.userInteractionEnabled = TRUE;
    [self.shopLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shopLabelClick:)]];
    
    //设置评论相关
    self.disTableView.hidden = true;
    self.discusslabel.userInteractionEnabled = true;
    [self.discusslabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discussLabelClick:)]];
    self.disImageView.userInteractionEnabled = true;
    [self.disImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discussLabelClick:)]];
    
    shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(shareClick:)];
    favoritItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(favoritClick:)];
    cancelFavoritItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(cancelFavoritClick:)];
    
    if ([[ZKHContext getInstance] isAnonymousUserLogined]) {
        ////[self updateNavigationItem:@[shareItem]];
        
        self.disButton.hidden = true;
    }else{
        [ApplicationDelegate.zkhProcessor isSaleFavorit:[ZKHContext getInstance].user.uuid saleId:self.sale.uuid completionHandler:^(Boolean result) {
            if (result) {
                [self updateNavigationItem:@[shareItem, cancelFavoritItem]];
            }else{
                [self updateNavigationItem:@[shareItem, favoritItem]];
            }
        } ];
    }
    
    //设置输入键盘
    faceToolBar = [[FaceToolBar alloc]initWithFrame:CGRectMake(0.0f,self.view.frame.size.height - toolBarHeight,self.view.frame.size.width,toolBarHeight) superView:self.view];
    faceToolBar.fToolBarDelegate = self;
    //[self.view addSubview:faceToolBar];
    
    //主视图的点击事件
    [self.mainView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroupTap:)]];
}

- (CGFloat) contentLabelWidth
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown){//竖屏
        return screenBounds.size.width - self.saleImageView.frame.size.width - 10;
    }else{
        return screenBounds.size.height - self.saleImageView.frame.size.width -10;
    }
}

- (void) updateContentLabel
{
    if (!self.contentLabel) {
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        
        [self.view addSubview:self.contentLabel];
    }
    
    CGFloat x = self.titleLabel.frame.origin.x;
    CGFloat y = self.shopLabel.frame.origin.y + 16;
    CGFloat height = self.saleImageView.frame.size.height + self.saleImageView.frame.origin.y - y;
    CGFloat width = [self contentLabelWidth];
    
    self.contentLabel.frame = CGRectMake(x, y, width, height);
    
    self.contentLabel.text = self.sale.content;
}

-(void) updateHitLabel
{
    NSString *hitCount = [NSString stringWithFormat:@"共%@次浏览 %@条评论", self.sale.visitCount, self.sale.discussCount];
    self.discusslabel.text = hitCount;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateNavToolBarFrame];
    
    faceToolBar.hidden = true;
    [faceToolBar resignFirstResponder];
}

- (void) initializeNavToolBar
{
    navToolbar = [[UIToolbar alloc] init];
    [navToolbar setTintColor:[self.navigationController.navigationBar tintColor]];
    [navToolbar setAlpha:[self.navigationController.navigationBar alpha]];
}

- (void) updateNavToolBarFrame
{
    CGFloat width = 40;
    if ([navToolbar.items count] > 1) {
        width = 80;
    }
    
    CGFloat height = self.navigationController.navigationBar.frame.size.height + 1;
    navToolbar.frame = CGRectMake(0, 0, width, height);
}

- (void) updateNavigationItem:(NSArray *)items
{
    [navToolbar setItems:items animated:NO];
    
    UIBarButtonItem *myBtn = [[UIBarButtonItem alloc] initWithCustomView:navToolbar];
    self.navigationItem.rightBarButtonItem = myBtn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) moreImageClick:(id)sender
{
    ZKHImageListPreviewController *controller = [[ZKHImageListPreviewController alloc] init];
    controller.title = @"活动图片";
    if ([self.sale.images count] > 0) {
        controller.imageFiles = self.sale.images;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [ApplicationDelegate.zkhProcessor saleImages:self.sale completionHandler:^(NSMutableArray *saleImages) {
            controller.imageFiles = self.sale.images;
            [self.navigationController pushViewController:controller animated:YES];
        } ];
    }
    
}

- (IBAction)discuss:(id)sender {
    faceToolBar.hidden = !faceToolBar.hidden;
    if (!faceToolBar.hidden) {
        [faceToolBar becomeFirstResponder];
    }
}

- (void)shopLabelClick:(id)sender
{
    [ApplicationDelegate.zkhProcessor shop:self.sale.shop.uuid completionHandler:^(ZKHShopEntity *shop) {
        ZKHShopInfoController *controller = [[ZKHShopInfoController alloc] init];
        controller.shop = shop;
        [self.navigationController pushViewController:controller animated:YES];
    } ];
}

- (void)discussLabelClick:(id)sender
{
    if (self.disTableView.hidden) {
        self.disTableView.hidden = false;
        self.disImageView.image = [UIImage imageNamed:@"arrow_up.png"];
        
        if ([discussListController.discusses count] > 0) {
            return;
        }
        
        ZKHSyncEntity *sync = [ApplicationDelegate.zkhProcessor getSyncEntity: SALE_DISC_TABLE itemId:self.sale.uuid];
        if (sync == nil) {
            sync = [[ZKHSyncEntity alloc] init];
            NSString *currentTime = [NSDate currentTimeString];
            sync.updateTime = self.sale.publishTime;
            sync.uuid = [currentTime copy];
            sync.tableName = SALE_TABLE;
            sync.itemId = self.sale.uuid;
        }
        
        [ApplicationDelegate.zkhProcessor discussesForSale:self.sale updateTime:sync completionHandler:^(NSMutableArray *discusses) {
            discussListController.discusses = discusses;
            [self.disTableView reloadData];
        } ];
    }else{
        self.disTableView.hidden = true;
        self.disImageView.image = [UIImage imageNamed:@"arrow_down.png"];
    }
}

- (void)imagePreview:(id)sender
{
    NSLog(@"%@", [sender class]);
    ZKHImagePreviewController *controller = [[ZKHImagePreviewController alloc] init];
    controller.image = self.saleImageView.image;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)favoritClick:(id)sender
{
    [ApplicationDelegate.zkhProcessor setSaleFavorit:[ZKHContext getInstance].user.uuid sale:self.sale completionHandler:^(Boolean result) {
        if (result) {
            [self updateNavigationItem:@[shareItem, cancelFavoritItem]];
        }
    } ];
}

- (void)cancelFavoritClick:(id)sender
{
    [ApplicationDelegate.zkhProcessor delSaleFavorit:[ZKHContext getInstance].user.uuid saleId:self.sale.uuid completionHandler:^(Boolean result) {
        if (result) {
            [self updateNavigationItem:@[shareItem, favoritItem]];
        }
    } ];
}

- (void)shareClick:(id)sender
{
    ZKHShareController *controller = [[ZKHShareController alloc] init];
    controller.shop = self.sale.shop;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateNavToolBarFrame];
    [self updateContentLabel];
}

- (void)backgroupTap:(id)sender
{
    [faceToolBar resignFirstResponder];
    faceToolBar.hidden = true;
}

#pragma mark - FaceToolBarDelegate
-(void)sendTextAction:(NSString *)inputText{
    [faceToolBar resignFirstResponder];
    faceToolBar.hidden = true;
    
    ZKHSaleDiscussEntity *discuss = [[ZKHSaleDiscussEntity alloc] init];
    discuss.content = inputText;
    discuss.sale = self.sale;
    discuss.publisher = [ZKHContext getInstance].user;
    
    [ApplicationDelegate.zkhProcessor addDiscuss:discuss completionHandler:^(ZKHSaleDiscussEntity *discuss) {
        if (discuss) {
            [self updateHitLabel];
            
            [discussListController.discusses addObject:discuss];
            [discussListController.tableView reloadData];
        }
    } ];
}

#pragma mark - ZKHSaleValueChangedDelegat

- (void)updateSale:(ZKHSaleEntity *)sale
{
    self.sale = sale;
    [self updateHitLabel];
}

@end
