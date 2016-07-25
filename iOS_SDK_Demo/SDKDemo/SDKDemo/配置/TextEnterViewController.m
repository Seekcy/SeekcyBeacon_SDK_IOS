//
//  TextEnterViewController.m
//  SeekcyBeaconSDKDemo
//
//  Created by seekcy on 15/7/13.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "TextEnterViewController.h"

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface TextEnterViewController ()<UITextFieldDelegate>{
    UITextField *textField;
}

@end

@implementation TextEnterViewController
@synthesize textString;
@synthesize placeHolderString;

- (void)loadView{
    [super loadView];
    
    textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(5 , 80, self.view.frame.size.width - 10, 50);
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    [self.view addSubview:textField];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *navbackItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(navbackPress)];
    self.navigationItem.leftBarButtonItem = navbackItem;
}

- (void)navbackPress{
    [self.delegate textEnterCompleteWithTextString:textField.text controllerTag:self.tag];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [textField setText:textString];
    [textField setPlaceholder:placeHolderString];
    [textField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSLog(@"1 - %lu",(unsigned long)textField.text.length);
    NSLog(@"%@ - %d,%d - %@",textField.text,range.location,range.length,string);
    
    const char * _char = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    if (isBackSpace == -8) {
        NSLog(@"Backspace was pressed");
    }
    
    
    return YES;
}



@end
