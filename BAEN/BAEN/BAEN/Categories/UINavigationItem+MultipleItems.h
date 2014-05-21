//
//  UINavigationItem+MultipleItems.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UINavigationItemPositionLeft,
    UINavigationItemPositionRight
} UINavigationItemPosition;

@interface UINavigationItem (MultipleItems)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)item atPosition:(UINavigationItemPosition)position;
- (void)addRightBarButtonItem:(UIBarButtonItem *)item atPosition:(UINavigationItemPosition)position;

- (void)removeLeftBarButtonItem:(UIBarButtonItem *)item;
- (void)removeRightBarButtonItem:(UIBarButtonItem *)item;
- (void)removeBarButtonItem:(UIBarButtonItem *)item;

@end
