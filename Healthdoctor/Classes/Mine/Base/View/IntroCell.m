//
//  IntroCell.m
//  Health
//
//  Created by 郭凯 on 16/5/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "IntroCell.h"
#import "Define.h"

@implementation IntroCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"CellId";
    IntroCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(IntroItem *)item {
    _item = item;
    [self setUpData];
}

- (void)setUpData {
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.introTitle;
    self.detailTextLabel.numberOfLines = 0;
    self.detailTextLabel.font = [UIFont systemFontOfSize:15];
    self.detailTextLabel.textColor = kSetRGBColor(51, 51, 51);
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
