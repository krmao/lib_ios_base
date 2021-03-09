#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IBusHandler : NSObject
@property(nonatomic, readonly) NSString *businessNamePrefixAndURLHost;
- (id)initWithHost:(NSString *)host;
- (id)doDataJob:(NSString *)businessName params:(NSArray *)params;
@end

@interface STBusManager : NSObject
+ (void)register:(IBusHandler *)busObj;
+ (id)callData:(NSString *)buinessName param:(NSObject *)param, ... NS_REQUIRES_NIL_TERMINATION;
@end

NS_ASSUME_NONNULL_END
