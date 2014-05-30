//
//  ColorfulTableView.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "ColorfulTableView.h"
#import "UIColor+Colorful.h"

@implementation ColorfulTableView
@synthesize colorful;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame style:UITableViewStyleGrouped])) {
        if (![self respondsToSelector:@selector(separatorInset)]) {
            [self setBackgroundColor:[UIColor clearColor]];
            
            colorfulBackgroundView = [[UIView alloc] initWithFrame:[self bounds]];
            [colorfulBackgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            
            [colorfulBackgroundView setBackgroundColor:[UIColor paleColorfulColor]];
            
            tableBackgroundView = [[UITableView alloc] initWithFrame:[self bounds] style:UITableViewStyleGrouped];
            [tableBackgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        }
    }
    
    return self;
}

- (void)setColorful:(BOOL)colorful_ {
    colorful = colorful_;
    
    if (colorful) {
        [self setBackgroundView:colorfulBackgroundView];
    } else {
        [self setBackgroundView:tableBackgroundView];
    }
}

@end
