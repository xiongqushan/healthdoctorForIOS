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
    self.dataArr = [NSMutableArray array];
    NSArray *title = @[@[@"姓名",@"性别",@"年龄"],@[@"体检中心",@"体检日期",@"体检号",@"工作单位"]];
    if (!_infoModel.sex) {
        _infoModel.sex = @"";
    }
    NSArray *value = @[@[_infoModel.customerName,_infoModel.sex,_infoModel.age],@[_infoModel.checkUnitName,_infoModel.showReportDate,_infoModel.workNo,@""]];
    
    for (NSInteger i = 0; i < title.count; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger j = 0; j < [title[i] count]; j++) {
            InfoItemModel *model = [[InfoItemModel alloc] init];
            model.title = [title[i] objectAtIndex:j];
            model.value = [value[i] objectAtIndex:j];
            [arr addObject:model];
        }
        [self.dataArr addObject:arr];
    }
    

}

- (void)setUpTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight - 64 - 40) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor viewBackgroundColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    
    InfoItemModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",model.value];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section == 3) {
//        return 10;
//    }
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
