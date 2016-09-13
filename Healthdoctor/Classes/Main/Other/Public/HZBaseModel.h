//
//  HZBaseModel.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/5/25.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZBaseModel : NSObject

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (id)valueForKey:(NSString *)key;

@end
