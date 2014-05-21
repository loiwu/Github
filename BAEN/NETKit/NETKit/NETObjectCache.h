//
//  NETObjectCache.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETObject.h"

@interface NETObjectCache : NSObject {
    NETSession *session;
    NSMutableDictionary *cacheDictionary;
}

- (id)initWithSession:(NETSession *)session_;

- (BOOL)cacheHasObject:(NETObject *)object;
- (void)addObjectToCache:(NETObject *)object_;
- (NETObject *)objectFromCacheWithClass:(Class)cls_ identifier:(id)identifier_ infoDictionary:(NSDictionary *)info;

- (void)createPersistentCache;
- (void)clearPersistentCache;
- (void)updateObjectFromPersistentCache:(NETObject *)object;
- (void)savePersistentCacheDictionary:(NSDictionary *)dict forObject:(NETObject *)object;

@end

