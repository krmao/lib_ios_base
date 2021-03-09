//
//  STJsonUtil.h
//  CodesDancing
//
//  Created by krmao on 2021/2/9.
//

#import <Foundation/Foundation.h>

@interface STJsonUtil : NSObject
+(nullable NSString*) arrayOrDictionayToJsonString:(nullable id)arrayOrDictionary;
+(nullable id) jsonStringToArrayOrDictionary:(nullable NSString*)jsonString;

// -字典转换成json串
+ (nullable NSString *)dictionaryToJsonString:(nullable NSDictionary *)dict;

// -数组转换成json串
+ (nullable NSString *)arrayToJsonString:(nullable NSArray *)array;

// -json串转换成字典
+ (nullable NSDictionary *)dictionaryWithJsonString:(nullable NSString *)jsonString;

// -json串转换成数组
+ (id)arrayWithJsonString:(nullable NSString *)jsonString;

@end
