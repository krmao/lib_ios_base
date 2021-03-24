//
//  STEventManager.h
//  Template
//
//  Created by krmao on 2020/12/25.
//  Copyright © 2020 smart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CallbackListener)(NSString * _Nullable eventKey, NSDictionary<NSString *, id> * _Nullable value);

NS_ASSUME_NONNULL_BEGIN

@interface Event : NSObject
@property (nonatomic, copy) NSString *eventKey;
@property (nonatomic, copy) CallbackListener callbackListener;
- (instancetype)init:(NSString *)eventKey callbackListener:(CallbackListener)callbackListener;
- (instancetype)init:(NSString *)eventKey;
@end

@interface STEventManager : NSObject

+ (instancetype)sharedInstance;
- (void)register:(NSString *)eventId eventKey:(NSString*)eventKey callbackListener:(CallbackListener)callbackListener;
- (void)unregister:(NSString *)eventId eventKey:(NSString *)eventKey;
- (void)unregisterAll:(NSString *)eventId;
- (void)sendEvent:(NSString *)eventKey value:(NSDictionary<NSString *,id> *)value;

@end




NS_ASSUME_NONNULL_END
