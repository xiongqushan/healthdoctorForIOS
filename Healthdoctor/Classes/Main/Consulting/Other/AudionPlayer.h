//
//  AudionPlayer.h
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/8.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudionPlayer : NSObject

+ (instancetype)shareAudioPlayer;

- (void)play;

@end
