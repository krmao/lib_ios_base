//
//  STInitializer.m
//  CodesDancing
//
//  Created by krmao on 2021/2/9.
//

#import "STInitializer.h"
#import "STJsonUtil.h"

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
    return [STInitializer sharedInstance];
}

+(void) openSchema:(nullable UIViewController*) viewController url:(nullable NSString*)url callback:(nullable BridgeHandlerCallback)callback{
    NSDictionary* bridgeParamsDict = [NSMutableDictionary new];
    [bridgeParamsDict setValue:url forKey:@"url"];
    [STInitializer sharedInstance].configBridge.bridgeHandler(viewController, @"open", [STJsonUtil arrayOrDictionayToJsonString:bridgeParamsDict], nil, callback);
}
@end
