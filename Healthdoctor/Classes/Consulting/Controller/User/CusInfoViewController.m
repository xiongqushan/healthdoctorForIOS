//
//  CusInfoViewController.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/7/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "CusInfoViewController.h"
#import "UIColor+Utils.h"
#import "Define.h"
#import "HZAPI.h"
#import "GKNetwork.h"
#import "CustomInfoModel.h"
#import "HZUtils.h"
#import "InfoItemModel.h"
#import "IconItemCell.h"
#import <UIImageView+WebCache.h>
#import "GroupListCell.h"

@interface CusInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *groupIdList;
@property (nonatomic, strong)NSMutableArray *groupList;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, copy)NSString *customerId;

@end

@implementation CusInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.groupList = [NSMutableArray array];
    //[self.groupList addObject:@"高血压组"];
    self.view.backgroundColor = [UIColor viewBackgroundColor];
    self.title = self.cname;
    [self setUpTableView];
    [self loadInfoData];
}

- (void)loadInfoData {
    NSDictionary *param = @{@"customerId":self.customId};
    [[GKNetwork sharedInstance] GetUrl:kGetCusInfoURL param:param completionBlockSuccess:^(id responseObject) {
        
        NSLog(@"________responseObject:%@",responseObject);
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:responseObject[@"message"]];
            return ;
        }
        NSDictionary *dict = responseObject[@"Data"];
        CustomInfoModel *model = [[CustomInfoModel alloc] init];
        if ([dict[@"Gender"] isKindOfClass:[NSNull class]]) {
            model.gender = @"暂无";
        }else if ([dict[@"Gender"] integerValue] == 0) {
            model.gender = @"女";
        }else {
            model.gender = @"男";
        }
        
        model.career = dict[@"Career"];
        
        model.birthday = dict[@"Birthday"];
        NSDate *date = [HZUtils stringToDate:[model.birthday substringToIndex:10]];
        NSTimeInterval dateDiff = 0 - [date timeIntervalSinceNow];
        int age = trunc(dateDiff/(60*60*24))/365;
        model.age = [NSString stringWithFormat:@"%d",age];
        
        model.mobile = dict[@"Mobile"];
        model.certificateCode = dict[@"Certificate_Code"];
        model.companyName = dict[@"Company_Name"];
        model.contactName = dict[@"Contact_Name"];
        model.contactMobile = dict[@"Contact_Mobile"];
        model.Id = dict[@"Id"];
        model.groupList = dict[@"GroupIdList"];
        //保存存放分组Id的可变数组
        self.groupIdList = [NSMutableArray arrayWithArray:model.groupList];
        self.customerId = model.Id;//保存客户Id
        
        for (id groupId in model.groupList) {
            NSString *keyStr = [NSString stringWithFormat:@"%@",groupId];
            NSString *groupName = [[NSUserDefaults standardUserDefaults] objectForKey:keyStr];
            NSLog(@"_____%@",groupName);
            if (groupName) {
                [self.groupList addObject:groupName];
            }
            
        }
        [self initDataWithModel:model];
        
    } failure:^(NSError *error) {
        NSLog(@"_____error:%@",error);
    }];
}

- (void)initDataWithModel:(CustomInfoModel *)model {
    if (!self.photoUrl) {
        self.photoUrl = @"";
    }
    self.dataArr = [NSMutableArray array];
    NSMutableArray *group1 = [NSMutableArray array];
    
    NSArray *key = @[@"头像",@"姓名",@"性别",@"年龄",@"身高"];
    NSArray *value = @[self.photoUrl,self.cname,model.gender,model.age,@"暂无"];
    for (NSInteger i = 0; i < key.count; i++) {
        InfoItemModel *model = [[InfoItemModel alloc] init];
        model.title = key[i];
        model.value = value[i];
        [group1 addObject:model];
    }
    [self.dataArr addObject:group1];
    
    NSMutableArray *group2 = [NSMutableArray array];
    NSArray *key2 = @[@"职业",@"手机号",@"身份证号",@"单位"];
    NSArray *value2 = @[model.career,model.mobile,model.certificateCode,model.companyName];
    for (NSInteger i = 0; i < key2.count; i++) {
        InfoItemModel *model = [[InfoItemModel alloc] init];
        model.title = key2[i];
        model.value = value2[i];
        [group2 addObject:model];
    }
    [self.dataArr addObject:group2];
    
    NSMutableArray *group3 = [NSMutableArray array];
    NSArray *key3 = @[@"第一联系人",@"第一联系人电话"];
    NSArray *value3 = @[model.contactName,model.contactMobile];
    for (NSInteger i = 0; i < key3.count; i++) {
        InfoItemModel *model = [[InfoItemModel alloc] init];
        model.title = key3[i];
        model.value = value3[i];
        [group3 addObject:model];
    }
    [self.dataArr addObject:group3];
    
    [self.tableView reloadData];
}

- (void)setUpTableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenSizeWidth, kScreenSizeHeight - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"IconItemCell" bundle:nil] forCellReuseIdentifier:@"IconItemCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupListCell" bundle:nil] forCellReuseIdentifier:@"GroupListCell"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count +1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return 1;
    }
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0 && indexPath.row == 0) {
        //头像
        IconItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconItemCell"];
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.photoUrl] placeholderImage:[UIImage imageNamed:@"default"]];
        return cell;
    }
    
    if(indexPath.section == 3) {
        GroupListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupListCell"];
        cell.groupList = self.groupList;
        cell.groupIdList = self.groupIdList;
        cell.customerId = self.customerId;
        return cell;
    }
    
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    InfoItemModel *model = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.text = model.title;
    if ([model.value isKindOfClass:[NSNull class]]) {
        model.value = @"暂无";
    }
    cell.detailTextLabel.text = model.value;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 10;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 70;
    }else if (indexPath.section == 3) {
        if (self.groupList.count == 0) {
            return  41 +24;
        }
        NSInteger row = (self.groupList.count - 1)/2 +1;
        return row*41 + (row-1)*10 + 24;
    }else {
        return 44;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
