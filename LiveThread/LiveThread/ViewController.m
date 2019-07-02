//
//  ViewController.m
//  LiveThread
//
//  Created by zhang zhengbin on 2019/7/2.
//  Copyright © 2019 zhang zhengbin. All rights reserved.
//

#import "ViewController.h"
#import "ZThread/ZThread.h"

@interface ViewController ()

/** <#property desc#>*/
@property (nonatomic,strong)ZThread * thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.thread = [[ZThread alloc] init];
    [self.thread run];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.thread executeTaskWithBlock:^{
        NSLog(@"test %s",__func__);
    }];
}

- (IBAction)clickStop:(id)sender {
    [self.thread stop];
    
}



- (void)dealloc
{
    NSLog(@"%s",__func__);
    [self.thread stop];
}
@end
