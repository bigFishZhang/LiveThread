//
//  ZThread.m
//  LiveThread
//
//  Created by zhang zhengbin on 2019/7/2.
//  Copyright © 2019 zhang zhengbin. All rights reserved.
//

#import "ZThread.h"

/**
 permanent Thread
 */
@interface PThread :NSThread
@end
@implementation PThread

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end


@interface ZThread()

/** 内部线程*/
@property (nonatomic,strong)PThread * pThread;
/** 线程是否停止*/
@property (nonatomic,assign,getter=isStoped) BOOL stopped;
@end


@implementation ZThread

#pragma mark ---public---
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stopped = NO;
        __weak typeof(self)weakSelf = self;
        self.pThread = [[PThread alloc] initWithBlock:^{
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            
            while (weakSelf && !weakSelf.isStoped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
    }
    return self;
}

/**
  执行任务（在当前线程中） Block
 
 @param block Block
 */
- (void)executeTaskWithBlock:(executeTaskBlock)block {
    if (!self.pThread || !block) return;
    [self performSelector:@selector(tast:) onThread:self.pThread withObject:block waitUntilDone:NO];
    
}

/**
 开启线程
 */
- (void)run {
    if (!self.pThread) return;
    
    [self.pThread start];
}

/**
 结束线程
 */
- (void)stop {
    if (!self.pThread) return;
    [self performSelector:@selector(stopPthread) onThread:self.pThread withObject:nil waitUntilDone:YES];
}


#pragma mark ---private---
/**
 停止线程
 */
- (void)stopPthread {
    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.pThread = nil;
}

/**
 任务
 */
- (void)tast:(executeTaskBlock)block {
    block();
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
