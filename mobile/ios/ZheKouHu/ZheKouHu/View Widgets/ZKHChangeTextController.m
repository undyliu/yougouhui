//
//  ZKHChangeTextController.m
//  ZheKouHu
//
//  Created by undyliu on 14-5-23.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHChangeTextController.h"

@interface ZKHChangeTextController ()

@end

@implementation ZKHChangeTextController

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
	
    orginalValue = [[self getOriginalTextFieldValue] copy];
    
    [[NSBundle mainBundle] loadNibNamed:@"ZKHChangeTextController" owner:self options:nil];
    self.inputTextField.text = orginalValue;
    
    self.inputTextField.popMessageWhenEmptyText = [NSString stringWithFormat:@"%@不能为空.", self.fieldname];
    [self.inputTextField becomeFirstResponder];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getOriginalTextFieldValue
{
    return nil;
}

- (void)save:(id)sender
{
    [self.inputTextField resignFirstResponder];
    
    ZKHTextField *textField = self.inputTextField;
    [textField resignFirstResponder];
    NSString *newValue = textField.text;
    if (newValue == nil || [newValue length] == 0){
        [textField showTipView];
        //[textField becomeFirstResponder];
        return;
    }else if ([newValue length] > self.maxLength){
        [textField showTipView:[NSString stringWithFormat:@"%@不能超过%d位.", self.fieldname, self.maxLength]];
        return;
    }
    else if([orginalValue isEqualToString:newValue]){
        [textField showTipView:[NSString stringWithFormat:@"%@未修改，不需要保存.", self.fieldname]];
        return;
    }
    
    [self doSave:newValue];
}

- (void)doSave:(NSString *)newValue
{
    
}

- (IBAction)backgroupTap:(id)sender {
    [self.inputTextField resignFirstResponder];
}

- (IBAction)textEditDone:(id)sender {
    
    [self save: nil];
}

@end
