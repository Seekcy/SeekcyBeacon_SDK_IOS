//
//  SICUUIDChooseViewController.m
//  SeekcyIBeaconConfig
//
//  Created by metRooooo on 15/6/12.
//  Copyright (c) 2015年 com.seekcy. All rights reserved.
//

#import "SICUUIDChooseViewController.h"

@interface SICUUIDChooseViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *uuidArray;
@property (nonatomic, strong) UITableView *tbView;

- (void)addTableView;

@end


@implementation SICUUIDChooseViewController
@synthesize selectedUUIDString;

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uuidArray = [[NSMutableArray alloc] initWithArray:@[@{@"name":@"苹果默认",@"uuid":@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"},@{@"name":@"微信摇一摇",@"uuid":@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"}]];
    [self addTableView];
}

#pragma mark - Getter And Setter

- (void)addTableView{
    CGRect frame = self.view.bounds;
    frame.size.height -= 64;
    self.tbView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    //[self.tbView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tbView];
}

- (void)chooseUUIDBlock:(void (^)(NSString *))block{
    chooseUUIDBlock = block;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.uuidArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dic = self.uuidArray[indexPath.row];
    NSString *nameString = dic[@"name"];
    NSString *uuidString = dic[@"uuid"];
    
    cell.textLabel.text = nameString;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.detailTextLabel.text = uuidString;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
    
    if([self.selectedUUIDString isEqualToString:uuidString]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.uuidArray[indexPath.row];
    NSString *uuidString = dic[@"uuid"];
    chooseUUIDBlock(uuidString);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - User Method

@end
