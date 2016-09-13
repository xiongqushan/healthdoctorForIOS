//
//  BasicInfoViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/22.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BasicInfoViewController.h"
#import "Define.h"
#import "InfoItemModel.h"
#import "UIColor+Utils.h"
#import "BasicInfoCell.h"
#import "UIView+Utils.h"

@interface BasicInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self parseData];
    [self setUpTableView];
}

- (void)parseData {

    if (!_infoModel.sex) {
        _infoModel.sex = @"";
    }
    self.dataArr = [NSMutableArray array];
    NSArray *title = @[@"姓名",@"性别",@"年龄",@"体检中心",@"体检日期",@"体检号",@"工作单位"];
    NSArray *value = @[_infoModel.customerName,_infoModel.sex,_infoModel.age,_infoModel.checkUnitName,_infoModel.showReportDate,_infoModel.workNo,@""];
    for (NSInteger i = 0; i < title.count; i++) {
        InfoItemModel *model = [[InfoItemModel alloc] init];
        model.title = title[i];
        model.value = value[i];
        [self.dataArr addObject:model];
    }
}

- (void)setUpTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight - 64 - 40) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor viewBackgroundColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [self getFooterView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:@"BasicInfoCell" bundle:nil] forCellReuseIdentifier:@"BasicInfoCell"];
}

- (UIView *)getFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 20)];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 0, 1, 19)];
    lineLabel.backgroundColor = kSetRGBColor(210, 210, 210);
    [footerView addSubview:lineLabel];
    
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(29, 11, 9, 9)];
    pointView.backgroundColor = kSetRGBColor(155, 203, 101);
    [pointView setRoundWithRadius:4];
    [footerView addSubview:pointView];
    
    return footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    BasicInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicInfoCell"];
    if (indexPath.row == 0) {
        cell.pointView.hidden = NO;
    }else {
        cell.pointView.hidden = YES;
    }
    InfoItemModel *model = self.dataArr[indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@:",model.title];
    cell.valueLabel.text = [NSString stringWithFormat:@"%@",model.value];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 60;
    }else {
        return 51;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
