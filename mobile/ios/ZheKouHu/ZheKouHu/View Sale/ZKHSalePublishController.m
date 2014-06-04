//
//  ZKHSalePublishController.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-4.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ZKHSalePublishController.h"
#import "ZKHSharePicCell.h"
#import "ZKHImagePreviewController.h"
#import "SelectionCell.h"
#import "TableViewWithBlock.h"

static NSString *CellIdentifier = @"SharePicCell";

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
    
    UINib *nib = [UINib nibWithNibName:@"ZKHSharePicCell" bundle:nil];
    [self.picViewContainer registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
    self.picViewContainer.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(publish:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    [self initializeTradesView];
    [self initializeDatePicker];
    
    //self.startDateField.layer.borderWidth = 1.0;
    //self.startDateField.layer.borderColor = [UIColor colorWithWhite:209.0 / 255.0 alpha:1.0].CGColor;
    //self.startDateField.backgroundColor = [UIColor whiteColor];
    self.startDateField.inputAccessoryView = self.accessoryView;
    self.startDateField.inputView = self.customInput;
    
    //self.endDateField.layer.borderWidth = 1.0;
    //self.endDateField.layer.borderColor = [UIColor colorWithWhite:209.0 / 255.0 alpha:1.0].CGColor;
    //self.endDateField.backgroundColor = [UIColor whiteColor];
    self.endDateField.inputAccessoryView = self.accessoryView;
    self.endDateField.inputView = self.customInput;
    
    [self.mainView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroupTap:)]];
    
}

- (void)initializeTradesView
{
    if ([self.shop.trades count] == 0) {
        selectedTradeIndex = 0;
        ZKHShopTradeEntity *shopTrade = self.shop.trades[selectedTradeIndex];
        self.tradeTextField.text = shopTrade.trade.name;
    }
    
    isOpened = NO;
    int count = [self.shop.trades count];
    [self.tradesTableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return count;
        
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        
        ZKHShopTradeEntity *shopTrade = self.shop.trades[indexPath.row];
        cell.lb.text = shopTrade.trade.name;
        
        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        selectedTradeIndex = indexPath.row;
        ZKHShopTradeEntity *shopTrade = self.shop.trades[selectedTradeIndex];
        self.tradeTextField.text = shopTrade.trade.name;
        [_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    
    [_tradesTableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_tradesTableView.layer setBorderWidth:2];
}

- (void)initializeDatePicker
{
    self.accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    UIButton* btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(self.accessoryView.frame.size.width-70, 0, 60, 30);
    [btnDone setBackgroundColor:[UIColor blueColor]];
    [btnDone setTitle:@"完成" forState:UIControlStateNormal];
    [btnDone.titleLabel setTextColor:[UIColor whiteColor]];
    [self.accessoryView addSubview:btnDone];
    [btnDone addTarget:self action:@selector(OnDatePickerDone:) forControlEvents:UIControlEventTouchUpInside];
    
    self.customInput = [[UIDatePicker alloc] init];
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

- (void)addPic
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

- (IBAction)changeOpenStatus:(id)sender {
    
    if (isOpened) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"dropdown.png"];
            [_openButton setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=_tradesTableView.frame;
            
            frame.size.height=1;
            [_tradesTableView setFrame:frame];
            self.picViewContainer.hidden = false;
        } completion:^(BOOL finished){
            
            isOpened=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"dropup.png"];
            [_openButton setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=_tradesTableView.frame;
            frame.size.height = 35 * [self.shop.trades count];
            [_tradesTableView setFrame:frame];
            self.picViewContainer.hidden = true;
        } completion:^(BOOL finished){
            
            isOpened=YES;
        }];
        
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
    ZKHSharePicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    int row = indexPath.row;
    
    UIImage *image = row < [selectedImages count] ? selectedImages[row] : nil;
    if (image) {
        cell.imageView.image = image;
    }else{
        cell.imageView.image = [UIImage imageNamed:@"add_camera.png"];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    
    UIImage *image = row < [selectedImages count] ? selectedImages[row] : nil;
    if (image) {
        ZKHImagePreviewController *controller = [[ZKHImagePreviewController alloc] init];
        controller.readonly = false;
        controller.images = selectedImages;
        controller.image = image;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self addPic];
    }
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
