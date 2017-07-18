//
//  FENotificationCenter.h
//  FENotification
//
//  Created by keso on 2017/7/16.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FENotification.h"

@interface FENotificationCenter : NSObject

@property (class, readonly, strong) FENotificationCenter *defaultCenter;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(nullable id)anObject;

- (void)postNotification:(NSString *)notification;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject;

- (id <NSObject>)addObserverForName:(nullable NSString *)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(FENotification *note))block NS_AVAILABLE(10_6, 4_0);
// The return value is retained by the system, and should be held onto by the caller in
// order to remove the observer with removeObserver: later, to stop observation.

@property (strong, nonatomic) NSMutableDictionary  *observerDict;

@end
