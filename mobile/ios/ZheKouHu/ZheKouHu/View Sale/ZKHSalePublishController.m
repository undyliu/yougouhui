//
//  ZKHSalePublishController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-4.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ZKHSalePublishController.h"
#import "ZKHPictureCell.h"
#import "ZKHImagePreviewController.h"
#import "SelectionCell.h"
#import "TableViewWithBlock.h"
#import "NSString+Utils.h"
#import "ZKHProcessor+Sale.h"
#import "ZKHAppDelegate.h"
#import "ZKHContext.h"
#import "ZKHImageLoader.h"
#import "NSDate+Utils.h"

static NSString *CellIdentifier = @"DefaultPictureCell";

@implementation ZKHSalePublishController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        selectedImages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"发布新活动";
    
    UINib *nib = [UINib nibWithNibName:@"ZKHPictureCell" bundle:nil];
    [self.picViewContainer registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
    self.picViewContainer.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(publish:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    [self initializeViews];
    
    self.contentField.placeholder = @"活动内容";
    
    self.startDateField.inputAccessoryView = self.accessoryView;
    self.startDateField.inputView = self.customInput;
    
    self.endDateField.inputAccessoryView = self.accessoryView;
    self.endDateField.inputView = self.customInput;
    
    
    [self.mainView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroupTap:)]];
    
}

- (void) initializeViews
{
    [self initializeTradesView];
    [self initializeDatePicker];
    
}

- (void)initializeTradesView
{
    int index = 0;
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    CGRect tradesViewFrame = self.tradesView.frame;
    
    CGFloat radioWith = 70;
    CGFloat radioHeight = 30;
    int rowCount = tradesViewFrame.size.width / 70;
    
    for (ZKHShopTradeEntity *shopTrade in self.shop.trades) {
        QRadioButton *_radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:@"groupId1"];
        _radio1.frame = CGRectMake(tradesViewFrame.origin.x + offsetX, tradesViewFrame.origin.y + offsetY, radioWith, radioHeight);
        [_radio1 setTitle:shopTrade.trade.name forState:UIControlStateNormal];
        [_radio1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        _radio1.userObject = shopTrade;
        
        [self.mainView addSubview:_radio1];
        
        index++;
        offsetX = (index % rowCount) * radioWith;
        offsetY = (index / rowCount) * radioHeight;
        
        if ([self.shop.trades count] == 1) {
            [_radio1 setChecked:TRUE];
        }
    }
    
    CGRect picViewFrame = self.picViewContainer.frame;
    self.picViewContainer.frame = CGRectMake(picViewFrame.origin.x, picViewFrame.origin.y + offsetY + 30, picViewFrame.size.width, picViewFrame.size.height);
    //[self.mainView updateConstraints];
    //[self.mainView addSubview:self.picViewContainer];
}

- (void)initializeDatePicker
{
    self.accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 36)];
    UIButton* btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(self.accessoryView.frame.size.width-70, 3, 60, 30);
    [btnDone setBackgroundColor:[UIColor blueColor]];
    [btnDone setTitle:@"完成" forState:UIControlStateNormal];
    [btnDone.titleLabel setTextColor:[UIColor whiteColor]];
    [self.accessoryView addSubview:btnDone];
    [btnDone addTarget:self action:@selector(OnDatePickerDone:) forControlEvents:UIControlEventTouchUpInside];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    self.customInput = datePicker;
    [self.customInput addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)backgroupTap:(id)sender
{
    [self.titleField resignFirstResponder];
    [self.contentField resignFirstResponder];
    [self.startDateField resignFirstResponder];
    [self.endDateField resignFirstResponder];
}

- (void)publish:(id)sender
{
    NSString *title = self.titleField.text;
    NSString *content = self.contentField.text;
    NSString *startDate = self.startDateField.text;
    NSString *endDate = self.endDateField.text;
    
    //TODO进行检查
    if ([NSString isNull:title] || [NSString isNull:content]
        || [NSString isNull:startDate] || [NSString isNull:endDate]) {
        return;
    }
    
    if (selectedShopTrade == nil) {
        return;
    }
    if ([selectedImages count] == 0) {
        return;
    }
    
    ZKHSaleEntity *sale = [[ZKHSaleEntity alloc] init];
    sale.title = title;
    sale.content = content;
    sale.startDate = [NSDate milliSeconds:[NSDate initWithyyyyMMddString:startDate]];
    sale.endDate = [NSDate milliSeconds:[NSDate initWithyyyyMMddString:endDate]];;
    sale.tradeId = selectedShopTrade.trade.uuid;
    sale.publisher = [ZKHContext getInstance].user;
    sale.shop = self.shop;
    sale.images = [self getImageFiles];
    
    [ApplicationDelegate.zkhProcessor publishSale:sale completionHandler:^(Boolean result) {
        if (result) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self deleteImageFiles:sale.images];
        }
    } errorHandler:^(ZKHErrorEntity *error) {
        
    }];
}

- (NSMutableArray *) getImageFiles
{
    ZKHUserEntity *user = [ZKHContext getInstance].user;
    NSMutableArray *files = [[NSMutableArray alloc] init];
    
    for (UIImage *image in selectedImages) {
        NSString *aliasName = [NSString stringWithFormat:@"%@_share_%@.png", user.phone, [NSDate currentTimeString]];
        NSString *filePath = [ZKHImageLoader saveImage:image fileName:aliasName];
        
        ZKHFileEntity *file = [[ZKHFileEntity alloc] init];
        file.aliasName = aliasName;
        file.fileUrl = filePath;
        
        [files addObject:file];
    }
    return files;
}

- (void) deleteImageFiles:(NSMutableArray *)files
{
    for (ZKHFileEntity *file in files) {
        [ZKHImageLoader removeImageWithName:file.aliasName];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.picViewContainer reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)addPicViewClick:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"从图库选择",@"拍照",
                                  nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

- (void)previewPic:(id)sender
{
    UITapGestureRecognizer *rec = (UITapGestureRecognizer *)sender;
    UIView *view = rec.view;
    if (view) {
        int tag = view.tag;
        UIImage *image = tag < [selectedImages count] ? selectedImages[tag] : nil;
        if (image) {
            ZKHImagePreviewController *controller = [[ZKHImagePreviewController alloc] init];
            controller.readonly = false;
            controller.images = selectedImages;
            controller.image = image;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark datePicker
-(void)OnDatePickerDone:(id) sender{
    if ( [self.startDateField isFirstResponder] ) {
        [self.startDateField resignFirstResponder];
    } else if ( [self.endDateField isFirstResponder] ) {
        [self.endDateField resignFirstResponder];
    }
    
}

-(void)dateChanged:(id) sender{
    UIDatePicker *picker = (UIDatePicker *)sender;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    if ( [self.startDateField isFirstResponder] ) {
        self.startDateField.text = [NSString stringWithFormat:@"%@", [df stringFromDate:picker.date]];
    } else if ( [self.endDateField isFirstResponder] ) {
        self.endDateField.text = [NSString stringWithFormat:@"%@", [df stringFromDate:picker.date]];
    }
    
    
}

#pragma mark - QRadioButtonDelegate

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
    selectedShopTrade = radio.userObject;
}

#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [selectedImages count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKHPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    int row = indexPath.row;
    
    UIImage *image = row < [selectedImages count] ? selectedImages[row] : nil;
    if (image) {
        cell.imageView.image = image;
        cell.imageView.userInteractionEnabled = true;
        cell.imageView.tag = row;
        [cell.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(previewPic:)]];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"add_camera.png"];
        cell.imageView.userInteractionEnabled = TRUE;
        [cell.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPicViewClick:)]];
    }
    
    return cell;
}

//collection view的点击时间被阻止了
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourceType;
    switch (buttonIndex) {
        case 0://选择图片
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 1://拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        default:
            return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    [selectedImages addObject:selectedImage];
    [self.picViewContainer reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
