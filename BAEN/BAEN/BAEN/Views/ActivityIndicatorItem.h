//
//  ActivityIndicatorItem.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "BarButtonItem.h"

#define kActivityIndicatorItemStandardSize CGSizeMake(20, 20)

@interface ActivityIndicatorItem : BarButtonItem {
    UIActivityIndicatorView *spinner;
    UIView *container;
}

@property (nonatomic, readonly) UIActivityIndicatorView *spinner;

- (id)initWithSize:(CGSize)size;

@end

