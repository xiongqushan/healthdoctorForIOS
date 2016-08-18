//
//  PendingCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "PendingCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+Utils.h"
#import "HZUtils.h"

@implementation PendingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)showDataWithModel:(PendingModel *)model {
    [self.iconImageView setRoundWithRadius:25];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.photoUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    self.nameLabel.text = model.custName;
    NSString *date = [model.commitOn stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    self.dateLabel.text = [HZUtils getDetailDateStrWithDate:date];
    self.cosulationLabel.text = model.consultTitele;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
