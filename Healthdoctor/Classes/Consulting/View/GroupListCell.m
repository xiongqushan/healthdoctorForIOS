//
//  GroupListCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/7/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "GroupListCell.h"
#import "Define.h"
#import "GroupListCollectionViewCell.h"
#import "HZUtils.h"
#import "GKNetwork.h"
#import "HZAPI.h"
#import "HZUser.h"
#import "Config.h"

@implementation GroupListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setGroupList:(NSMutableArray *)groupList {
    _groupList = groupList;
    [self setUpCollectionView];
}

- (void)setUpCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
   
    if (self.groupList.count == 0) {
        return;
    }
    NSInteger row = (self.groupList.count - 1)/2 +1;
    CGFloat collectionViewH = row*41 + (row-1)*10;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenSizeWidth - 80, collectionViewH) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //[collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [collectionView registerNib:[UINib nibWithNibName:@"GroupListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GroupListCollectionViewCell"];
    [self.itemsView addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.groupList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    GroupListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupListCollectionViewCell" forIndexPath:indexPath];
    cell.groupNameLabel.text = self.groupList[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"______name:%@",self.groupList[indexPath.row]);
    HZUser *user = [Config getProfile];
    NSDictionary *param = @{@"customerId":self.customerId,@"curGroupId":self.groupIdList[indexPath.row],@"operateBy":user.name};
    [[GKNetwork sharedInstance] GetUrl:kDeleteGroupURL param:param completionBlockSuccess:^(id responseObject) {
        
        NSLog(@"_____responseObject:%@",responseObject);
        if ([responseObject[@"state"] integerValue] != 1) {
            [HZUtils showHUDWithTitle:@"删除分组失败！"];
            return ;
        }
        
        [self.groupList removeObjectAtIndex:indexPath.row];
        [collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"______error:%@",error);
    }];

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [HZUtils getWidthWithFont:[UIFont systemFontOfSize:17] text:self.groupList[indexPath.row] maxHeight:21].width;
    CGSize size = CGSizeMake(width + 47, 41);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
