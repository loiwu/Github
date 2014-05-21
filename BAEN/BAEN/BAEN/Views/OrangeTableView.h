//
//  OrangeTableView.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrangeTableView : UITableView {
    UIView *tableBackgroundView;
    UIView *orangeBackgroundView;
    BOOL orange;
}

@property (nonatomic, assign) BOOL orange;

@end
