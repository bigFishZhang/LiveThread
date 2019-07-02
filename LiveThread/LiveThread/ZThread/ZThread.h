//
//  ZThread.h
//  LiveThread
//
//  Created by zhang zhengbin on 2019/7/2.
//  Copyright © 2019 zhang zhengbin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^executeTaskBlock) (void);

@interface ZThread : NSObject

/**
 开启线程
 */
- (void)run;


/**
 执行任务（在当前线程中） Block

 @param block Block
 */
- (void)executeTaskWithBlock:(executeTaskBlock)block;

/**
 结束线程
 */
- (void)stop;

@end


