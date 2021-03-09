//
//  STInitializer.m
//  LibIosBase
//
//  Created by krmao on 2021/2/9.
//

#import "STInitializer.h"
#import "STJsonUtil.h"
#import "STBusManager.h"

@implementation ConfigBridge
@end

@implementation ConfigBundle
@end

@implementation Config
@end

static STInitializer *instance = nil;

@implementation STInitializer

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[STInitializer alloc] init];
    });
    return instance;
}

+(STInitializer *) initialApplication:(Config *)config{
    [[STInitializer sharedInstance] setConfig:config];
    [[STInitializer sharedInstance] setConfigBridge:config.configBridge];
    [[STInitializer sharedInstance] setConfigBundle:config.configBundle];
    
    [[STInitializer sharedInstance].configBundle.bundleBusHandlerClassMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            IBusHandler * busHandler = [(IBusHandler *) [NSClassFromString((NSString *) key) alloc] initWithHost:(NSString *) obj];
            [STBusManager register:busHandler];
    }];
    
    return [STInitializer sharedInstance];
}

+(void) openSchema:(nullable UIViewController*) viewController url:(nullable NSString*)url callback:(nullable BridgeHandlerCallback)callback{
    NSDictionary* bridgeParamsDict = [NSMutableDictionary new];
    [bridgeParamsDict setValue:url forKey:@"url"];
    [STInitializer sharedInstance].configBridge.bridgeHandler(viewController, @"open", [STJsonUtil arrayOrDictionayToJsonString:bridgeParamsDict], nil, callback);
}
@end
