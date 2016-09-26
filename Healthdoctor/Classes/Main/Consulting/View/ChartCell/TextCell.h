//
//  TextCell.h
//  Heath
//
//  Created by 郭凯 on 16/4/26.
//  Copyright © 2016年 TY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartModel.h"

typedef void(^MessageClickBlock)(NSString *checkCode,NSString *workNo);

@interface TextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property (weak, nonatomic) IBOutlet UIImageView *leftIconImageView;


@property (nonatomic, copy)MessageClickBlock messageClick;

- (void)showDataWithModel:(ChartModel *)model;
@end
