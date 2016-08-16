//
//  HomeDetailCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/12.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "HomeDetailCell.h"
#import "UIView+Utils.h"
#import <UIImageView+WebCache.h>

@implementation HomeDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.iconImageView setRoundWithRadius:25];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(HomeDetailModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"default"]];
    self.nameLabel.text = model.cname;
    self.dateLabel.text = [model.birthday substringToIndex:10];
    self.companyLabel.text = model.companyName;
}

@end
