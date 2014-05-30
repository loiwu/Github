//
//  InstapaperLoginController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "LoginController.h"
#import "InstapaperAuthenticator.h"

@interface InstapaperLoginController : LoginController <LoginControllerDelegate, InstapaperAuthenticatorDelegate> {
    NSURL *pendingURL;
}

@property (nonatomic, copy) NSURL *pendingURL;

@end
