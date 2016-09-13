//
//  GroupListCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/7/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupListCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *itemsView;
@property (nonatomic, strong)NSMutableArray *groupList; //存放分组名字可变数组
@property (nonatomic, copy)NSString *customerId;//存放客户ID
@property (nonatomic, strong)NSMutableArray *groupIdList;//存放分组ID可变数组

@end
