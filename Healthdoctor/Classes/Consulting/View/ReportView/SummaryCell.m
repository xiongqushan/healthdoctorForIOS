//
//  SummaryCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/24.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "SummaryCell.h"

@implementation SummaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *image = [UIImage imageNamed:@"cellBg2"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 50, 10, 50) resizingMode:UIImageResizingModeStretch];
    self.cellImageView.image = image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
