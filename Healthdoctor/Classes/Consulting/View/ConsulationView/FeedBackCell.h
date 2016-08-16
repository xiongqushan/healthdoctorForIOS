//
//  FeedBackCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/2.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarLevelView.h"
#import "FeedbackModel.h"

@interface FeedBackCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet StarLevelView *starView;
@property (weak, nonatomic) IBOutlet UILabel *doctorName;
@property (weak, nonatomic) IBOutlet UILabel *consulationLabel;

- (void)showDataWithModel:(FeedbackModel*)model;

@end
