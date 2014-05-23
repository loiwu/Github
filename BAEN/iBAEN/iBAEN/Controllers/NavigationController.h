//
//  NavigationController.h
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

//#import "LoginController.h"
//#import "HackerNewsLoginController.h"

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
