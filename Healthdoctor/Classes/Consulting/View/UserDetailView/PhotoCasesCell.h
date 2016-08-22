//
//  PhotoCasesCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCasesModel.h"

@protocol PhotoCasesCellDelegate <NSObject>

@optional
- (void)photoCasesDidSelected:(NSIndexPath *)indexPath imageView:(UIImageView *)imageView;

@end

@interface PhotoCasesCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *photoList; //存放PhotoCasesModel 的数组
@property (nonatomic, assign) id<PhotoCasesCellDelegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
