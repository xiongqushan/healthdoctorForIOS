//
//  FeedBackCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/2.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "FeedBackCell.h"
#import "UIView+Utils.h"
#import <UIImageView+WebCache.h>
#import "HZUtils.h"

@implementation FeedBackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.iconImageView setRoundWithRadius:25];
}

- (void)showDataWithModel:(FeedbackModel *)model {
  //  FeedbackModel *newModel = (FeedbackModel *)model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"default"]];
    self.nameLabel.text = model.custName;
    NSString *date = [model.commitOn stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    self.dateLabel.text = [HZUtils getDetailDateStrWithDate:date];
    //设置星级
    //[self.starView setStarLevel:[model.score doubleValue]];
    if (!model.reDoctor) {
        self.doctorName.hidden = YES;
    }else {
        self.doctorName.hidden = NO;
    }
    //self.doctorName.text = [NSString stringWithFormat:@"健管师:%@",model.reDoctor];
    self.doctorName.text = model.reDoctor;
    self.consulationLabel.text = model.consultTitele;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
