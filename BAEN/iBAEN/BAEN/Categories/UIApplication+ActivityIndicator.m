//
//  UIApplication+ActivityIndicator.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "UIApplication+ActivityIndicator.h"

@implementation UIApplication (ActivityIndicator)

- (void)_updateNetworkActivityIndicator:(BOOL)visible {
    static NSInteger count = 0;
    
    if (visible) count += 1;
    else count -= 1;
    
    [self setNetworkActivityIndicatorVisible:(count > 0)];
}


- (void)retainNetworkActivityIndicator {
    [self _updateNetworkActivityIndicator:YES];
}

- (void)releaseNetworkActivityIndicator {
    [self _updateNetworkActivityIndicator:NO];
}

@end
