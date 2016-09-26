//
//  MedicalReportCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicalReportModel.h"

@interface MedicalReportCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkCenter;
@property (weak, nonatomic) IBOutlet UILabel *checkDate;
@property (weak, nonatomic) IBOutlet UILabel *checkNum;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

- (void)showDataWithModel:(MedicalReportModel *)model;

@end
