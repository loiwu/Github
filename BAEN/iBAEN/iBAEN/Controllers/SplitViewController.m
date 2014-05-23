//
//  SplitViewController.m
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

// done-052314

#import "SplitViewController.h"

@implementation SplitViewController

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return [[self viewControllers] firstObject];
}

AUTOROTATION_FOR_PAD_ONLY;

@end
