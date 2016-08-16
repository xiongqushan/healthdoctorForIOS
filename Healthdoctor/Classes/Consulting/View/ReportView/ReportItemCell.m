//
//  ReportItemCell.m
//  ReportTableViewDemo
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "ReportItemCell.h"

@implementation ReportItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(ResultModel *)model {

    self.checkIndexNameLabel.text = model.checkIndexName;
    self.valueLabel.text = model.resultValue;
    
    if (model.textRef.length > 0) {
        self.refLabel.text = [NSString stringWithFormat:@"参考范围:%@",model.textRef];
    }else {
        self.refLabel.text = model.textRef;
    }
    
    if (model.unit.length > 0) {
        self.unitLabel.text = [NSString stringWithFormat:@"单位:%@",model.unit];
    }else {
        self.unitLabel.text = model.unit;
    }
}

@end
