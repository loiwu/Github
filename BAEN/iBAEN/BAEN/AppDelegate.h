//
//  AppDelegate.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "LoginController.h"
#import "SplitViewController.h"
#import "NavigationController.h"
#import "PingController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate, UISplitViewControllerDelegate, PingControllerDelegate> {
    UIWindow *window;
    
    SplitViewController *splitController;
    
    NavigationController *navigationController;
    NavigationController *rightNavigationController;
    
    UIPopoverController *popover;
    UIBarButtonItem *popoverItem;
    
    PingController *pingController;
}

- (void)pushBranchViewController:(UIViewController *)branchController animated:(BOOL)animated;
- (void)pushLeafViewController:(UIViewController *)leafController animated:(BOOL)animated;

- (BOOL)leafContainsViewController:(UIViewController *)leafController;
- (void)setLeafViewController:(UIViewController *)leafController animated:(BOOL)animated;
- (void)clearLeafViewControllerAnimated:(BOOL)animated;

- (NSArray *)branchControllers;
- (void)setBranchControllers:(NSArray *)branchControllers animated:(BOOL)animated;

- (void)popBranchToViewController:(UIViewController *)branchController animated:(BOOL)animated;
- (void)popLeafToViewController:(UIViewController *)leafController animated:(BOOL)animated;

@end

@interface UINavigationController (AppDelegate)

- (void)pushController:(UIViewController *)controller animated:(BOOL)animated;
- (void)popToController:(UIViewController *)controller animated:(BOOL)animated;
- (void)willShowController:(UIViewController *)controller animated:(BOOL)animated;
- (void)setControllers:(NSArray *)controllers animated:(BOOL)animated;
- (NSArray *)controllers;

@end
