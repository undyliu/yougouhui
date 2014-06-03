//
//  ZKHShareController.h
//  ZheKouHu
//
//  Created by undyliu on 14-5-30.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKHEntity.h"
#import "ZKHTextView.h"
#import "ZKHChooseShopActionDelegate.h"

@interface ZKHShareController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZKHChooseShopActionDelegate>
{
    NSMutableArray *selectedImages;
}

@property (strong, nonatomic) ZKHShopEntity *shop;
@property (weak, nonatomic) IBOutlet ZKHTextView *contentField;
@property (weak, nonatomic) IBOutlet UITextField *shopField;
@property (weak, nonatomic) IBOutlet UIButton *scanShopButton;

@property (weak, nonatomic) IBOutlet UISwitch *friendSeeSwitch;
@property (weak, nonatomic) IBOutlet UICollectionView *picViewContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)chooseShop:(UIButton *)sender;

- (IBAction)addPicViewClick:(id)sender;
- (IBAction)previewPic:(id)sender;
- (IBAction)backgroupTap:(id)sender;
- (IBAction)saveShare:(id)sender;

@end
