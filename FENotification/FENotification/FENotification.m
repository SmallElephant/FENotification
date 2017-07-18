//
//  FENotification.m
//  FENotification
//
//  Created by keso on 2017/7/18.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import "FENotification.h"

@implementation FENotification

- (NSString *)description {
    return [NSString stringWithFormat:@"{name = %@; object = %@; userInfo = %@}",self.name,self.object,self.userInfo];
}

@end
