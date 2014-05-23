//
//  TableViewCell.h
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell {
	UIView *contentView;
    BOOL showsDividing;
}

- (void)drawContentView:(CGRect)rect; // subclasses should implement

@end
