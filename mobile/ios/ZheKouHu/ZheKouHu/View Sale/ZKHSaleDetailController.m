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
#import "NSDate+Utils.h"
#import "ZKHImagePreviewController.h"
#import "ZKHData.h"
#import "ZKHViewUtils.h"

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
    
    self.disTableView.delegate = discussListController;
    self.disTableView.dataSource = discussListController;
    self.disTableView.pullDelegate = discussListController;
    
    discussListController.tableView = self.disTableView;
    [discussListController registerTableViewCell];
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.disTableView];
    
    self.title = @"活动详情";
    
    self.titleLabel.text = self.sale.title;
    self.contentLabel.text = self.sale.content;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.numberOfLines = 0;
    
    self.statusLabel.hidden = true;//TODO
    
    self.shopLabel.text = self.sale.shop.name;
    
    NSDate *startDate = [NSDate dateWithMilliSeconds:[self.sale.startDate longLongValue]];
    NSDate *endDate = [NSDate dateWithMilliSeconds:[self.sale.endDate longLongValue]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 至 %@", [startDate toyyyyMMddString], [endDate toyyyyMMddString]];
    
    NSString *hitCount = [NSString stringWithFormat:@"共%@次浏览 %@条评论", self.sale.visitCount, self.sale.discussCount];
    self.discusslabel.text = hitCount;
    
    [ZKHImageLoader showImageForName:self.sale.img imageView:self.saleImageView];
    self.saleImageView.userInteractionEnabled = true;
    [self.saleImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imagePreview:)]];
    
    self.shopLabel.userInteractionEnabled = TRUE;
    [self.shopLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shopLabelClick:)]];
    
    self.disTableView.hidden = true;
    self.discusslabel.userInteractionEnabled = true;
    [self.discusslabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discussLabelClick:)]];
    self.disImageView.userInteractionEnabled = true;
    [self.disImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discussLabelClick:)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shopLabelClick:(id)sender
{
    [ApplicationDelegate.zkhProcessor shop:self.sale.shop.uuid completionHandler:^(ZKHShopEntity *shop) {
        ZKHShopInfoController *controller = [[ZKHShopInfoController alloc] init];
        controller.shop = shop;
        [self.navigationController pushViewController:controller animated:YES];
    } errorHandler:^(NSError *error) {
        
    }];
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
        
        [ApplicationDelegate.zkhProcessor discussesForSale:self.sale.uuid updateTime:sync completionHandler:^(NSMutableArray *discusses) {
            discussListController.discusses = discusses;
            [self.disTableView reloadData];
        } errorHandler:^(NSError *error) {
            
        }];
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

@end
