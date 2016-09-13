//
//  IntroCell.h
//  Health
//
//  Created by 郭凯 on 16/5/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroItem.h"

@interface IntroCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)IntroItem *item;

@end
