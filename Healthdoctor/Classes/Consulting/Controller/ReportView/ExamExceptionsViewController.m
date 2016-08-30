//
//  ExamExceptionsViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/8.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ExamExceptionsViewController.h"
#import "ResultModel.h"
#import "Define.h"
#import "ReportItemCell.h"
#import "UIColor+Utils.h"
#import "ShowDetailView.h"
#import "ExceptionCell.h"
#import "HZUtils.h"
#import "UIView+Utils.h"

@interface ExamExceptionsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ExamExceptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpHeaderView];
    [self setUpTableView];
    
}

- (void)setUpHeaderView {

    self.view.backgroundColor = [UIColor viewBackgroundColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenSizeWidth, 30)];
    label.backgroundColor = kSetRGBColor(254, 187, 92);
    label.font = [UIFont systemFontOfSize:13];
    label.text = [NSString stringWithFormat:@"河南省直医院分析到体检报告中以下%ld项可能存在异常",self.dataArr.count];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenSizeWidth, kScreenSizeHeight - 64 - 40 - 60) style:UITableViewStylePlain];
   // self.tableView.rowHeight = 55;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ExceptionCell" bundle:nil] forCellReuseIdentifier:@"ExceptionCell"];
    self.tableView.tableFooterView = [self getFooterView];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor viewBackgroundColor];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExceptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExceptionCell"];
    if (indexPath.row == 0) {
        cell.pointView.hidden = NO;
    }else {
        cell.pointView.hidden = YES;
    }
    ResultModel *model = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showDataWithModel:model];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultModel *model = self.dataArr[indexPath.row];
    if ([model.resultTypeID integerValue] == 1) {
        //数值类型
        return 85;
    }else {
        CGFloat height = [HZUtils getHeightWithFont:[UIFont systemFontOfSize:14] title:model.resultValue maxWidth:kScreenSizeWidth - 60].height;
        return height + 85 - 18;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    ResultModel *model = self.dataArr[indexPath.row];
//    
//    ShowDetailView *view = [[ShowDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight) title:model.resultValue];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[UIApplication sharedApplication].keyWindow addSubview:view];
//    });
    
}

#pragma mark -- 设置tableView分割线顶格
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
