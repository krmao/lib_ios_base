/**
 * XCode报错 "_BZ2_bzRead", referenced from 等
 * 在工程target的Build Phases->Link Binary with Libraries中加入libz.tbd、libbz2.1.0.tbd
 * @param argc
 * @param argv
 * @return
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STBSPatch : NSObject

+ (BOOL)patchOldFile:(NSString *)oldFilePath newFile:(NSString *)newFilePath withPatchFile:(NSString *)patchFilePath;

@end

NS_ASSUME_NONNULL_END
