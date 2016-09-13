//
//  AudionPlayer.m
//  Healthdoctor
//
//  Created by 郭凯 on 16/9/8.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import "AudionPlayer.h"
#import <AVFoundation/AVFoundation.h>

@implementation AudionPlayer
{
    AVAudioPlayer *_player;
}

+ (instancetype)shareAudioPlayer {
    
    static AudionPlayer *audioPlayer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioPlayer = [[self alloc] init];
    });
    
    return audioPlayer;
}

- (instancetype)init {
    
    if (self = [super init]) {
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"pull_refresh.caf" ofType:nil];
        NSURL *soundUrl = [[NSURL alloc] initFileURLWithPath:soundPath];
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
        [_player prepareToPlay];
    }
    return self;
}

- (void)play {
    [_player play];
}

@end
