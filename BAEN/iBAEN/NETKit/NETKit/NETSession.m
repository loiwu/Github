//
//  NETSession.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"
#import "NETSession.h"
#import "NETObjectCache.h"
#import "NETAPISubmission.h"
#import "NETSubmission.h"
#import "NETAnonymousSession.h"

@implementation NETSession
@synthesize user, token, loaded, password, cache;

- (id)initWithUsername:(NSString *)username password:(NSString *)password_ token:(NSString *)token_ {
    if ((self = [super init])) {
        cache = [[NETObjectCache alloc] initWithSession:self];
        
        if (username != nil) {
            NETUser *user_ = [NETUser session:self userWithIdentifier:username];
            [self setUser:user_];
        }
        
        [self setToken:token_];
        [self setPassword:password_];
        
        [self setLoaded:YES];
        
        [cache createPersistentCache];
    }
    
    return self;
}

- (id)initWithSessionDictionary:(NSDictionary *)sessionDictionary {
    NETSessionToken token_ = (NETSessionToken) [sessionDictionary objectForKey:@"NETKit:NETSession:Token"];
    NSString *password_ = [sessionDictionary objectForKey:@"NETKit:NETSession:Password"];
    NSString *name_ = [sessionDictionary objectForKey:@"NETKit:NETSession:Identifier"];
    
    return [self initWithUsername:name_ password:password_ token:token_];
}

- (NSDictionary *)sessionDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            token, @"NETKit:NETSession:Token",
            password, @"NETKit:NETSession:Password",
            [self identifier], @"NETKit:NETSession:Identifier",
            nil];
}

- (NSString *)identifier {
    return [[self user] identifier];
}

- (void)dealloc {
    [cache release];
    
    [super dealloc];
}

- (void)sessionAuthenticatorDidRecieveFailure:(NETSessionAuthenticator *)authenticator_ {
    [authenticator autorelease];
    authenticator = nil;
}

- (void)sessionAuthenticator:(NETSessionAuthenticator *)authenticator_ didRecieveToken:(NETSessionToken)token_ {
    [authenticator autorelease];
    authenticator = nil;
    
    [self setToken:token_];
}

- (void)reloadToken {
    // XXX: maybe this should return an error code
    if (authenticator != nil) return;
    
    authenticator = [[NETSessionAuthenticator alloc] initWithUsername:[user identifier] password:password];
    [authenticator setDelegate:self];
    [authenticator beginAuthenticationRequest];
}

- (void)performSubmission:(NETSubmission *)submission {
    NETAPISubmission *api = [[NETAPISubmission alloc] initWithSession:self submission:submission];
    [api performSubmission];
    [api autorelease];
}

- (void)addCookiesToRequest:(NSMutableURLRequest *)request {
    if (token == nil) return;
    
    NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:
                                kNETWebsiteHost, NSHTTPCookieDomain,
                                @"/", NSHTTPCookiePath,
                                @"user", NSHTTPCookieName,
                                (NSString *) token, NSHTTPCookieValue,
                                nil];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:properties];
    NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:[NSArray arrayWithObject:cookie]];
    [request setAllHTTPHeaderFields:headers];
}

@end
