//
//  SharingController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

@class BarButtonItem;

@interface SharingController : NSObject {
    NSURL *url;
    NSString *title;
    UIViewController *controller;
}

- (id)initWithURL:(NSURL *)url title:(NSString *)title fromController:(UIViewController *)controller;

- (void)showFromView:(UIView *)view;
- (void)showFromView:(UIView *)view atRect:(CGRect)rect;
- (void)showFromBarButtonItem:(BarButtonItem *)item;

@end

