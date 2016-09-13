//
//  GroupView.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/6/7.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "GroupView.h"
#import "Define.h"

@implementation GroupView
{
    HomeGroupModel *_model;
    NSInteger _index;
}

- (instancetype)initWithFrame:(CGRect)frame model:(HomeGroupModel *)model {
    if (self = [super initWithFrame:frame]) {
        _model = model;
        //_index = index;
        [self setUpBaseUI];
    }
    return self;
}

- (void)setUpBaseUI {
    
    CGFloat fontSize = 17;
    CGFloat smallFont = 15;
    CGFloat centerOff = 10;

    self.backgroundColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
    label.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 - 10);
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:fontSize];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = _model.name;
    [self addSubview:label];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
    countLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 + centerOff);
    countLabel.numberOfLines = 0;
    countLabel.textColor = [UIColor whiteColor];
    countLabel.text = [NSString stringWithFormat:@"服务人数:%@",_model.doctorNum];
    countLabel.font = [UIFont boldSystemFontOfSize:smallFont];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:countLabel];
}

@end
