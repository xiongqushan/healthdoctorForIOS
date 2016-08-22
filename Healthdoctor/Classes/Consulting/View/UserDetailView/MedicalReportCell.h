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

- (void)showDataWithModel:(MedicalReportModel *)model;

@end
