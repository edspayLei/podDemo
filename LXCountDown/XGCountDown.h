//
//  XGCountDown.h
//  XGCredit
//
//  Created by shawn on 2018/7/24.
//  Copyright © 2018年 Aladin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGCountDown : NSObject
// 需要倒计时的秒数,completeBlock 已在主线程
- (void)countDownWithFinalSeconds:(NSInteger)seconds completeBlock:(void (^)(NSInteger second))completeBlock;

- (void)destoryTimer;
@end
