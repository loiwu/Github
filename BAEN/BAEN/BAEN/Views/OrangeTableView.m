//
//  OrangeTableView.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "OrangeTableView.h"
#import "UIColor+Orange.h"

@implementation OrangeTableView
@synthesize orange;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame style:UITableViewStyleGrouped])) {
        if (![self respondsToSelector:@selector(separatorInset)]) {
            [self setBackgroundColor:[UIColor clearColor]];
            
            orangeBackgroundView = [[UIView alloc] initWithFrame:[self bounds]];
            [orangeBackgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
            
            [orangeBackgroundView setBackgroundColor:[UIColor paleOrangeColor]];
            
            tableBackgroundView = [[UITableView alloc] initWithFrame:[self bounds] style:UITableViewStyleGrouped];
            [tableBackgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        }
    }
    
    return self;
}

- (void)setOrange:(BOOL)orange_ {
    orange = orange_;
    
    if (orange) {
        [self setBackgroundView:orangeBackgroundView];
    } else {
        [self setBackgroundView:tableBackgroundView];
    }
}

@end
