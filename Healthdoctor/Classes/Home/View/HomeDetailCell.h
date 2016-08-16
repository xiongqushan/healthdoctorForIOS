//
//  HomeDetailCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/12.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDetailModel.h"

@interface HomeDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

- (void)showDataWithModel:(HomeDetailModel*)model;

@end
