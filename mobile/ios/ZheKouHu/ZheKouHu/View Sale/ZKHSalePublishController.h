//
//  ZKHSalePublishController.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-4.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"
#import "ZKHTextField.h"
#import "ZKHTextView.h"
#import "UITableView+DataSourceBlocks.h"

@class TableViewWithBlock;

@interface ZKHSalePublishController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSMutableArray *selectedImages;
    BOOL isOpened;
    int selectedTradeIndex;
}

@property (strong, nonatomic) ZKHShopEntity *shop;

- (IBAction)publish:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *mainView;
@property (weak, nonatomic) IBOutlet ZKHTextField *titleField;
@property (weak, nonatomic) IBOutlet ZKHTextView *contentField;

@property (weak, nonatomic) IBOutlet UITextField *startDateField;
@property (weak, nonatomic) IBOutlet UITextField *endDateField;

@property (strong, nonatomic) IBOutlet UIButton *openButton;
@property (strong, nonatomic) IBOutlet UITextField *tradeTextField;
@property (strong, nonatomic) IBOutlet TableViewWithBlock *tradesTableView;

@property (weak, nonatomic) IBOutlet UICollectionView *picViewContainer;

@property (nonatomic,strong) UIToolbar * accessoryView;
@property (nonatomic,strong) UIDatePicker *customInput;

- (IBAction)changeOpenStatus:(id)sender;

- (IBAction)backgroupTap:(id)sender;

- (IBAction)OnDatePickerDone:(id)sender;
- (IBAction)dateChanged:(id)sender;

@end
