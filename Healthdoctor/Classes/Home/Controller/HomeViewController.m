//
//  HomeViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/18.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HomeViewController.h"
#import "ScanCodeViewController.h"
#import "Define.h"
#import "HomeGroupModel.h"
#import "GroupView.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "Config.h"
#import "HZUser.h"
#import "HomeDetailViewController.h"
#import "HZUtils.h"
#import <MBProgressHUD.h>
#import "UIColor+Utils.h"
#import "GroupManager.h"

#define kBaseTag 101

@interface HomeViewController ()

@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation HomeViewController
{
    NSArray *_sortArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor viewBackgroundColor];
    [self loadData];
}

- (void)loadData {
    self.dataArr = [NSMutableArray array];
    
    HZUser *user = [Config getProfile];
    NSDictionary *param = @{@"doctorId":user.doctorId};

    [[GKNetwork sharedInstance] GetUrl:kGetCusGroupURL param:param completionBlockSuccess:^(id responseObject) {
        
        if ([responseObject[@"state"] integerValue] == 1) {
            
            NSArray * Data = responseObject[@"Data"];
            for (NSDictionary *dict in Data) {
                HomeGroupModel *model = [[HomeGroupModel alloc] init]; 
                [model setValuesForKeysWithDictionary:dict];
                if ([model.name containsString:@"Test_"]) {
                    continue;
                }else {
                    [self.dataArr addObject:model];
                }
//                [self.dataArr addObject:model];
                
                /*
                [[NSUserDefaults standardUserDefaults] setObject:model.name forKey:[NSString stringWithFormat:@"%@",model.Id]];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                if ([model.name containsString:@"Test_"]) {
                    
                }else {
                    [self.dataArr addObject:model];
                }
                

                NSLog(@"_______%@   %@",model.name,model.Id);
                */
            }
            [GroupManager setGroupArray:self.dataArr];
            
            //对数组进行排序
            _sortArr = [self.dataArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
               
                HomeGroupModel *pModel1 = obj1;
                HomeGroupModel *pModel2 = obj2;
                
                if ([pModel1.groupNum integerValue] < [pModel2.groupNum integerValue]) {
                    return NSOrderedAscending; //升序
                }else if ([pModel1.groupNum integerValue] > [pModel2.groupNum integerValue]) {
                    return NSOrderedDescending; //降序
                }else {
                    return NSOrderedSame; //相等
                }
            }];
            
            [self setUpBaseUIWithArr:_sortArr];
            
        }else {
            [HZUtils showHUDWithTitle:@"获取失败!"];
        }
        
    } failure:^(NSError *error) {

    }];
}

- (void)setUpBaseUIWithArr:(NSArray *)sortArr {
    CGFloat padding = 5;
    if (kScreenSizeHeight == 480) {
        padding = 4;
    }
    CGFloat itemW = (kScreenSizeWidth - 3*padding)/2;
    CGFloat itemH = (kScreenSizeHeight - 64 - 48 - 4*padding)/7;
    
    CGRect frame = CGRectMake(padding, padding + 64, itemW, itemH*3);
//    [self setUpMaxHWithFrame:frame model:sortArr[5] index:0];
    [self setUpMiddleWithFrame:frame model:sortArr[5] index:0 color:kSetRGBColor(62, 198, 162)];
    CGFloat lastItemY = kScreenSizeHeight - padding - itemH*3 -48;
//    [self setUpMaxHWithFrame:CGRectMake(padding*2 + itemW, lastItemY, itemW, itemH*3) model:sortArr[4] index:5];
    [self setUpMiddleWithFrame:CGRectMake(padding*2 + itemW, lastItemY, itemW, itemH*3) model:sortArr[4] index:5 color:kSetRGBColor(97, 200, 241)];

    [self setUpMiddleWithFrame:CGRectMake(padding, 2*padding + itemH*3 +64, itemW, itemH*2) model:sortArr[3] index:1 color:kSetRGBColor(177, 225, 127)];
    
    [self setUpMiddleWithFrame:CGRectMake(2*padding + itemW, 2*padding + itemH*2 +64, itemW, itemH*2) model:sortArr[2] index:4 color:kSetRGBColor(252, 204, 151)];
    
    [self setUpMiddleWithFrame:CGRectMake(padding, 3*padding + 64 + 5*itemH, itemW, itemH *2) model:sortArr[1] index:2 color:kSetRGBColor(246, 182, 169)];
    
    [self setUpMiddleWithFrame:CGRectMake(padding*2 + itemW, padding + 64, itemW, itemH *2) model:sortArr[0] index:3 color:kSetRGBColor(89, 219, 217)];
    
}

- (void)setUpMaxHWithFrame:(CGRect)frame model:(HomeGroupModel *)model index:(NSInteger)index{
    GroupView *view = [[GroupView alloc] initWithFrame:frame model:model];
    view.backgroundColor = kSetRGBColor(135, 216, 255);
    view.tag = kBaseTag + index;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)]];
    [self.view addSubview:view];
}

- (void)setUpMiddleWithFrame:(CGRect)frame model:(HomeGroupModel *)model index:(NSInteger)index color:(UIColor *)color{
    GroupView *view = [[GroupView alloc] initWithFrame:frame model:model];
    view.backgroundColor = color;
    view.tag = kBaseTag + index;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)]];
    [self.view addSubview:view];
}

- (void)setUpMinWithFrame:(CGRect)frame model:(HomeGroupModel *)model index:(NSInteger)index{
    GroupView *view = [[GroupView alloc] initWithFrame:frame model:model];
    view.backgroundColor = kSetRGBColor(185, 162, 173);
    view.tag = kBaseTag +index;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)]];
    [self.view addSubview:view];
}

- (void)viewTap:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag;
    NSInteger index = tag - kBaseTag;
    HomeGroupModel *model = [[HomeGroupModel alloc] init];
    
    if (index == 0) {
        model = _sortArr[5];
    }else if (index == 1) {
        model = _sortArr[3];
    }else if (index == 2) {
        model = _sortArr[1];
    }else if (index == 3) {
        model = _sortArr[0];
    }else if (index == 4){
        model = _sortArr[2];
    }else if (index == 5) {
        model = _sortArr[4];
    }
    
    HomeDetailViewController *detail = [[HomeDetailViewController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
    
}

//设置导航右按钮
- (void)setUpNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"扫一扫" style:UIBarButtonItemStylePlain target:self action:@selector(scan)];
}

- (void)scan {
    ScanCodeViewController *scan = [[ScanCodeViewController alloc] init];
    [self.navigationController pushViewController:scan animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
