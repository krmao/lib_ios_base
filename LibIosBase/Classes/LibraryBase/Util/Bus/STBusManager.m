#import "STBusManager.h"
#import <os/lock.h>

@interface IBusHandler() {
    NSString *bizNamePrefix;
    NSString *urlHost;
}
@end

@implementation IBusHandler

- (id)initWithHost:(NSString *)host {
    if (self = [super init]) {
        urlHost = [host lowercaseString];
    }
    return self;
}

- (NSString *)businessNamePrefixAndURLHost {
    return urlHost;
}

- (id)doDataJob:(NSString *)businessName params:(NSArray *)params {
    //TO BE OVERRIDE
    return NULL;
}

@end


@interface STBusManager ()
@property(nonatomic, strong) NSMutableDictionary *dataBusObjectMap;
@end

static STBusManager *bus;

@implementation STBusManager

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    static os_unfair_lock aspect_lock = OS_UNFAIR_LOCK_INIT;
#else
    static OSSpinLock busSpinLock = OS_SPINLOCK_INIT;
#endif

+ (void)initializeBusIfNeed {
    if (bus == NULL) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            bus = [[STBusManager alloc] init];
        });
    }
}

+ (STBusManager *)sharedInstance {
    [STBusManager initializeBusIfNeed];
    return bus;
}

- (id)init {
    if (self = [super init]) {
        self.dataBusObjectMap = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (IBusHandler *)busObjectForName:(NSString *)bizName {
    IBusHandler *busObj = nil;

    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        os_unfair_lock_lock(&aspect_lock);
        busObj = [STBusManager FindBusWithKey:bizName];
        os_unfair_lock_unlock(&aspect_lock);
    #else
        OSSpinLockLock(&busSpinLock);
        busObj = [STBusManager FindBusWithKey: bizName];
        OSSpinLockUnlock(&busSpinLock);
    #endif
    return busObj;
}

+ (void)register:(IBusHandler *)busObj {
    if (busObj == NULL) {
        return;
    }
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        static os_unfair_lock aspect_lock = OS_UNFAIR_LOCK_INIT;
        os_unfair_lock_lock(&aspect_lock);
        [STBusManager registerBus:busObj];
        os_unfair_lock_unlock(&aspect_lock);
    #else
        static OSSpinLock busSpinLock = OS_SPINLOCK_INIT;
        OSSpinLockLock(&busSpinLock);
        [STBusManager registerBus:busObj];
        OSSpinLockUnlock(&busSpinLock);
    #endif
}

+ (void)registerBus:(IBusHandler *)busObj {
    if ([[STBusManager sharedInstance].dataBusObjectMap valueForKey:busObj.businessNamePrefixAndURLHost]) {
        NSAssert(false, @"host名=[%@]已注册，不可重复注册", busObj.businessNamePrefixAndURLHost);
    }
    [[STBusManager sharedInstance].dataBusObjectMap setValue:busObj forKey:busObj.businessNamePrefixAndURLHost];
}

+ (IBusHandler *)FindBusWithKey:(NSString *)key {

    NSDictionary *busObjectMap = [STBusManager sharedInstance].dataBusObjectMap;
    NSArray *hostList = [busObjectMap allKeys];
    NSString *findKey = nil;
    for (NSString *aKey in hostList) {
        if ([[key lowercaseString] hasPrefix:[aKey lowercaseString]]) {
            findKey = aKey;
            break;
        }
    }
    return (IBusHandler *) [busObjectMap valueForKey:findKey];
}

+ (id)callData:(NSString *)bizName param:(NSObject *)param, ... NS_REQUIRES_NIL_TERMINATION {
    IBusHandler *busObj = [STBusManager busObjectForName:bizName];
    if (!busObj) {
        NSAssert(false, @"busObj nil");
    }
    NSMutableArray *paramArr = nil;
    id eachItem;
    va_list argumentList;
    if (param != nil) {
        paramArr = [NSMutableArray array];

        [paramArr addObject:param];
        va_start(argumentList, param);
        while ((eachItem = va_arg(argumentList, id))) {
            [paramArr addObject:eachItem];
        }
        va_end(argumentList);
    }
    return [busObj doDataJob:bizName params:paramArr];;
}
@end
