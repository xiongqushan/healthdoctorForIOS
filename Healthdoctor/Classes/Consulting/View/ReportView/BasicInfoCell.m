//
//  BasicInfoCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/25.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "BasicInfoCell.h"
#import "UIView+Utils.h"

@implementation BasicInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.pointView setRoundWithRadius:4.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
