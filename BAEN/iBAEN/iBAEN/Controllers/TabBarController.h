//
//  TabBarController.h
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

@interface TabBarController : UIViewController <UITabBarDelegate> {
    UITabBar *tabBar;
    NSArray *viewControllers;
    UIViewController *selectedViewController;
}

@property (nonatomic, readonly) UITabBar *tabBar;

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, assign) UIViewController *selectedViewController;

@end



