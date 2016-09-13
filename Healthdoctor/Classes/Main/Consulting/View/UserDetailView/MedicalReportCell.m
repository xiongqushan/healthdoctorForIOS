//
//  MedicalReportCell.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "MedicalReportCell.h"

@interface MedicalReportCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkCenter;
@property (weak, nonatomic) IBOutlet UILabel *checkDate;
@property (weak, nonatomic) IBOutlet UILabel *checkNum;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

@end

@implementation MedicalReportCell

- (void)showDataWithModel:(MedicalReportModel *)model {
    self.nameLabel.text = model.customerName;
    self.genderLabel.text = model.gender;
    self.ageLabel.text = model.age;
    self.checkCenter.text = model.checkUnitName;
    self.checkDate.text = [NSString stringWithFormat:@"%@-%@-%@",[model.checkDate substringToIndex:4],[model.checkDate substringWithRange:NSMakeRange(4, 2)],[model.checkDate substringWithRange:NSMakeRange(6, 2)]];
    self.checkNum.text = model.workNo;
    self.companyLabel.text = model.company;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
