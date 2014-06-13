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
#import "QRadioButton.h"

@interface ZKHSalePublishController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, QRadioButtonDelegate>
{
    NSMutableArray *selectedImages;
    ZKHShopTradeEntity *selectedShopTrade;
}

@property (strong, nonatomic) ZKHShopEntity *shop;

- (IBAction)publish:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *mainView;
@property (weak, nonatomic) IBOutlet ZKHTextField *titleField;
@property (weak, nonatomic) IBOutlet ZKHTextView *contentField;

@property (weak, nonatomic) IBOutlet UITextField *startDateField;
@property (weak, nonatomic) IBOutlet UITextField *endDateField;
@property (weak, nonatomic) IBOutlet UIView *tradesView;

@property (retain, nonatomic) IBOutlet UICollectionView *picViewContainer;

@property (nonatomic,strong) UIToolbar * accessoryView;
@property (nonatomic,strong) UIDatePicker *customInput;

- (IBAction)backgroupTap:(id)sender;
- (IBAction)addPicViewClick:(id)sender;
- (IBAction)previewPic:(id)sender;

- (IBAction)OnDatePickerCancel:(id)sender;
- (IBAction)OnDatePickerDone:(id)sender;
- (IBAction)dateChanged:(id)sender;

@end
