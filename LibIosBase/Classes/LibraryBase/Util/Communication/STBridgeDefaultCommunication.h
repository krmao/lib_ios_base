//
//  STBridgeDefaultCommunication.h
//  CodesDancing
//
//  Created by krmao on 2021/2/9.
//

#import <Foundation/Foundation.h>
#import "STInitializer.h"

@interface STBridgeDefaultCommunication : NSObject
+(void) handleBridge:(nullable UIViewController *) viewController functionName:(nullable NSString *) functionName params:(nullable NSString *) params callBackId:(nullable NSString *) callBackId callback: (nullable BridgeHandlerCallback) callback;
@end
