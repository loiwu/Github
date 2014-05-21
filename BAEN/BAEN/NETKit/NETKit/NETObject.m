//
//  NETObject.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NSURL+Parameters.h"
#import "NSDictionary+Parameters.h"

#import "NETKit.h"
#import "NETObject.h"
#import "NETSession.h"
#import "NETObjectCache.h"

@interface NETObject ()

@property (nonatomic, assign, readwrite) NETSession *session;

@end

@implementation NETObject
@synthesize identifier=identifier, URL=url, session=session;
@synthesize loadingState;

+ (BOOL)isValidURL:(NSURL *)url_ {
    if (url_ == nil) return NO;
    if (![[url_ scheme] isEqualToString:@"http"] && ![[url_ scheme] isEqualToString:@"https"]) return NO;
    if (![[url_ host] isEqualToString:kNETWebsiteHost]) return NO;
    
    return YES;
}

+ (NSDictionary *)infoDictionaryForURL:(NSURL *)url_ {
    return nil;
}

+ (id)identifierForURL:(NSURL *)url_ {
    return nil;
}

+ (NSString *)pathForURLWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info {
    return nil;
}

+ (NSDictionary *)parametersForURLWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info {
    return nil;
}

+ (NSURL *)generateURLWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info {
    NSDictionary *parameters = [self parametersForURLWithIdentifier:identifier_ infoDictionary:info];
    NSString *path = [self pathForURLWithIdentifier:identifier_ infoDictionary:info];
    NSString *combined = [path stringByAppendingString:[parameters queryString]];
    return [[NSURL URLWithString:combined relativeToURL:kNETWebsiteURL] absoluteURL];
}

+ (id)session:(NETSession *)session objectWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info URL:(NSURL *)url_ {
    NETObjectCache *cache = [session cache];
    NETObject *object = [cache objectFromCacheWithClass:self identifier:identifier_ infoDictionary:info];
    
    if (object == nil) {
        object = [[[self alloc] init] autorelease];
        [object setSession:session];
    }
    
    if (url_ != nil) {
        [object setURL:url_];
        [object setIdentifier:identifier_];
        [object loadInfoDictionary:info];
        
        if (![cache cacheHasObject:object]) {
            [cache addObjectToCache:object];
        }
    }
    
    return object;
}

+ (id)session:(NETSession *)session objectWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info {
    return [self session:session objectWithIdentifier:identifier_ infoDictionary:info URL:[[self class] generateURLWithIdentifier:identifier_ infoDictionary:info]];
}

+ (id)session:(NETSession *)session objectWithIdentifier:(id)identifier_ {
    return [self session:session objectWithIdentifier:identifier_ infoDictionary:nil];
}

+ (id)session:(NETSession *)session objectWithURL:(NSURL *)url_ {
    id identifier_ = [self identifierForURL:url_];
    NSDictionary *info = [self infoDictionaryForURL:url_];
    return [self session:session objectWithIdentifier:identifier_ infoDictionary:info URL:url_];
}

+ (NSString *)pathWithIdentifier:(id)identifier {
    return nil;
}

- (NSDictionary *)infoDictionary {
    return nil;
}

- (void)loadInfoDictionary:(NSDictionary *)info {
    return;
}

- (NSString *)description {
    NSString *other = nil;
    
    if (![self isLoaded]) {
        other = @"[not loaded]";
    }
    
    NSString *identifier_ = [NSString stringWithFormat:@" identifier=%@", identifier];
    if (identifier == nil) identifier_ = @"";
    
    return [NSString stringWithFormat:@"<%@:%p %@ %@>", [self class], self, identifier_, other];
}

#pragma mark - Loading

- (void)clearLoadingState:(NETObjectLoadingState)state_ {
    loadingState &= ~state_;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNETObjectLoadingStateChangedNotification object:self];
}

- (void)addLoadingState:(NETObjectLoadingState)state_ {
    loadingState |= state_;
    
    if ((state_ & kNETObjectLoadingStateLoaded) > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNETObjectFinishedLoadingNotification object:self];
    } else if ((state_ & kNETObjectLoadingStateLoadingAny) > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNETObjectStartedLoadingNotification object:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNETObjectLoadingStateChangedNotification object:self];
}

- (BOOL)hasLoadingState:(NETObjectLoadingState)state_ {
    return ([self loadingState] & state_) > 0;
}

- (BOOL)isLoaded {
    return [self hasLoadingState:kNETObjectLoadingStateLoaded];
}

- (void)setIsLoaded:(BOOL)loaded {
    if (loaded) {
        // XXX: do we really want to do this here?
        if ([self isLoading]) [self cancelLoading];
        
        [self clearLoadingState:kNETObjectLoadingStateUnloaded];
        [self clearLoadingState:kNETObjectLoadingStateNotLoaded];
        [self addLoadingState:kNETObjectLoadingStateLoaded];
    } else {
        [self clearLoadingState:kNETObjectLoadingStateLoaded];
        [self addLoadingState:kNETObjectLoadingStateUnloaded];
    }
}

- (BOOL)isLoading {
    return [self hasLoadingState:kNETObjectLoadingStateLoadingAny];
}

- (void)loadFromDictionary:(NSDictionary *)dictionary complete:(BOOL)complete {
    if (complete) {
        NETObjectCache *cache = [session cache];
        [cache savePersistentCacheDictionary:dictionary forObject:self];
        [self setIsLoaded:YES];
    }
}

- (void)_clearRequest {
    if ([apiRequest isLoading]) {
        [apiRequest cancelRequest];
    }
    
    [apiRequest release];
    apiRequest = nil;
    
    [self clearLoadingState:kNETObjectLoadingStateLoadingAny];
}

- (void)request:(NETAPIRequest *)request completedWithResponse:(NSDictionary *)response error:(NSError *)error {
    if (error == nil) {
        [self loadFromDictionary:response complete:YES];
    }
    
    // note: don't move this downwards, bad things will happen
    [self _clearRequest];
    
    if (error != nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNETObjectFailedLoadingNotification object:self];
    }
}

- (void)beginLoadingWithState:(NETObjectLoadingState)state_ {
    NETObjectCache *cache = [session cache];
    [cache updateObjectFromPersistentCache:self];
    
    [self addLoadingState:state_];
    
    NSDictionary *info = [self infoDictionary];
    NSDictionary *parameters = [[self class] parametersForURLWithIdentifier:identifier infoDictionary:info];
    NSString *path = [[self class] pathForURLWithIdentifier:identifier infoDictionary:info];
    
    apiRequest = [[NETAPIRequest alloc] initWithSession:session target:self action:@selector(request:completedWithResponse:error:)];
    [apiRequest performRequestWithPath:path parameters:parameters];
}

- (void)cancelLoading {
    [self _clearRequest];
}

- (void)beginLoading {
    // Loading multiple times at once just makes no sense.
    if ([self isLoading]) return;
    
    if ([self isLoaded]) {
        [self beginLoadingWithState:kNETObjectLoadingStateLoadingReload];
    } else {
        [self beginLoadingWithState:kNETObjectLoadingStateLoadingInitial];
    }
}

@end
