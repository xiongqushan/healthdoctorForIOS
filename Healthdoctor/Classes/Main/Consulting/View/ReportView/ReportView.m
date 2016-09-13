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
#import "Define.h"
#import "UIColor+Utils.h"
#import "UIView+Utils.h"

#define kSetRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define kleftViewWidth 150

@interface ReportView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *leftTableView;

@end

@implementation ReportView
{
    BOOL _isShowLeftView;
    UITapGestureRecognizer *_tap;
    UIButton *_floatBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self setUpLeftView];
//        [self setUpTableView];
    }
    
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    
    [self setUpLeftView];
    [self setUpTableView];
}

- (void)setUpLeftView {
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -1, kleftViewWidth, self.bounds.size.height+1)];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    leftTableView.layer.borderWidth = 1.0;
    leftTableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:leftTableView];
    [leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defaultCell"];

    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kleftViewWidth, 60)];
    headerView.textColor = [UIColor textColor];
    headerView.text = [NSString stringWithFormat:@"体检项目 (%ld) ",self.dataArr.count];
    leftTableView.tableHeaderView = headerView;
    
    self.leftTableView = leftTableView;
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReportCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
    self.tableView.backgroundColor = [UIColor viewBackgroundColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewClick)];
    _tap = tap;
    
    if (!(self.dataArr.count == 0)) {
        //添加浮动按钮
        UIButton *floatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [floatBtn setBackgroundImage:[UIImage imageNamed:@"floatingBtn"] forState:UIControlStateNormal];
        floatBtn.frame = CGRectMake(self.bounds.size.width - 80, self.bounds.size.height - 140, 44, 44);
        [floatBtn addTarget:self action:@selector(floatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:floatBtn];
        _floatBtn = floatBtn;
    }

}

#pragma mark -- 浮动按钮被点击
- (void)floatBtnClick:(UIButton *)btn {
    
    _isShowLeftView = !_isShowLeftView;
    if (_isShowLeftView) {
        //显示左侧列表
        //获取tableView的偏移量
        CGPoint offset = self.tableView.contentOffset;
        NSIndexPath *tableViewIndexPath = [self.tableView indexPathForRowAtPoint:offset];
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:tableViewIndexPath.section inSection:0];
        [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];

        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.frame = CGRectMake(kleftViewWidth, 0, self.bounds.size.width, self.bounds.size.height);
            btn.transform = CGAffineTransformRotate(btn.transform, -M_PI_4);
        }];
        
        [self.tableView addGestureRecognizer: _tap];
        
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
            btn.transform = CGAffineTransformRotate(btn.transform, M_PI_4);
        }];
        [self.tableView removeGestureRecognizer:_tap];
    }
}

- (void)tableViewClick {
    _isShowLeftView = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _floatBtn.transform = CGAffineTransformRotate(_floatBtn.transform, M_PI_4);
    }];
    [self.tableView removeGestureRecognizer:_tap];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.tableView) {
        return self.dataArr.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableView) {
        DepartmentModel *model = self.dataArr[section];
        return model.checkItmes.count;
    }
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableView) {
        static NSString *cellId = @"cellId";
        ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *view = [[cell.contentView viewWithTag:101].subviews lastObject];
        [view removeFromSuperview];
        
        DepartmentModel *model = self.dataArr[indexPath.section];
        CheckItemModel *itemModel = model.checkItmes[indexPath.row];
        cell.checkItemLabel.text = itemModel.checkItemName;
        cell.dataArr = itemModel.checkResults;
        //[cell setUpTableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    DepartmentModel *model = self.dataArr[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"(%ld)%@",indexPath.row+1,model.departmentName];
    cell.textLabel.textColor = [UIColor textColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = kSetRGBColor(40, 170, 238);
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        DepartmentModel *model = self.dataArr[indexPath.section];
        CheckItemModel *itemModel = model.checkItmes[indexPath.row];
        return 49 + 55*itemModel.checkResults.count; //cell标题，小结 加上 reportItemCell的高度
    }

    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        DepartmentModel *model = self.dataArr[section];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 60)];
        view.backgroundColor = [UIColor viewBackgroundColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SectionHeaderBg"]];
        imageView.frame = CGRectMake(20, 23, view.bounds.size.width - 40, 40);
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 25, kScreenSizeWidth - 60, 30)];
        label.text = model.departmentName;
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor whiteColor];
        label.tag = 200 + section;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionClick:)]];
        [view addSubview:label];
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, 1, 19)];
        lineLabel.backgroundColor = kSetRGBColor(210, 210, 210);
        [view addSubview:lineLabel];
        
        UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(26, 6, 9, 9)];
        pointView.backgroundColor = kSetRGBColor(255, 187, 92);
        [pointView setRoundWithRadius:4.5];
        [view addSubview:pointView];
        
        return view;
    }
    
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return 60;
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        _isShowLeftView = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.frame = self.bounds;
            _floatBtn.transform = CGAffineTransformRotate(_floatBtn.transform, M_PI_4);
        }];
        
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [self.tableView scrollToRowAtIndexPath:indexPath2 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark -- 分区头视图被点击
//分区头视图被点击
- (void)sectionClick:(UITapGestureRecognizer *)tap {
//    _isShowLeftView = !_isShowLeftView;
//    
//    if (_isShowLeftView) {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.tableView.frame = CGRectMake(kleftViewWidth, 0, self.bounds.size.width, self.bounds.size.height);
//        }];
//        
//        [self.tableView addGestureRecognizer: _tap];
//        
//        NSInteger index = tap.view.tag - 200;
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
//        
//    }else {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.tableView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//        }];
//        [self.tableView removeGestureRecognizer:_tap];
//    }

}


@end
