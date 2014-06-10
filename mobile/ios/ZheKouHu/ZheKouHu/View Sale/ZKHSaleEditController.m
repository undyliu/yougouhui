//
//  ZKHSaleEditController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-6.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHSaleEditController.h"
#import "NSDate+Utils.h"
#import "ZKHProcessor+Trade.h"
#import "ZKHProcessor+Sync.h"
#import "ZKHProcessor+Sale.h"
#import "ZKHAppDelegate.h"
#import "QRadioButton.h"
#import "ZKHConst.h"
#import "ZKHViewUtils.h"
#import "ZKHData.h"
#import "ZKHImageListPreviewController.h"

@implementation ZKHSaleEditController

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
    
    self.title = @"活动详情";
    
    [self initializeViews];
    
    cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"作废" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClick:)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    
    NSString *status = self.sale.status;
    if ([@"2" isEqualToString:status]) {
        cancelButton.title = @"已作废";
        cancelButton.enabled = false;
    }
}

- (void) initializeViews
{
    self.titleField.text = [NSString stringWithFormat:@" 标题:  %@", self.sale.title];
    self.contentField.text = [NSString stringWithFormat:@"内容:  %@", self.sale.content];
    self.startDateField.text = [[NSDate dateWithMilliSeconds:[self.sale.startDate longLongValue]] toyyyyMMddString];
    self.endDateField.text = [[NSDate dateWithMilliSeconds:[self.sale.endDate longLongValue]] toyyyyMMddString];
    self.countLabel.text = [NSString stringWithFormat:@"共%@次浏览 %@条评论", self.sale.visitCount, self.sale.discussCount];
    
    self.disTableView.hidden = true;
    self.countLabel.userInteractionEnabled = true;
    [self.countLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discussLabelClick:)]];
    self.disImageView.userInteractionEnabled = true;
    [self.disImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discussLabelClick:)]];
    
    [self initializeTextFieldsStyle:self.titleField];
    [self initializeTextFieldsStyle:self.startDateField];
    [self initializeTextFieldsStyle:self.endDateField];
    
    [self initializeTradeView];
    [self initializeDiscussView];
}

- (void) initializeTextFieldsStyle:(UITextField *)field
{
    field.layer.cornerRadius = 5.0f;
    field.layer.masksToBounds = YES;
    field.layer.borderColor = [[UIColor grayColor] CGColor];
    field.layer.borderWidth = 1.0f;
}

- (void) initializeTradeView
{
    [ApplicationDelegate.zkhProcessor trade:self.sale.tradeId completionHandler:^(ZKHTradeEntity *trade) {
        CGRect tradesViewFrame = self.tradeView.frame;
        
        CGFloat radioWith = 70;
        CGFloat radioHeight = 30;
        
        QRadioButton *_radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
        _radio1.frame = CGRectMake(tradesViewFrame.origin.x, tradesViewFrame.origin.y, radioWith, radioHeight);
        [_radio1 setTitle:trade.name forState:UIControlStateNormal];
        [_radio1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [_radio1 setChecked:true];
        
        [self.view addSubview:_radio1];

    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)initializeDiscussView
{
    discussListController = [[ZKHSaleDiscussListController alloc] init];
    
    self.disTableView.delegate = discussListController;
    self.disTableView.dataSource = discussListController;
    self.disTableView.pullDelegate = discussListController;
    
    discussListController.tableView = self.disTableView;
    [discussListController registerTableViewCell];
    
    [ZKHViewUtils setTableViewExtraCellLineHidden:self.disTableView];
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
        } errorHandler:^(NSError *error) {
            
        }];
    }else{
        self.disTableView.hidden = true;
        self.disImageView.image = [UIImage imageNamed:@"arrow_down.png"];
    }
}


- (IBAction)showSaleImages:(id)sender {
    ZKHImageListPreviewController *controller = [[ZKHImageListPreviewController alloc] init];
    if ([self.sale.images count] > 0) {
        controller.imageFiles = self.sale.images;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [ApplicationDelegate.zkhProcessor saleImages:self.sale completionHandler:^(NSMutableArray *saleImages) {
            controller.imageFiles = self.sale.images;
            [self.navigationController pushViewController:controller animated:YES];
        } errorHandler:^(NSError *error) {
            
        }];
    }
}

- (void)cancelClick:(id)sender
{
    [ApplicationDelegate.zkhProcessor cancelSale:self.sale completionHandler:^(Boolean result) {
        if (result) {
            cancelButton.title = @"已作废";
            cancelButton.enabled = false;
        }
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
