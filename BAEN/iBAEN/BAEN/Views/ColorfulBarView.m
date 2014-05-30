//
//  ColorfulBarView.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <objc/runtime.h>

#import "ColorfulBarView.h"
#import "UIColor+Colorful.h"



@implementation ColorfulBarView

+ (void)load {
    // Revert iOS 7.0.3+ back to the blurring style from iOS 7.0.2 and below.
    Class _UIBackdropViewSettingsColored = NSClassFromString(@"_UIBackdropViewSettingsColored");
    Class _UIBackdropViewSettingsUltraColored = NSClassFromString(@"_UIBackdropViewSettingsUltraColored");
    
    if (_UIBackdropViewSettingsColored != nil && _UIBackdropViewSettingsUltraColored != nil) {
        SEL setDefaultValues = @selector(setDefaultValues);
        
        Method coloredMethod = class_getInstanceMethod(_UIBackdropViewSettingsColored, setDefaultValues);
        Method ultraColoredMethod = class_getInstanceMethod(_UIBackdropViewSettingsUltraColored, setDefaultValues);
        
        if (coloredMethod != NULL && ultraColoredMethod != NULL) {
            method_setImplementation(ultraColoredMethod, method_getImplementation(coloredMethod));
        }
    }
}

+ (UIColor *)barColorfulColor {
    return [UIColor mainColorfulColor];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setUserInteractionEnabled:NO];
        
        [self setAlpha:0.3];
        [self setBackgroundColor:[UIColor mainColorfulColor]];
    }
    
    return self;
}

- (void)layoutInsideBar:(UIView *)barView {
    // Hack to deepen the bar's color.
    self.frame = [[[[barView layer] sublayers] objectAtIndex:0] frame];
    [[barView layer] insertSublayer:[self layer] atIndex:1];
}

@end
