//
//  UIApplication+ActivityIndicator.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

@interface UIApplication (ActivityIndicator)

- (void)retainNetworkActivityIndicator;
- (void)releaseNetworkActivityIndicator;

@end
