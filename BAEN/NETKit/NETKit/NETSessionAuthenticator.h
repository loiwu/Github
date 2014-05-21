//
//  NETSessionAuthenticator.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"
#import "NETSession.h"

@protocol NETSessionAuthenticatorDelegate;

@interface NETSessionAuthenticator : NSObject {
    NSURLConnection *connection;
    
    __weak id<NETSessionAuthenticatorDelegate> delegate;
    NSString *username;
    NSString *password;
}

@property (nonatomic, assign) id<NETSessionAuthenticatorDelegate> delegate;

- (id)initWithUsername:(NSString *)username password:(NSString *)password;
- (void)beginAuthenticationRequest;

@end

@protocol NETSessionAuthenticatorDelegate <NSObject>

// Success: we got a token.
- (void)sessionAuthenticator:(NETSessionAuthenticator *)authenticator didRecieveToken:(NETSessionToken)token;
// Failure: username or password invalid or network error.
- (void)sessionAuthenticatorDidRecieveFailure:(NETSessionAuthenticator *)authenticator;

@end

