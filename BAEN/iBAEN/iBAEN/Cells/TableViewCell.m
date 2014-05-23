//
//  TableViewCell.m
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCellView : UIView {
    __weak TableViewCell *cell;
}
@end

@implementation TableViewCellView

- (id)initWithCell:(TableViewCell *)cell_ {
    if ((self = [super initWithFrame:CGRectZero])) {
        cell = cell_;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
	[cell drawContentView:rect];
}

@end

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		contentView = [[TableViewCellView alloc] initWithCell:self];
		[contentView setOpaque:YES];
		[self.contentView addSubview:contentView];
		[contentView release];
    }
    
    return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
    
	[contentView setFrame:[[self contentView] bounds]];
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[contentView setNeedsDisplay];
}

- (void)drawContentView:(CGRect)rect {
	// subclasses should implement this
}

@end
