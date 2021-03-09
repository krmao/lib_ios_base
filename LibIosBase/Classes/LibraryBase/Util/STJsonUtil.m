//
//  STJsonUtil.m
//  CodesDancing
//
//  Created by krmao on 2021/2/9.
//

#import "STJsonUtil.h"

@implementation STJsonUtil
+(nullable NSString*) arrayOrDictionayToJsonString:(nullable id)arrayOrDictionary{
    if (arrayOrDictionary == nil) return nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrayOrDictionary options:0 error:&error];
    if ([jsonData length] && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
       return nil;
    }
}
+(nullable id) jsonStringToArrayOrDictionary:(nullable NSString*)jsonString{
    if(jsonString == nil) return nil;
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];;
}

// -字典转换成json串
+ (nullable NSString *)dictionaryToJsonString:(nullable NSDictionary *)dict {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&parseError];
    if (parseError) {
        return @"";
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

// -数组转换成json串
+ (nullable NSString *)arrayToJsonString:(nullable NSArray *)array {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return @"";
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];;
}

// -json串转换成字典
+ (nullable NSDictionary *)dictionaryWithJsonString:(nullable NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        return nil;
    }
    return dic;
}

// -json串转换成数组
+ (id)arrayWithJsonString:(nullable NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        return nil;
    }
    return arr;
}
@end
