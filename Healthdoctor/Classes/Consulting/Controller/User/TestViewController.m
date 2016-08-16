//
//  TestViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/14.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "TestViewController.h"
#import "Define.h"
#import "HeaderView.h"
#import "UIColor+Utils.h"
#import "GKNetwork.h"
#import "HZUser.h"
#import "Config.h"
#import "HZAPI.h"
#import "PendingModel.h"
#import "ReportDetailViewController.h"
#import <UIButton+WebCache.h>
#import "UIView+Utils.h"
#import "ReportPhotoModel.h"
#import "ReportPhotoCell.h"
#import "HZUtils.h"
#import "MSSBrowseDefine.h"
#import "ReportModel.h"
#import "UIColor+Utils.h"
#import <MBProgressHUD.h>
#import "CusInfoViewController.h"
#import "TextCell.h"
#import "ImageCell.h"

#define MaxIconWH  80.0  //用户头像最大的尺寸
#define MinIconWH  30.0  // 用户头像最小的头像
#define maxScrollOff 165
#define kItemWidth kScreenSizeWidth/4

@interface TestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UIView *sliderView;
@property (nonatomic, strong)HeaderView *headerView;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIView *tabBarView;

@end

@implementation TestViewController
{
    NSInteger _seletedIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor viewBackgroundColor];
    //[self loadReportData];
    self.dataArr = [NSMutableArray array];
    [self setUpTableView];
}

//设置导航栏的titleView
- (void)setUpNavTitleView {
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = self.tableView.contentOffset.y/122.0;
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 100, 40)];
    self.label.text = self.cname;
    [self.label sizeToFit];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont boldSystemFontOfSize:18];
    //titleLabel.tintColor = [UIColor whiteColor];
    self.label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.label;
    self.label.hidden = YES;
}

//设置tableView
- (void)setUpTableView {

//  //  [[self.navigationController.navigationBar subviews] objectAtIndex:2].alpha = 0;
//    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
//    self.headerView.frame = CGRectMake(0, 0, kScreenSizeWidth, 186);
////    [self.headerView.iconBtn sd_setImageWithURL:[NSURL URLWithString:self.photoUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
//    [self.headerView.iconBtn sd_setImageWithURL:[NSURL URLWithString:self.photoUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon"]];
//    [self.headerView.iconBtn setRoundWithRadius:40];
//    self.headerView.nameLabel.text = self.cname;
//    [self.view addSubview:self.headerView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor viewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
   // self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReportPhotoCell" bundle:nil] forCellReuseIdentifier:@"ReportPhotoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellReuseIdentifier:@"ImageCell"];
   // [self.tableView registerNib:[UINib nibWithNibName:@"TextCell" bundle:nil] forCellReuseIdentifier:@"TextCell"];
                                                                                                  
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 101)];
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
    
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] lastObject];
    self.headerView.frame = CGRectMake(0, 0, kScreenSizeWidth, 165);
    self.headerView.backgroundColor = [UIColor navigationBarColor];
    //    [self.headerView.iconBtn sd_setImageWithURL:[NSURL URLWithString:self.photoUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    [self.headerView.iconBtn sd_setImageWithURL:[NSURL URLWithString:self.photoUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"]];
    [self.headerView.iconBtn sd_setImageWithURL:[NSURL URLWithString:self.photoUrl] forState:UIControlStateHighlighted placeholderImage:[UIImage imageNamed:@"default"]];
    
    __weak TestViewController *weakSelf = self;
    self.headerView.iconBtnClick = ^(){
        CusInfoViewController *info = [[CusInfoViewController alloc] init];
        info.cname = weakSelf.cname;
        info.photoUrl = weakSelf.photoUrl;
        info.customId = weakSelf.custID;
        [weakSelf.navigationController pushViewController:info animated:YES];
    };
    
    [self.headerView.iconBtn setRoundWithRadius:40];
    self.headerView.nameLabel.text = self.cname;
    [self.view addSubview:self.headerView];
    
}
//获取体检报告网络数据
- (void)loadReportData {
    
    _seletedIndex = 0;
    // 40210
     NSDictionary *param = @{@"customerId":self.custID};
     [[GKNetwork sharedInstance] GetUrl:kGetReportListURL param:param completionBlockSuccess:^(id responseObject) {
         NSLog(@"_________GetReportList:%@",responseObject);
         [self.dataArr removeAllObjects];
         if ([responseObject[@"state"] integerValue] != 1) {
             [HZUtils showHUDWithTitle:responseObject[@"message"]];
             [self.tableView reloadData];
             return;
         }
         //NSLog(@"______%@",responseObject[@"Data"]);
         if ([responseObject[@"Data"] isKindOfClass:[NSNull class]]) {
             
             [HZUtils showHUDWithTitle:@"没有体检报告。"];
             [self.tableView reloadData];
             return;
         }
         NSArray *data = responseObject[@"Data"];
         for (NSDictionary *dict in data) {
             ReportModel *model = [[ReportModel alloc] init];
             [model setValuesForKeysWithDictionary:dict];
             [self.dataArr addObject:model];
         }
         
         [self.tableView reloadData];
         
     } failure:^(NSError *error) {
         NSLog(@"________error:%@",error);
     }];
}

//获取照片病例网络数据
- (void)loadDataWithURL:(NSString *)url param:(NSDictionary *)param {
    
    [[GKNetwork sharedInstance] GetUrl:url param:param completionBlockSuccess:^(id responseObject) {

        [self.dataArr removeAllObjects];
        NSLog(@"______%@",responseObject);
        NSString *message = responseObject[@"message"];
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:message];
            [self.tableView reloadData];
            return ;
        }
        
        NSArray *data = (NSArray *)responseObject[@"Data"];
        if([data isKindOfClass:[NSNull class]]) {
            [self.tableView reloadData];
            [HZUtils showHUDWithTitle:@"没有病例照片。"];
            return ;
        }
        for (NSDictionary *dict in data) {
            ReportPhotoModel *model = [[ReportPhotoModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            
            //计算高度
            CGFloat itemWidth = (kScreenSizeWidth - 32 - 3*8)/4;
            NSInteger row = (model.imageUrlList.count-1)/4 + 1;
            model.cellHeight = 33 +8 +19 + row*itemWidth + (row-1)*8;
            
          //  NSLog(@"______%@_____%@",model,model.imageUrlList);
            [self.dataArr addObject:model];
            
        }
        
        [self.tableView reloadData];
        NSLog(@"________%@",self.dataArr);

    } failure:^(NSError *error) {
        NSLog(@"______%@",error);
    }];
}

//设置tableView分区头视图
- (UIView *)setUpSectionHeaderView {
    NSArray *arr = @[@"体检报告",@"照片病例",@"健康咨询",@"日常体征"];
    self.tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 40)];
    self.tabBarView.tag = 201;
    self.tabBarView.backgroundColor = [UIColor whiteColor];
   // CGFloat itemWidth = kScreenSizeWidth/4;
    for (NSInteger i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kItemWidth * i, 0, kItemWidth, 40)];
        label.text = arr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 101 +i;
        label.textColor = [UIColor grayColor];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selected:)]];
        
        [self.tabBarView addSubview:label];
    }
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake( 5, 38, kItemWidth - 10, 2)];
    self.sliderView.backgroundColor = [UIColor navigationBarColor];
    [self.tabBarView addSubview:self.sliderView];
    [self selectedIndex:0];
    return self.tabBarView;
}

- (void)selected:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - 101;
    [self selectedIndex:index];
}

//选中对应的item
- (void)selectedIndex:(NSInteger)index {
    _seletedIndex = index;
    
    for (UIView *view in [self.tabBarView subviews]) {
        
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            if ((label.tag - 101) == index) {
                label.textColor = [UIColor navigationBarColor];
            }else {
                label.textColor = [UIColor grayColor];
            }
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderView.frame = CGRectMake(5 + index*kItemWidth, 38, kItemWidth - 10, 2);
    }];
    
   //这个地方也需要判断选中的那个item，进行请求对应的数据。
    if (_seletedIndex == 1) {
        NSDictionary *param = @{@"accountID":self.accountID};
        [self loadDataWithURL:kReportPhotoListURL param:param];
    }else if (_seletedIndex == 0){
        [self loadReportData];
        
    }else {
        [self.tableView reloadData];
    }

}

#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_seletedIndex == 1 || _seletedIndex == 0) {
        return self.dataArr.count;
    }
    
    if (_seletedIndex == 2) {
        return self.chartDataArr.count;
    }
    return 20;
}

//填充cell，需要判断不同的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_seletedIndex == 1) {
        //照片病例
        ReportPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportPhotoCell"];
        cell.present = ^(MSSBrowseNetworkViewController *vc) {
            [vc showBrowseViewController:self];
        };
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 101) {
                for (UIView *collectionView in view.subviews) {
                    [collectionView removeFromSuperview];
                }
            }
        }
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }else if (_seletedIndex == 0) {
        //体检报告
        ReportModel *model = self.dataArr[indexPath.row];
        static NSString *cellId = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 201) {
                [view removeFromSuperview];
            }
        }
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = model.checkUnitName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@-%@",[model.checkDate substringToIndex:4],[model.checkDate substringWithRange:NSMakeRange(4, 2)],[model.checkDate substringWithRange:NSMakeRange(6, 2)]];
        cell.textLabel.textColor = [UIColor fontColor];
        cell.detailTextLabel.textColor = [UIColor fontColor];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, 50 - 0.5, kScreenSizeWidth - 15, 0.5)];
        view.backgroundColor = kSetRGBColor(209, 209, 209);
        view.tag = 201;
        [cell.contentView addSubview:view];
        return cell;
    }else if (_seletedIndex == 2) {
        //健康咨询
       // NSLog(@"________健康咨询。");
        //纯文本样式
        NSInteger count = self.chartDataArr.count - 1;
        ChartModel *model = self.chartDataArr[count - indexPath.row];
        
        if ([model.consultType integerValue] == 2) {
            ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
            cell.clickBlock = ^(MSSBrowseNetworkViewController *vc) {
                [vc showBrowseViewController:self];
            };
            UIView *bgView = [cell.contentView viewWithTag:201];
            for (UIView *view in [bgView subviews]) {
                if ([view isKindOfClass:[UIImageView class]]) {
                    if (view.tag != 102) {
                        [view removeFromSuperview];
                    }
                }
            }
            [cell showDataWithModel:model];
            
            return cell;
        }else {
            
            static NSString *cellId = @"TextCell";
            TextCell *cell = (TextCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
            
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TextCell" owner:self options:nil] lastObject];
            }
//            cell.messageClick = ^(NSString *checkCode, NSString *workNo){
//                ReportDetailViewController *detail = [[ReportDetailViewController alloc] init];
//                detail.checkCode = checkCode;
//                detail.workNum = workNo;
//                detail.custId = [NSString stringWithFormat:@"%ld",self.model.custId];
//                [self.navigationController pushViewController:detail animated:YES];
//            };
            [cell showDataWithModel:model];
            return cell;
        }
    }else if (_seletedIndex == 3) {
        //日常体征
        NSLog(@"________日常体征。");
    }else if (_seletedIndex == 0) {
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    NSArray *arr =@[@"体检报告",@"照片病例",@"健康咨询",@"日常体征"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@,测试数据,第%ld行。",arr[_seletedIndex],indexPath.row];
    return cell;
}

- (void)configureCell:(ReportPhotoCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ReportPhotoModel *model = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showDataWithModel:model];
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_seletedIndex == 1) {
        //照片病例
        ReportPhotoModel *model = self.dataArr[indexPath.row];
        return model.cellHeight;
    }else if (_seletedIndex == 2) {
        //健康咨询
       // NSLog(@"_______健康咨询。");
        NSInteger count = self.chartDataArr.count - 1;
        ChartModel *model = self.chartDataArr[count - indexPath.row];
        
        if ([model.consultType integerValue] == 2) {
            
            NSArray *imageArr = [model.appendInfo componentsSeparatedByString:@","];
            NSInteger row = (imageArr.count - 1)/3 +1;
            CGFloat padding = 10;
            CGFloat bgViewWidth = kScreenSizeWidth - 120 - 10;
            CGFloat itemWidth = (bgViewWidth - 40) /3;
            return (row + 1)*padding + row*itemWidth +10 +10 +20;
        }else {
            //根据文字内容计算size
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            NSString *contentStr = model.content;
            if ([model.consultType integerValue] == 3) {
                // model.content = [model.content stringByAppendingString:@"\n点击加载更多"];
                contentStr = [model.content stringByAppendingString:@"\n点击查看报告"];
            }
            CGSize size = [contentStr boundingRectWithSize:CGSizeMake(kScreenSizeWidth - 120 - 40, 1000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            
            return size.height + 62;
        }
        
    }else if (_seletedIndex == 0) {
        //体检报告
        //NSLog(@"_______体检报告。");
        return 50;
    }else if (_seletedIndex == 3) {
        //日常体征
       // NSLog(@"________日常体征。");
    }
    return 50;
}

//设置tableView的分区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth, 50)];
    view.backgroundColor = [UIColor viewBackgroundColor];
    //如果创建过itemBarView就不再创建了
    if (!self.tabBarView) {

        [view addSubview:[self setUpSectionHeaderView]];

    }else {
        [view addSubview:self.tabBarView];
    }

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_seletedIndex == 0) {
        //体检报告
        ReportModel *model = self.dataArr[indexPath.row];
       // NSLog(@"________体检报告");
        ReportDetailViewController *detail = [[ReportDetailViewController alloc] init];
        
        detail.checkCode = model.checkUnitCode;
        detail.workNum = model.workNo;
        detail.custId = self.custID;
        [self.navigationController pushViewController:detail animated:YES];
        
    }else if (_seletedIndex == 1) {
        //照片病例
        //NSLog(@"________照片病例");
    }else if (_seletedIndex == 2) {
        //健康咨询
       // NSLog(@"________健康咨询");
    }else if (_seletedIndex == 3) {
        //日常体征
      //  NSLog(@"________日常体征");
    }
}

#pragma mark -- UIScrollerViewDelgate
//改变导航栏的alpha值
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"______%@",NSStringFromCGPoint(scrollView.contentOffset));
    self.label.hidden = NO;
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = scrollView.contentOffset.y/101.0;
    self.label.alpha = scrollView.contentOffset.y/101.0f;
 
    if (scrollView.contentOffset.y <= 101) {
        self.headerView.frame = CGRectMake(0, -scrollView.contentOffset.y, kScreenSizeWidth, 165);
    }else {
        self.headerView.frame = CGRectMake(0, -101, kScreenSizeWidth, 165);
    }
    
    if (scrollView.contentOffset.y <= 0) {
        CGFloat updateY = scrollView.contentOffset.y;
        
        self.headerView.frame = CGRectMake(0, 0, kScreenSizeWidth, 165 - scrollView.contentOffset.y);
        
        CGFloat reduceW = updateY * (MaxIconWH - MinIconWH)/(maxScrollOff - 64);
        
        CGFloat yuanw = MAX(MinIconWH, MaxIconWH - reduceW);
        self.headerView.iconBtn.layer.cornerRadius = yuanw/2.0;

        self.headerView.iconWidth.constant = yuanw;
        self.headerView.iconHeight.constant = yuanw;
    }
    
}

//控制器将要出现的时候
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setUpNavTitleView];
}
//控制器将要消失
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1.0;
}


@end
