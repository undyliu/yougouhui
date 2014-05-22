//
//  ZKHShopMainController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-22.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+DataSourceBlocks.h"
#import "ZKHEntity.h"

@class TableViewWithBlock;

@interface ZKHShopMainController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate>
{
    BOOL isOpened;
}
@property (strong, nonatomic) NSMutableArray *shops;
@property (strong, nonatomic) ZKHUserEntity *user;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *modulesView;
@property (strong, nonatomic) IBOutlet UIButton *openButton;
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) IBOutlet TableViewWithBlock *tb;
- (IBAction)changeOpenStatus:(id)sender;

- (IBAction)clickMore:(id)sender;

@end
