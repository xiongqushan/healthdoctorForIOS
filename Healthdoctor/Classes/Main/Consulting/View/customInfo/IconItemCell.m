//
//  IconItemCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/7/11.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "IconItemCell.h"
#import "UIView+Utils.h"

@implementation IconItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.iconImageView setRoundWithRadius:25];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
