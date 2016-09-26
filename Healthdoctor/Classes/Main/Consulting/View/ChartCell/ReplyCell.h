//
//  ReplyCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/21.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartModel.h"

@interface ReplyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bubblesImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)showDataWithModel:(ChartModel *)model;

@end
