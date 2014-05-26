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
    UITextField *textField = self.inputTextField;
    [textField resignFirstResponder];
    NSString *newValue = textField.text;
    if (newValue == nil || [newValue length] == 0
        || [orginalValue isEqualToString:newValue]) {
        [textField becomeFirstResponder];
        return;
    }
    
    [self doSave:newValue];
}

- (void)doSave:(NSString *)newValue
{
    
}

@end
