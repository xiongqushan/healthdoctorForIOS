//
//  ExamSummaryViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/8.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ExamSummaryViewController.h"
#import "Define.h"
#import "SummaryCell.h"
#import "SummarysModel.h"
#import "HZUtils.h"
#import "UIColor+Utils.h"

@interface ExamSummaryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ExamSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setUpTableView];
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight - 64 - 40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   // self.tableView.tableFooterView = [UIView new];
    self.tableView.tableFooterView = [self setUpFooterView];
    self.tableView.sectionFooterHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor viewBackgroundColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SummaryCell" bundle:nil] forCellReuseIdentifier:@"SummaryCell"];
    
}

- (UIView *)setUpFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 70)];
    view.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kScreenSizeWidth - 20, 40)];
    imageView.image = [UIImage imageNamed:@"cellBg2"];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, kScreenSizeWidth - 40, 20)];
    NSString *str = [[self.masterDoctor componentsSeparatedByString:@" "] firstObject];
    label.text = [NSString stringWithFormat:@"主检医生:%@",str];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor textColor];
    [view addSubview:label];
    
    return view;
}

#pragma mark --UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    SummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SummaryCell"];
    if (indexPath.row == 0) {
        cell.lineLabelY.constant = 30;
        cell.lineLabelH.constant = 11;
    }else {
        cell.lineLabelY.constant = 0;
        cell.lineLabelH.constant = 41;
    }
    
    if (indexPath.row % 2 == 0) {
        cell.pointView.backgroundColor = kSetRGBColor(155, 203, 101);
    }else {
        cell.pointView.backgroundColor = kSetRGBColor(255, 187, 92);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SummarysModel *model = self.dataArr[indexPath.row];
    [cell showDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    SummarysModel *model = self.dataArr[indexPath.row];
    CGSize size = [HZUtils getHeightWithFont:[UIFont systemFontOfSize:15] title:model.content maxWidth:kScreenSizeWidth - 50];
    return size.height + 55;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
