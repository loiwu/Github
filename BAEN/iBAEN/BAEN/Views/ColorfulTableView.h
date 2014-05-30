//
//  ColorfulTableView.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorfulTableView : UITableView {
    UIView *tableBackgroundView;
    UIView *colorfulBackgroundView;
    BOOL colorful;
}

@property (nonatomic, assign) BOOL colorful;

@end
