//
//  IntroItem.m
//  Health
//
//  Created by 郭凯 on 16/5/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "IntroItem.h"

@implementation IntroItem

+ (instancetype)itemWithTitle:(NSString *)title introTitle:(NSString *)introTitle {
    IntroItem *item = [[self alloc] init];
    item.title = title;
    item.introTitle = introTitle;
    
    return item;
}

@end
