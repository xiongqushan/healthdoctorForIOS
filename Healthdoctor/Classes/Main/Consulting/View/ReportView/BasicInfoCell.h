//
//  BasicInfoCell.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/8/25.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIView *pointView;

@end
