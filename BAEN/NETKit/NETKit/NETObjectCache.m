//
//  NETObjectCache.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"
#import "NETObjectCache.h"
#import "NETSession.h"

#import "NSDictionary+Parameters.h"
#import "NSString+URLEncoding.h"
#import "NSString+Entities.h"
#import "NSString+Tags.h"

@interface NETObjectCacheKey : NSObject <NSCopying> {
    Class cls;
    id identifier;
    NSDictionary *info;
}

@end

@implementation NETObjectCacheKey

#pragma mark - Lifecycle

- (id)initWithClass:(Class)cls_ identifier:(id)identifier_ infoDictionary:(NSDictionary *)info_ {
    if ((self = [super init])) {
        cls = cls_;
        identifier = [identifier_ copy];
        info = [info_ copy];
    }
    
    return self;
}

- (void)dealloc {
    [identifier release];
    [info release];
    
    [super dealloc];
}

+ (id)objectCacheWithClass:(Class)cls_ identifier:(id)identifier_ infoDictionary:(NSDictionary *)info {
    return [[[self alloc] initWithClass:cls_ identifier:identifier_ infoDictionary:info] autorelease];
}

+ (id)objectCacheForObject:(NETObject *)object {
    return [self objectCacheWithClass:[object class] identifier:[object identifier] infoDictionary:[object infoDictionary]];
}

+ (NSString *)persistentCacheIdentiferForClass:(Class)cls_ identifier:(id)identifier_ infoDictionary:(NSDictionary *)info {
    NSString *infoString = @"";
    
    if (info != nil) {
        infoString = [@"-" stringByAppendingString:[[info queryString] stringByURLEncodingString]];
    }
    
    return [NSString stringWithFormat:@"%@-%@%@", cls_, identifier_, infoString];
}

- (NSString *)persistentCacheIdentifier {
    return [[self class] persistentCacheIdentiferForClass:cls identifier:identifier infoDictionary:info];
}

#pragma mark - Properties

- (Class)objectClass {
    return cls;
}

- (id)objectIdentifier {
    return identifier;
}

- (NSDictionary *)objectInfoDictionary {
    return info;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] allocWithZone:zone] initWithClass:cls identifier:identifier infoDictionary:info];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object_ {
    BOOL classes = cls == [object_ objectClass];
    BOOL identifiers = [identifier isEqual:[object_ objectIdentifier]];
    BOOL infos = [info isEqualToDictionary:[object_ objectInfoDictionary]] || (info == nil && [object_ objectInfoDictionary] == nil);
    
    return classes && identifiers && infos;
}

- (NSUInteger)hash {
    return [cls hash] ^ [identifier hash] ^ [info hash];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@:%p class=%@ identifier=%@ info=%p>", [self class], self, cls, identifier, info];
}

@end

@implementation NETObjectCache

- (NSMutableDictionary *)cacheDictionary {
    return cacheDictionary;
}

- (NSString *)persistentCachePath {
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    if ([cachePaths count] > 0) {
        NSString *cachePath = [cachePaths objectAtIndex:0];
        NSString *objectPath = [cachePath stringByAppendingPathComponent:@"NETObjectCache"];
        objectPath = [objectPath stringByAppendingPathComponent:[session identifier]];
        return objectPath;
    } else {
        return nil;
    }
}

- (void)clearPersistentCache {
    NSString *cachePath = [self persistentCachePath];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:cachePath error:NULL];
    });
}

- (NSString *)persistentCachePathForKey:(NETObjectCacheKey *)key {
    NSString *cachePath = [self persistentCachePath];
    NSString *keyPath = [key persistentCacheIdentifier];
    NSString *objectPath = [cachePath stringByAppendingPathComponent:keyPath];
    
    return objectPath;
}

- (BOOL)persistentCacheHasObjectForKey:(NETObjectCacheKey *)key {
    NSString *path = [self persistentCachePathForKey:key];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

- (NSDictionary *)persistentCacheDictionaryForKey:(NETObjectCacheKey *)key {
    NSString *path = [self persistentCachePathForKey:key];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

- (void)updateObjectFromPersistentCache:(NETObject *)object {
    NETObjectCacheKey *key = [NETObjectCacheKey objectCacheForObject:object];
    
    if ([self persistentCacheHasObjectForKey:key] && ![object isLoaded]) {
        NSDictionary *cachedDictionary = [self persistentCacheDictionaryForKey:key];
        [object loadFromDictionary:cachedDictionary complete:YES];
    }
}

- (void)savePersistentCacheDictionary:(NSDictionary *)dict forObject:(NETObject *)object {
    NETObjectCacheKey *key = [NETObjectCacheKey objectCacheForObject:object];
    NSString *path = [self persistentCachePathForKey:key];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [dict writeToFile:path atomically:YES];
    });
}

- (void)createPersistentCache {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:[self persistentCachePath] withIntermediateDirectories:YES attributes:nil error:NULL];
}

- (id)initWithSession:(NETSession *)session_ {
    if ((self = [super init])) {
        session = session_;
        
        cacheDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)dealloc {
    [cacheDictionary release];
    
    [super dealloc];
}

- (NETObject *)objectFromCacheWithKey:(NETObjectCacheKey *)key {
    NSMutableDictionary *cache = [self cacheDictionary];
    NETObject *object = [cache objectForKey:key];
    return object;
}

- (NETObject *)objectFromCacheWithClass:(Class)cls_ identifier:(id)identifier_ infoDictionary:(NSDictionary *)info {
    NETObjectCacheKey *key = [NETObjectCacheKey objectCacheWithClass:cls_ identifier:identifier_ infoDictionary:info];
    return [self objectFromCacheWithKey:key];
}

- (BOOL)cacheHasObject:(NETObject *)object {
    NETObjectCacheKey *key = [NETObjectCacheKey objectCacheForObject:object];
    return ([self objectFromCacheWithKey:key] != nil);
}

- (void)addObjectToCache:(NETObject *)object {
    NETObjectCacheKey *key = [NETObjectCacheKey objectCacheForObject:object];
    
    NSMutableDictionary *cache = [self cacheDictionary];
    [cache setObject:object forKey:key];
}

@end

