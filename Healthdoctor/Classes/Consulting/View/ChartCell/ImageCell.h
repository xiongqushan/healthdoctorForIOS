//
//  ImageCell.h
//  Heath
//
//  Created by 郭凯 on 16/4/27.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartModel.h"
#import "MSSBrowseDefine.h"

typedef void(^ImageViewClickBlock)(MSSBrowseNetworkViewController *vc);

@interface ImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;

@property (nonatomic, copy) ImageViewClickBlock clickBlock;

- (void)showDataWithModel:(ChartModel *)model;

@end
