//
//  GKRecognizer.h
//  CustomUIDemo
//
//  Created by 郭凯 on 16/8/8.
//  Copyright © 2016年 guokai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyMSC.h"

@interface GKRecognizer : NSObject <IFlySpeechRecognizerDelegate>
{
    IFlySpeechRecognizer *_iFlySpeechRecognizer;
}

@property (nonatomic, copy)void(^onResult)(NSString *result);

+ (instancetype)shareManager;

- (void)starRecognizerResult:(void(^)(NSString *result))onResult;

- (void)stopRecognizer;

@end
