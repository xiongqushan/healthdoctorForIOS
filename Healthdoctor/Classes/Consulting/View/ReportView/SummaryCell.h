//
//  SummaryCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummarysModel.h"

@interface SummaryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLabelH;
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLabelY;

- (void)showDataWithModel:(SummarysModel *)model;

@end
