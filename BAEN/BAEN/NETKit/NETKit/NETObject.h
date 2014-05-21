//
//  NETObject.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETShared.h"

typedef enum {
    kNETObjectLoadingStateNotLoaded = 0,
    kNETObjectLoadingStateUnloaded = 0,
    kNETObjectLoadingStateLoadingInitial = 1 << 0,
    kNETObjectLoadingStateLoadingReload = 1 << 1,
    kNETObjectLoadingStateLoadingOther = 1 << 2,
    kNETObjectLoadingStateLoadingAny = (kNETObjectLoadingStateLoadingInitial | kNETObjectLoadingStateLoadingReload | kNETObjectLoadingStateLoadingOther),
    kNETObjectLoadingStateCustom = 0xFFFF0000, /* mask */
    kNETObjectLoadingStateLoaded = 1 << 15,
} NETObjectLoadingState;

#define kNETObjectStartedLoadingNotification @"NETObjectStartedLoading"
#define kNETObjectFinishedLoadingNotification @"NETObjectFinishedLoading"
#define kNETObjectFailedLoadingNotification @"NETObjectFailedLoading"
#define kNETObjectLoadingStateChangedNotification @"NETObjectLoadingStateChanged"
#define kNETObjectLoadingStateChangedNotificationErrorKey @"NETObjectLoadingStateChangedNotificationError"

@class NETAPIRequest, NETSession;
@interface NETObject : NSObject {
    NETSession *session;
    id identifier;
    NSURL *url;
    
    NETObjectLoadingState loadingState;
    
    NETAPIRequest *apiRequest;
}

@property (nonatomic, assign, readonly) NETSession *session;
@property (nonatomic, copy) id identifier;
@property (nonatomic, copy) NSURL *URL;
@property (nonatomic, readonly) NETObjectLoadingState loadingState;

+ (BOOL)isValidURL:(NSURL *)url_;
+ (NSDictionary *)infoDictionaryForURL:(NSURL *)url_;
+ (id)identifierForURL:(NSURL *)url_;

+ (NSString *)pathForURLWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info;
+ (NSDictionary *)parametersForURLWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info;
+ (NSURL *)generateURLWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info;

// These methods don't necessarily create a new instance if it's already in the
// cache. The cache's keyed on (class, identifier, info) tuples inside NETObject.
+ (id)session:(NETSession *)session objectWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info URL:(NSURL *)url_;
+ (id)session:(NETSession *)session objectWithIdentifier:(id)identifier_ infoDictionary:(NSDictionary *)info;
+ (id)session:(NETSession *)session objectWithIdentifier:(id)identifier_;
+ (id)session:(NETSession *)session objectWithURL:(NSURL *)url_;

- (NSDictionary *)infoDictionary;

- (void)loadFromDictionary:(NSDictionary *)dictionary complete:(BOOL)complete;

- (void)setIsLoaded:(BOOL)loaded;
- (BOOL)isLoaded;

- (BOOL)isLoading;

- (void)cancelLoading;
- (void)beginLoading;

@end

@interface NETObject (Subclassing)

@property (nonatomic, copy) NSDictionary *contentsDictionary;

- (void)beginLoadingWithState:(NETObjectLoadingState)state_;
- (void)addLoadingState:(NETObjectLoadingState)state_;
- (void)clearLoadingState:(NETObjectLoadingState)state_;
- (BOOL)hasLoadingState:(NETObjectLoadingState)state_;

- (void)loadInfoDictionary:(NSDictionary *)info;

@end


