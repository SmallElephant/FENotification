//
//  FENotificationCenter.m
//  FENotification
//
//  Created by keso on 2017/7/16.
//  Copyright © 2017年 FlyElephant. All rights reserved.
//

#import "FENotificationCenter.h"

typedef void(^OperationBlock)(FENotification *notification);

@interface  FENotificationModel: NSObject

@property (strong, nonatomic) id observer;

@property (assign, nonatomic) SEL sel;

@property (copy, nonatomic) NSString *notificationName;

@property (strong, nonatomic) id object;

@property (strong, nonatomic) NSOperationQueue *operationQueue;

@property (copy, nonatomic) OperationBlock block;

@end

@implementation FENotificationModel


@end



@interface FENotificationCenter()



@end

@implementation FENotificationCenter

#pragma mark - LifeCycle

+ (FENotificationCenter *)defaultCenter {
    static FENotificationCenter *sharedCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCenter = [[FENotificationCenter alloc] init];
    });
    return sharedCenter;
}

#pragma mark - Accessors

- (NSMutableDictionary *)observerDict {
    if (!_observerDict) {
        _observerDict = [[NSMutableDictionary alloc] init];
    }
    return _observerDict;
}


#pragma mark - Public

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject {
    
    FENotificationModel *model = [[FENotificationModel alloc] init];
    model.observer = observer;
    model.sel = aSelector;
    model.notificationName = aName;
    model.object = anObject;
    
    NSMutableArray *value = [self.observerDict objectForKey:aName];
    if ([value count]) {
        [value addObject:model];
    } else {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:model];
        self.observerDict[aName] = arr;
    }
}

- (id<NSObject>)addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(FENotification *))block {
    
    FENotificationModel *model = [[FENotificationModel alloc] init];

    model.notificationName = name;
    model.operationQueue = queue;
    model.block = block;
    
    NSMutableArray *value = [self.observerDict objectForKey:name];
    if ([value count]) {
        [value addObject:model];
    } else {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject:model];
        self.observerDict[name] = arr;
    }
    return nil;
}

- (void)postNotification:(NSString *)notification {
    [self postNotificationName:notification object:nil];
}

- (void)postNotificationName:(NSString *)aName object:(id)anObject {
    [self postNotificationName:aName object:anObject userInfo:nil];
}

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    NSMutableArray *value = self.observerDict[aName];
    if ([value count]) {
        
        for (FENotificationModel *model in value) {
            
            if (model.operationQueue) {
                NSOperationQueue *queue = model.operationQueue;
                NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
                    FENotification *notification = [FENotification new];
                    notification.name = model.notificationName;
                    model.block(notification);
                }];
                [queue addOperation:blockOperation];
                
            } else {
                id observer = model.observer;
                SEL sel = model.sel;
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                
                FENotification *notification = [FENotification new];
                notification.name = aName;
                notification.object = anObject;
                notification.userInfo = aUserInfo;
                [observer performSelector:sel withObject:notification];
            }
        }
    }
}

- (void)removeObserver:(id)observer {
    
    for (NSString *key in [self.observerDict allKeys]) {
        
        NSMutableArray *data = self.observerDict[key];
        NSMutableArray *newData = [NSMutableArray new];
        for (NSInteger i=0; i < [data count]; i++) {
            FENotificationModel *model = data[i];
            if (model.observer != observer) {
                [newData addObject:model];
            }
        }
        
        if ([newData count] == 0) {
            [self.observerDict removeObjectForKey:key];
        } else {
            self.observerDict[key] = newData;
        }
    }
}

- (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject {
    for (NSString *key in [self.observerDict allKeys]) {
        if (key == aName) {
            NSMutableArray *data = self.observerDict[key];
            NSMutableArray *newData = [NSMutableArray new];
            for (NSInteger i=0; i < [data count]; i++) {
                FENotificationModel *model = data[i];
                if (model.observer != observer) {
                    [newData addObject:model];
                }
            }
           
            if ([newData count] == 0) {
                [self.observerDict removeObjectForKey:key];
            } else {
                self.observerDict[key] = newData;
            }
        }
    }
}


@end
