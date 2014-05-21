//
//  HackerNewsLoginController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <NETKit/NETKit.h>
#import "LoginController.h"

@interface HackerNewsLoginController : LoginController <NETSessionAuthenticatorDelegate> {
    NETSession *session;
}

@property (nonatomic, retain, readonly) NETSession *session;

@end

