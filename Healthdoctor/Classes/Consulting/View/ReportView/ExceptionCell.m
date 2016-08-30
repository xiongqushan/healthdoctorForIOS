//
//  ExceptionCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/25.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ExceptionCell.h"
#import "UIView+Utils.h"

@implementation ExceptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImage *image = [UIImage imageNamed:@"cellBg2"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 50, 10, 50) resizingMode:UIImageResizingModeStretch];
    self.bgImageView.image = image;
    
    [self.pointView setRoundWithRadius:4.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(ResultModel *)model {
    if ([model.resultTypeID integerValue] == 1) {
        //数值类型
        self.valueLabel.hidden = NO;
        self.unitLabel.hidden = NO;
        self.lineLabel.hidden = NO;
        
        self.refLabel.text = [NSString stringWithFormat:@"参考范围:%@",model.textRef];
        self.nameLabel.text = model.checkIndexName;
        self.valueLabel.text = model.resultValue;
        self.unitLabel.text = [NSString stringWithFormat:@"单位:%@",model.unit];
    }else {
    
        self.valueLabel.hidden = YES;
        self.unitLabel.hidden = YES;
        self.lineLabel.hidden = YES;
        
        self.refLabel.text = model.resultValue;
        self.nameLabel.text = model.checkIndexName;
    }

}

@end
