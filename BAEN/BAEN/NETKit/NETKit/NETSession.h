//
//  NETSession.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"
#import "NETSessionAuthenticator.h"

@class NETUser, NETEntry, NETSubmission, NETObjectCache;
@interface NETSession : NSObject <NETSessionAuthenticatorDelegate> {
    BOOL loaded;
    NETSessionToken token;
    NETUser *user;
    NSString *password;
    NETSessionAuthenticator *authenticator;
    NETObjectCache *cache;
    
    NSDictionary *pool;
}

@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NETUser *user;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign, getter=isLoaded) BOOL loaded;
@property (nonatomic, retain, readonly) NSString *identifier;
@property (nonatomic, retain, readonly) NETObjectCache *cache;

- (id)initWithUsername:(NSString *)username password:(NSString *)password token:(NETSessionToken)token;
- (id)initWithSessionDictionary:(NSDictionary *)sessionDictionary;

- (NSDictionary *)sessionDictionary;

- (void)performSubmission:(NETSubmission *)submission;
- (void)reloadToken;

- (void)addCookiesToRequest:(NSMutableURLRequest *)request;

@end

