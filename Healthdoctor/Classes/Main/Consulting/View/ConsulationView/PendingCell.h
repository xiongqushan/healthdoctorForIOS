//
//  PendingCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsulationModel.h"
#import "PendingModel.h"

@interface PendingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cosulationLabel;

- (void)showDataWithModel:(PendingModel *)model;

@end
