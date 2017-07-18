//
//  FENotification.h
//  FENotification
//
//  Created by keso on 2017/7/18.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FENotification : NSObject

@property (copy, nonatomic) NSString *name;

@property (strong, nonatomic) id object;

@property (copy, nonatomic) NSDictionary *userInfo;

@end
