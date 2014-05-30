//
//  LoadMoreCell.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "LoadMoreCell.h"

@implementation LoadMoreCell
@synthesize button;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        button = [[LoadMoreButton alloc] initWithFrame:[self bounds]];
        [button setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self addSubview:button];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        // Hide the cell separator by giving it zero width.
        [self setSeparatorInset:UIEdgeInsetsMake(0, self.bounds.size.width, 0, 0)];
    }
}

- (void)dealloc {
    [button release];
    
    [super dealloc];
}

@end
