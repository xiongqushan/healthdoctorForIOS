//
//  ReportItemCell.h
//  ReportTableViewDemo
//
//  Created by 郭凯 on 16/6/1.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultModel.h"

@interface ReportItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *checkIndexNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *refLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

- (void)showDataWithModel:(ResultModel *)model isExceptionsView:(BOOL)isExceptions;

@end
