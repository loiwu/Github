//
//  ForceClearNavigationBar.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "ForceClearNavigationBar.h"

@implementation ForceClearNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        // Have to use 0.001 or UINavigationController thinks its hidden.
        [self setAlpha:0.001];
    }
    
    return self;
}

- (void)setAlpha:(CGFloat)alpha
{
    // Have to use 0.001 or UINavigationController thinks its hidden.
    [super setAlpha:0.001];
}

@end

