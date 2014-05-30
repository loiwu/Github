//
//  ColorfulBarView.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorfulBarView : UIView

+ (UIColor *)barColorfulColor;

- (void)layoutInsideBar:(UIView *)barView;

@end
