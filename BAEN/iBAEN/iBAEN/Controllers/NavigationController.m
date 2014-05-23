//
//  NavigationController.m
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NavigationController.h"

#import "LoginController.h"
#import "UIColor+Colorful.h"
#import "HackerNewsLoginController.h"
#import "ColorfulNavigationBar.h"

@implementation NavigationController
@synthesize loginDelegate;

- (id)init {
    return [self initWithRootViewController:nil];
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if ((self = [super initWithNavigationBarClass:[ColorfulNavigationBar class] toolbarClass:nil])) {
        if (rootViewController != nil) {
            [self pushViewController:rootViewController animated:NO];
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enteredForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [super dealloc];
}

- (void)enteredForeground {
    [self viewWillAppear:NO];
    [self viewDidAppear:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ColorfulNavigationBar *navigationBar = (ColorfulNavigationBar *)[self navigationBar];
    [navigationBar setColorful:![[NSUserDefaults standardUserDefaults] boolForKey:@"disable-colorful"]];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"disable-colorful"]) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return nil;
}

// Why this isn't delegated by UIKit to the top view controller, I have no clue.
// This, however, should unobstrusively add that delegation.
- (UIModalPresentationStyle)modalPresentationStyle {
    UIModalPresentationStyle style = [super modalPresentationStyle];
    
    if (style != UIModalPresentationFullScreen) {
        return style;
    } else if ([self topViewController]) {
        return [[self topViewController] modalPresentationStyle];
    } else {
        return style;
    }
}

- (void)loginControllerDidLogin:(HackerNewsLoginController *)controller {
    [self dismissViewControllerAnimated:YES completion:^{
        [loginDelegate navigationController:self didLoginWithSession:[controller session]];
    }];
}

- (void)loginControllerDidCancel:(HackerNewsLoginController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)requestLogin {
    LoginController *login = [[HackerNewsLoginController alloc] init];
    [login setDelegate:self];
    
    NavigationController *navigation = [[NavigationController alloc] initWithRootViewController:login];
    [self presentViewController:navigation animated:YES completion:NULL];
    
    [navigation release];
    [login release];
}

- (void)requestSessions {
    [loginDelegate navigationControllerRequestedSessions:self];
}

AUTOROTATION_FOR_PAD_ONLY

@end

@implementation UIViewController (NavigationController)

- (NavigationController *)navigation {
    UIViewController *parentViewController = [self parentViewController];
    
    while (parentViewController != nil) {
        if ([parentViewController isKindOfClass:[NavigationController class]]) {
            return (NavigationController *)parentViewController;
        }
        
        parentViewController = [parentViewController parentViewController];
    }
    
    return nil;
}

@end

