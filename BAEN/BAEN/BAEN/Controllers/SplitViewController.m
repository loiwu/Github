//
//  SplitViewController.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "SplitViewController.h"

@implementation SplitViewController

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [[self viewControllers] firstObject];
}

AUTOROTATION_FOR_PAD_ONLY;

@end
