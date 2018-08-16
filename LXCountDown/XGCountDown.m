//
//  XGCountDown.m
//  XGCredit
//
//  Created by shawn on 2018/7/24.
//  Copyright © 2018年 Aladin. All rights reserved.
//

#import "XGCountDown.h"

@interface XGCountDown ()

@property(nonatomic,retain) dispatch_source_t timer;

@end

@implementation XGCountDown

-(void)countDownWithFinalSeconds:(NSInteger)seconds completeBlock:(void (^)(NSInteger second))completeBlock {
    if (_timer==nil) {
        __block int timeout = (int)seconds; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
//                    dispatch_source_cancel(_timer);
//                    _timer = nil;
                    [self destoryTimer];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0);
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(timeout);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

/**
 *  主动销毁定时器
 */
-(void)destoryTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end
