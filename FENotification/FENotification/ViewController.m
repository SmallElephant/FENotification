//
//  ViewController.m
//  FENotification
//
//  Created by keso on 2017/7/16.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import "ViewController.h"
#import "FENotificationCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"Dealloc---%@",NSStringFromClass([self class]));
}

- (IBAction)postNotification:(UIButton *)sender {
//    NSLog(@"发送开始时间:%@",[NSDate date]);
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateData5" object:nil];
//    NSLog(@"updateData5通知结束");
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSLog(@"发送开始时间:%@",[NSDate date]);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateData5" object:nil];
//    });
//    NSLog(@"updateData5通知结束");
    
    NSLog(@"发送开始时间:%@",[NSDate date]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateData6" object:nil];
    NSLog(@"updateData5通知结束");
}

- (IBAction)postEqueueAction:(UIButton *)sender {
    
    NSNotification *myNotification = [NSNotification notificationWithName:@"updateData6" object:nil];
    [[NSNotificationQueue defaultQueue] enqueueNotification:myNotification postingStyle:NSPostWhenIdle coalesceMask:NSNotificationCoalescingOnName forModes:nil];
    NSLog(@"NSNotificationQueue---通知结束");
}

- (IBAction)removeAction:(UIButton *)sender {
    
    [[FENotificationCenter defaultCenter] removeObserver:self];
    
    FENotificationCenter *center = [FENotificationCenter defaultCenter];
    NSLog(@"移除通知字典:%@",center.observerDict);
}


- (void)setup {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData1:) name:@"updateData" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData2:) name:@"updateData" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData3:) name:@"updateDataNil" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData4:) name:@"updateData4" object:nil];
    
//    dispatch_queue_t queue = dispatch_queue_create("com.flyelephant.www", nil);
//    
//    dispatch_async(queue, ^{
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData5:) name:@"updateData5" object:nil];
//    });

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData5:) name:@"updateData5" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateData6:) name:@"updateData6" object:nil];
    
    
    [[FENotificationCenter defaultCenter] addObserver:self selector:@selector(testData1:) name:@"updateData1" object:nil];
    [[FENotificationCenter defaultCenter] addObserver:self selector:@selector(testData2:) name:@"updateData2" object:nil];
    [[FENotificationCenter defaultCenter] addObserverForName:@"updateData3" object:nil queue:[NSOperationQueue new] usingBlock:^(FENotification *note) {
        NSLog(@"Block通知回调成功");
    }];
    
    [[FENotificationCenter defaultCenter] addObserver:self selector:@selector(testData3:) name:@"updateData1" object:nil];
    
    FENotificationCenter *center = [FENotificationCenter defaultCenter];
    NSLog(@"通知字典:%@",center.observerDict);
    
}

- (void)updateData1:(NSNotification *)notificaton {
    NSLog(@"收到通知1---%@",notificaton);
}

- (void)updateData2:(NSNotification *)notificaton {
    NSLog(@"收到通知2---%@",notificaton);
}

- (void)updateData3:(NSNotification *)notificaton {
    NSLog(@"收到通知3---%@",notificaton);
}

- (void)updateData4:(NSNotification *)notificaton {
    sleep(3);
    NSLog(@"收到通知4---%@",notificaton);
}

- (void)updateData5:(NSNotification *)notificaton {
//    NSLog(@"update5收到通知时间:%@",[NSDate date]);
//    sleep(2);
//    NSLog(@"收到通知5---%@",notificaton);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"update5收到通知时间:%@",[NSDate date]);
        sleep(2);
        NSLog(@"收到通知5---%@",notificaton);
    });
}

- (void)updateData6:(NSNotification *)notificaton {
    sleep(2);
    NSLog(@"NSNotificationQueue收到通知6---%@",notificaton);
}


- (void)testData1:(FENotification *)notificaton {
    NSLog(@"自定义收到通知1---%@",notificaton);
}

- (void)testData2:(FENotification *)notificaton {
    NSLog(@"自定义收到通知2---%@",notificaton);
}

- (void)testData3:(FENotification *)notificaton {
    NSLog(@"自定义收到通知3---%@",notificaton);
}

@end
