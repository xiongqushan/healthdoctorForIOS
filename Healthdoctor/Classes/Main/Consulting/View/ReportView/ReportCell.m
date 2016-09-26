//
//  ReportCell.m
//  ReportTableViewDemo
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportCell.h"
#import "ReportItemCell.h"
#import "ResultModel.h"
#import "ShowDetailView.h"

#define kScreenSizeWidth [UIScreen mainScreen].bounds.size.width
#define kScreenSizeHeight [UIScreen mainScreen].bounds.size.height
#define kSetRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface ReportCell()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end


@implementation ReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.reportView.layer.borderColor = kSetRGBColor(210, 210, 210).CGColor;
    self.reportView.layer.borderWidth = 1.0;
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [self setUpTableView];
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth - 60, 55 *self.dataArr.count) style:UITableViewStylePlain];
    self.tableView.rowHeight = 55;
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.reportView addSubview:self.tableView];
    
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"ReportItemCell" bundle:nil] forCellReuseIdentifier:@"CellId"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
  //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ResultModel *model = self.dataArr[indexPath.row];
    [cell showDataWithModel:model isExceptionsView:NO];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    ResultModel *model = self.dataArr[indexPath.row];
//    ShowDetailView *view = [[ShowDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, kScreenSizeHeight) title:model.resultValue];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
