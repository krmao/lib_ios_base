//
//  STInitializer.h
//  LibIosBase
//
//  Created by krmao on 2021/2/9.
//
//  对于属性、方法返回值、方法参数的修饰，使用：nonnull/nullable；
//  对于 C 函数的参数、Block 的参数、Block 返回值的修饰，使用：_Nonnull/_Nullable，建议弃用 __nonnull/__nullable。
//

#import <Foundation/Foundation.h>

typedef void (^BridgeHandlerCallback)( NSString * _Nullable callBackId, NSString * _Nullable resultJsonString );
typedef void (^BridgeHandler)(UIViewController * _Nullable viewController, NSString * _Nullable functionName, NSString * _Nullable params, NSString * _Nullable callBackId, BridgeHandlerCallback _Nullable callback);

NS_ASSUME_NONNULL_BEGIN

@interface ConfigBridge : NSObject
@property(nonatomic, strong, nullable, readwrite) BridgeHandler bridgeHandler;
@end

@interface ConfigBundle : NSObject
@property(nonatomic, strong, nullable, readwrite) NSDictionary<NSString*, NSString*>* bundleBusHandlerClassMap;
@end

@interface Config : NSObject
@property(nonatomic, strong, nullable, readwrite) id<UIApplicationDelegate> application;
@property(nonatomic, readwrite) BOOL appDebug;
@property(nonatomic, strong, nullable, readwrite) ConfigBridge* configBridge;
@property(nonatomic, strong, nullable, readwrite) ConfigBundle* configBundle;
@end

@interface STInitializer : NSObject
@property(nonatomic, strong, nullable, readwrite) Config* config;
@property(nonatomic, strong, nullable, readwrite) ConfigBridge* configBridge;
@property(nonatomic, strong, nullable, readwrite) ConfigBundle* configBundle;
+(instancetype) sharedInstance;
+(STInitializer *) initialApplication:(Config *)config;
+(void) openSchema:(nullable UIViewController*) viewController url:(nullable NSString*)url callback:(nullable BridgeHandlerCallback)callback;
@end



NS_ASSUME_NONNULL_END
