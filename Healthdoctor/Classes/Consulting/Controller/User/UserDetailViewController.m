//
//  UserDetailViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/16.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UIView+Utils.h"
#import "Define.h"
#import "MedicalReportCell.h"
#import "PhotoCasesCell.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "HZUtils.h"
#import "MedicalReportModel.h"
#import "PhotoCasesModel.h"
#import "SectionHeaderView.h"
#import "UIColor+Utils.h"
#import "CusInfoViewController.h"
#import <UIImageView+WebCache.h>
#import "ChartBaseViewController.h"
#import "ReportDetailViewController.h"
#import "MSSBrowseDefine.h"

@class HomeViewController;

@interface UserDetailViewController ()<UITableViewDelegate,UITableViewDataSource,PhotoCasesCellDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;  //存放导航控件的view
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *medicalDataArr;  //存放MedicalReportModel
@property (nonatomic, strong) NSMutableArray *photoDataArr;  //存放PhotoCasesModel

@end

@implementation UserDetailViewController
{
    BOOL _isMedicalReportOpend;
    BOOL _isPhotoCasesOpend;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isPhotoCasesOpend = YES;
    _isMedicalReportOpend = YES;
    
    [self loadReportData]; //获取体检报告数据
    [self loadPhotoCasesData]; //获取照片病例数据
    [self setUpBaseUI];

}

- (void)bgImageViewClick {
    //跳转客户详细资料
    NSLog(@"______push!");
    CusInfoViewController *custom = [[CusInfoViewController alloc] init];
    custom.customId = self.custID;
    custom.cname = self.cname;
    custom.photoUrl = self.photoUrl;
    [self.navigationController pushViewController:custom animated:YES];
}

- (void)consulationClick {
    //咨询按钮被点击
    NSLog(@"______pop!");
    NSArray *controllers = self.navigationController.viewControllers;
    NSInteger count = controllers.count;
    UIViewController *controller = controllers[count - 2];
    if ([controller isKindOfClass:[ChartBaseViewController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
        
        ChartBaseViewController *chart = [[ChartBaseViewController alloc] init];
        chart.customId = self.custID;
        chart.customName = self.cname;
        chart.photoUrl = self.photoUrl;
        [self.navigationController pushViewController:chart animated:YES];
    }
    
}

- (void)setUpBaseUI {
    
    [self.iconImageView setRoundWithRadius:30];
    UIImage *image = [UIImage imageNamed:@"headerBg"];
    self.bgImageView.image = image;
    self.bgImageView.userInteractionEnabled = YES;
    [self.bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgImageViewClick)]];
    self.nameLabel.text = self.cname;
    self.genderLabel.text = [HZUtils getGender:self.gender];
    self.ageLabel.text = [HZUtils getAgeWithBirthday:self.birthday];
    self.phoneLabel.text = self.mobile;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.photoUrl] placeholderImage:[UIImage imageNamed:@"default"]];
    
    //添加导航栏子控件
    self.navigationItem.title = @"客户详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"咨询" style:UIBarButtonItemStylePlain target:self action:@selector(consulationClick)];
    
    //创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 151, kScreenSizeWidth, kScreenSizeHeight - 151) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor viewBackgroundColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.sectionHeaderHeight = 45;
    [tableView registerNib:[UINib nibWithNibName:@"MedicalReportCell" bundle:nil] forCellReuseIdentifier:@"MedicalReportCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

//获取体检报告网络数据
- (void)loadReportData {
    
    //_seletedIndex = 0;
    // 40210
    self.medicalDataArr = [NSMutableArray array];
    NSDictionary *param = @{@"customerId":self.custID};
    [[GKNetwork sharedInstance] GetUrl:kGetReportListURL param:param completionBlockSuccess:^(id responseObject) {
        [self.medicalDataArr removeAllObjects];
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:responseObject[@"message"]];
            [self.tableView reloadData];
            return;
        }

        if ([responseObject[@"Data"] isKindOfClass:[NSNull class]]) {
            
            [HZUtils showHUDWithTitle:@"没有体检报告。"];
          //  _isMedicalReportOpend = NO;
            [self.tableView reloadData];
            return;
        }
        NSArray *data = responseObject[@"Data"];
        //_isMedicalReportOpend = YES;
        for (NSDictionary *dict in data) {
            MedicalReportModel *model = [[MedicalReportModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.gender = self.genderLabel.text;
            model.age = self.ageLabel.text;
            model.company = @"暂无";
            [self.medicalDataArr addObject:model];
        }
    //    [self setUpBaseUI];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

//获取照片病例网络数据
- (void)loadPhotoCasesData {
    
    self.photoDataArr = [NSMutableArray array];
    
    NSDictionary *param = @{@"accountID":self.accountID};
    [[GKNetwork sharedInstance] GetUrl:kReportPhotoListURL param:param completionBlockSuccess:^(id responseObject) {
        
        [self.photoDataArr removeAllObjects];
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
            PhotoCasesModel *model = [[PhotoCasesModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            
            [self.photoDataArr addObject:model];
        }
        
       // [self setUpBaseUI];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark -- PhotoCasesCellDelegate
- (void)photoCasesDidSelected:(NSIndexPath *)indexPath imageView:(UIImageView *)imageView{
    
    PhotoCasesModel *model = self.photoDataArr[indexPath.row];
    NSArray *images = model.imageUrlList;
    
    NSMutableArray *imageArr = [NSMutableArray array];
    for (NSInteger i = 0; i < images.count; i++) {
        MSSBrowseModel *model = [[MSSBrowseModel alloc] init];
        model.bigImageUrl = images[i];
        model.smallImageView = imageView;
        [imageArr addObject:model];
    }
    
    MSSBrowseNetworkViewController *vc = [[MSSBrowseNetworkViewController alloc] initWithBrowseItemArray:imageArr currentIndex:0];
    [vc showBrowseViewController:self];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return _isMedicalReportOpend ? self.medicalDataArr.count : 0;
    }else {
        return _isPhotoCasesOpend ? 1 : 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MedicalReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MedicalReportCell"];
        [cell showDataWithModel:self.medicalDataArr[indexPath.row]];
        return cell;
    }else {
        PhotoCasesCell *cell = [PhotoCasesCell cellWithTableView:tableView];
        cell.delegate = self;
        if (!self.photoDataArr.count) {
            return cell;
        }
        cell.photoList = self.photoDataArr;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        __weak SectionHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"SectionHeaderView" owner:self options:0] lastObject];
        view.frame = CGRectMake(0, 0, kScreenSizeWidth, 45);
        view.isOpend = _isMedicalReportOpend;
        [view initBaseUI];
        view.titleLabel.text = @"体检报告";
        view.didClickBlock = ^() {

            _isMedicalReportOpend = !_isMedicalReportOpend;
            [self.tableView reloadData];
        };
        [view.updateBtn setRound];
        return view;
        
    }else {
        __weak SectionHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"SectionHeaderView" owner:self options:0] lastObject];
        view.frame = CGRectMake(0, 0, kScreenSizeWidth, 45);
        view.isOpend = _isPhotoCasesOpend;
        [view initBaseUI];
        view.titleLabel.text = @"照片病例";
        view.updateBtn.hidden = YES;
        view.didClickBlock = ^() {
            
            _isPhotoCasesOpend = !_isPhotoCasesOpend;
            [self.tableView reloadData];
        };
        
        return view;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 166;
    }else {
        if (!self.photoDataArr.count) {
            return 1;
        }
        NSInteger row = (self.photoDataArr.count-1)/3 + 1;
        CGFloat photoItemW = (kScreenSizeWidth - 4*10)/3;
        CGFloat photoItemH = photoItemW*0.8 + 50;
        return row * (photoItemH + 10);
        //return 200;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MedicalReportModel *model = self.medicalDataArr[indexPath.row];
    ReportDetailViewController *detail = [[ReportDetailViewController alloc] init];
    detail.checkCode = model.checkUnitCode;
    detail.workNum = model.workNo;
    detail.custId = self.custID;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
