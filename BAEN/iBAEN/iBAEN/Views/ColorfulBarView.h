//
//  ColorfulBarView.h
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

// done-052314

#import <UIKit/UIKit.h>

@interface ColorfulBarView : UIView

+ (UIColor *)barColorfulColor;

- (void)layoutInsideBar:(UIView *)barView;

@end
