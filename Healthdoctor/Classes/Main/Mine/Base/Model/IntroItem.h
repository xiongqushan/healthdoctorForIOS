//
//  IntroItem.h
//  Health
//
//  Created by 郭凯 on 16/5/17.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroItem : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *introTitle;

@property (nonatomic, assign)Class destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title introTitle:(NSString *)introTitle;

@end
