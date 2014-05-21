//
//  NavigationController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

// An orange navigation controller. Sometimes.

#import "LoginController.h"
#import "HackerNewsLoginController.h"

@protocol NavigationControllerLoginDelegate;

@interface NavigationController : UINavigationController <LoginControllerDelegate> {
    id<NavigationControllerLoginDelegate> loginDelegate;
}

@property (nonatomic, assign) id<NavigationControllerLoginDelegate> loginDelegate;
- (void)requestLogin;
- (void)requestSessions;

@end

@interface UIViewController (NavigationController)

- (NavigationController *)navigation;

@end

@protocol NavigationControllerLoginDelegate <NSObject>

- (void)navigationController:(NavigationController *)navigationController didLoginWithSession:(NETSession *)session;
- (void)navigationControllerRequestedSessions:(NavigationController *)navigationController;

@end
