//
//  DetailViewController.m
//  FENotification
//
//  Created by keso on 2017/7/18.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import "DetailViewController.h"
#import "FENotificationCenter.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self postNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"Dealloc---%@",NSStringFromClass([self class]));
}


- (void)postNotification {
 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateData" object:@{@"age":@"27"} userInfo:@{@"name":@"FlyElephant"}];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateDataNil" object:nil userInfo:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateData4" object:nil];
    });
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateData4" object:nil];
    
    
    
//    [[FENotificationCenter defaultCenter] postNotificationName:@"updateData" object:@{@"name":@"FlyElephant"}];
    [[FENotificationCenter defaultCenter] postNotificationName:@"updateData1" object:@{@"age":@"27"} userInfo:@{@"name":@"FlyElephant"}];
    
    [[FENotificationCenter defaultCenter] postNotificationName:@"updateData3" object:nil];
    NSLog(@"通知执行完成");
}



@end
