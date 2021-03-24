//
//  STEventManager.m
//  Template
//
//  Created by krmao on 2020/12/25.
//  Copyright © 2020 smart. All rights reserved.
//

#import "STEventManager.h"
#import "STStringUtil.h"

@implementation Event
- (instancetype)init:(NSString *)eventKey{
    self = [super init];
    if (self) {
        self.eventKey = eventKey;
    }
    return self;
}

- (instancetype)init:(NSString *)eventKey callbackListener:(CallbackListener)callbackListener{
    self = [self init:eventKey];
    if (self) {
        self.callbackListener = callbackListener;
    }
    return self;
}

- (BOOL)isEqual:(id)other{
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else {
        return [other isKindOfClass:[Event class]] && ![STStringUtil emptyOrNull:((Event *)other).eventKey] && [((Event *)other).eventKey isEqualToString:self.eventKey];
    }
}
@end

static STEventManager *instance = nil;
@interface STEventManager()
@property (nonatomic, strong) NSMutableArray *eventListenerObjects;
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSMutableSet<Event*>*> *eventMap;
@end

@implementation STEventManager

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[STEventManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.eventListenerObjects = [NSMutableArray array];
        self.eventMap = NSMutableDictionary.new;
    }
    return self;
}

- (void)register:(NSString *)eventId eventKey:(NSString*)eventKey callbackListener:(CallbackListener)callbackListener{
    @synchronized (self.eventMap) {
        NSMutableSet<Event*>* eventSet = [self.eventMap valueForKey:eventId] ?: [[NSMutableSet alloc] init];
        [eventSet addObject:[[Event alloc] init:eventKey callbackListener:callbackListener]];
        [self.eventMap setValue:eventSet forKey:eventId];
    }
}

- (void)unregister:(NSString *)eventId eventKey:(NSString *)eventKey{
    if([STStringUtil emptyOrNull:eventKey]) return;
    
    @synchronized (self.eventMap) {
        if([[self.eventMap allKeys] containsObject:eventId]){
            NSMutableSet<Event*>* eventSet = [self.eventMap valueForKey:eventId];
            if(eventSet != nil && ![eventSet isKindOfClass:[NSNull class]]){
                [eventSet removeObject:[[Event alloc] init:eventKey]];
                if(eventSet.count == 0){
                    [self.eventMap removeObjectForKey:eventId];
                }else{
                    [self.eventMap setValue:eventSet forKey:eventId];
                }
            }
            
        }
    }
}

- (void)unregisterAll:(NSString *)eventId{
    @synchronized (self.eventMap) {
        [self.eventMap removeObjectForKey:eventId];
    }
}

- (void)sendEvent:(NSString *)eventKey value:(NSDictionary<NSString *,id> *)value{
    if([STStringUtil emptyOrNull:eventKey]) return;
    
    @synchronized (self.eventMap) {
        for(NSMutableSet<Event*>* eventSet in [self.eventMap allValues]){
            if(eventSet != nil && ![eventSet isKindOfClass:[NSNull class]] && eventSet.count > 0){
                for(Event* event in eventSet){
                    if([event.eventKey isEqualToString:eventKey]){
                        event.callbackListener(eventKey, value);
                    }
                }
            }
        }
    }
}

@end

