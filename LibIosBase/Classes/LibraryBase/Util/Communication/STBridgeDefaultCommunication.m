//
//  STBridgeDefaultCommunication.m
//  LibIosBase
//
//  Created by krmao on 2021/2/9.
//

#import "STBridgeDefaultCommunication.h"
#import "STJsonUtil.h"
#import "UIViewController+TopMostViewController.h"
#import "STBusManager.h"
"
@implementation STBridgeDefaultCommunication
+(void) handleBridge:(nullable UIViewController *) viewController functionName:(nullable NSString *) functionName params:(nullable NSString *) params callBackId:(nullable NSString *) callBackId callback: (nullable BridgeHandlerCallback) callback{
    NSDictionary* resultDict = [NSMutableDictionary new];
    
    NSDictionary* bridgeParamsDict = [STJsonUtil jsonStringToArrayOrDictionary:params];

    if ([@"open" isEqual: functionName]) {
        NSString* urlString = [bridgeParamsDict objectForKey:@"url"];
        if ([urlString hasPrefix:@"smart://template/flutter"]) {
            if ([[bridgeParamsDict allKeys] containsObject:@"uniqueId"] ) {
                [STBusManager callData:@"flutter/open" param:urlString];
            }
            [resultDict setValue:@"true" forKey:@"result"];
        }else if ([urlString hasPrefix:@"smart://template/rn"]) {
            [resultDict setValue:@"true" forKey:@"result"];
            // STRNURL *url = [[STRNURL alloc] init];
            // url.rnModuleName =  [bridgeParamsDict valueForKey:@"component"];
            // url.rnBundleURL = [NSURL fileURLWithPath:[[STRNFileManager fileNameBaseUnzip] stringByAppendingPathComponent:@"ios/index.ios.bundle"]];
            // STRNViewController *rnVc = [[STRNViewController alloc] initWithURL:url andInitialProperties:@{@"page":[bridgeParamsDict valueForKey:@"page"]}];

            // [viewController.navigationController pushViewController:rnVc animated:true];
        }
    }else if ([@"close" isEqual: functionName]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIViewController topMostViewController].navigationController popViewControllerAnimated:true];
        });
        [resultDict setValue:@"true" forKey:@"result"];
    }else if ([@"showToast" isEqual: functionName]) {
        [resultDict setValue:@"true" forKey:@"result"];
        NSLog(@"Current method: %@",NSStringFromSelector(_cmd));
        UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            //todo
        }];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"OC提示框" message:params preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:okAlert];
        UIViewController *topRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        [topRootVC presentViewController:alert animated:YES completion:nil];
    }else if ([@"put" isEqual: functionName]) {
        NSUserDefaults *defatult = [NSUserDefaults standardUserDefaults];
        if ([bridgeParamsDict valueForKey:@"value"]) {
            [defatult setValue:[bridgeParamsDict valueForKey:@"value"] forKey:[bridgeParamsDict valueForKey:@"key"]];
        }
        [defatult synchronize];
        [resultDict setValue:@"true" forKey:@"result"];
    }else if ([@"get" isEqual: functionName]) {
        NSUserDefaults *defatult = [NSUserDefaults standardUserDefaults];
        if ([bridgeParamsDict.allKeys containsObject:@"key"]) {
            NSString *value = [defatult valueForKey:[bridgeParamsDict valueForKey:@"key"]];
            [resultDict setValue:(!value ? @"" : value) forKey:@"result"];
        }
    }else if ([@"getUserInfo" isEqual: functionName]) {
        NSDictionary* data = [NSDictionary new];
        [data setValue:@"smart" forKey:@"name"];
        [resultDict setValue:data forKey:@"result"];
    }else if ([@"getLocationInfo" isEqual: functionName]) {
        NSDictionary* data = [NSDictionary new];
        [data setValue:@"121.10,31.22" forKey:@"currentLatLng"];
        [data setValue:@"上海" forKey:@"currentCity"];
        [resultDict setValue:data forKey:@"result"];
    }else if ([@"getDeviceInfo" isEqual: functionName]) {
        NSDictionary* data = [NSDictionary new];
        [data setValue:@"ios" forKey:@"platform"];
        [resultDict setValue:data forKey:@"result"];
    }else{
        [resultDict setValue:@"native 暂不支持" forKey:@"result"];
    }
    callback(callBackId, [STJsonUtil arrayOrDictionayToJsonString:resultDict]);
}

@end
