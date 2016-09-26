//
//  ReplyCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/21.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReplyCell.h"
#import "HZUtils.h"
#import "UIView+Utils.h"
#import "HZUser.h"
#import "Config.h"
#import <UIImageView+WebCache.h>

@implementation ReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)showDataWithModel:(ChartModel *)model {
    
    NSString *date = [model.commitOn stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    self.dateLabel.text = [HZUtils getDetailDateStrWithDate:date];//将日期格式化
    
    HZUser *user = [Config getProfile];
    [self.iconImageView setRoundWithRadius:25];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.photoUrl] placeholderImage:[UIImage imageNamed:@"default"]];
    
    self.contentLabel.text = model.content;
    UIImage *image = [UIImage imageNamed:@"chat_icon_bubble_min_outgoing"];
    self.bubblesImage.image = [image stretchableImageWithLeftCapWidth:21 topCapHeight:30];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
