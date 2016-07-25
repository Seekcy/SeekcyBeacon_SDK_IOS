//
//  UpdateFrequencyViewController.m
//  SeekcyIBeaconConfig
//
//  Created by seekcy on 15/8/3.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "UpdateFrequencyViewController.h"

@interface UpdateFrequencyViewController ()<UITextFieldDelegate>{
    
    UIView *inputView;
}

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITextField *myTextfield;

@end

@implementation UpdateFrequencyViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"光感更新频率选择";
    
    _dataArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"10",@"20",@"30",@"60",@"1200",@"1800"];
    
    //
    // 初始化
    inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    inputView.backgroundColor = [UIColor whiteColor];
    
    UIButton *keyboardDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    keyboardDownButton.frame = CGRectMake(inputView.frame.size.width - 80, (44-35)/2, 60, 35);
    keyboardDownButton.layer.cornerRadius = 5;
    keyboardDownButton.backgroundColor = kMainNavColor;
    [keyboardDownButton setTitle:@"完成" forState:UIControlStateNormal];
    [keyboardDownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [keyboardDownButton addTarget:self action:@selector(keyboardDownButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:keyboardDownButton];
}


- (void)keyboardDownButtonPress{
    [_myTextfield resignFirstResponder];
    
    chooseValueBlock(_myTextfield.text);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseValueBlock:(void(^)(NSString *valueString))block{
    chooseValueBlock = block;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CityCellIdentifier = @"CityCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CityCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(indexPath.row == _dataArray.count){
        cell.textLabel.text = @"手动输入";
        
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 200, 2, 180, 40)];
        textfield.placeholder = @"手动输入";
        textfield.delegate = self;
        textfield.textAlignment = NSTextAlignmentRight;
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        textfield.inputAccessoryView = inputView;
        [cell addSubview:textfield];
        _myTextfield = textfield;
        
        if(![_dataArray containsObject:self.selectedValue]){
            _myTextfield.text = self.selectedValue;
        }
    }
    else{
        NSString *obj = _dataArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ s",obj];
        
        if([_selectedValue isEqualToString:obj]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == _dataArray.count){
        [_myTextfield becomeFirstResponder];
    }
    else{
        chooseValueBlock(_dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}


@end
