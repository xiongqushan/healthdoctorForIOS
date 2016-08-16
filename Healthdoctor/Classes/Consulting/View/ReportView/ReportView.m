//
//  ReportView.m
//  ReportTableViewDemo
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportView.h"
#import "ReportCell.h"
#import "DepartmentModel.h"
#import "CheckItemModel.h"
#import "ResultModel.h"

#define kSetRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface ReportView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ReportView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setUpTableView];
    }
    
    return self;
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReportCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DepartmentModel *model = self.dataArr[section];
    
    return model.checkItmes.count;
    //return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    UIView *view = [[cell.contentView viewWithTag:101].subviews lastObject];
    [view removeFromSuperview];
    
    DepartmentModel *model = self.dataArr[indexPath.section];
    CheckItemModel *itemModel = model.checkItmes[indexPath.row];
    cell.checkItemLabel.text = itemModel.checkItemName;
    cell.dataArr = itemModel.checkResults;
    [cell setUpTableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DepartmentModel *model = self.dataArr[indexPath.section];
    CheckItemModel *itemModel = model.checkItmes[indexPath.row];
    return 40 + 55*itemModel.checkResults.count; //cell标题，小结 加上 reportItemCell的高度
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DepartmentModel *model = self.dataArr[section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 4, 200, 22)];
    label.backgroundColor = kSetRGBColor(19, 155, 239);
    label.text = model.departmentName;
    label.textColor = [UIColor whiteColor];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


@end
