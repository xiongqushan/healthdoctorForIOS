//
//  GroupListCollectionViewCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/7/12.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "GroupListCollectionViewCell.h"

@implementation GroupListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImage *image = [UIImage imageNamed:@"backgroundImage"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 30, 10, 30) resizingMode:UIImageResizingModeStretch];
    self.backgroundImageView.image = image;
}

@end
