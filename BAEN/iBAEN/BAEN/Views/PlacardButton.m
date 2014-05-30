//
//  PlacardButton.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "PlacardButton.h"

@implementation PlacardButton

+ (UIImage *)_normalImage {
    UIImage *image = [UIImage imageNamed:@"UIPlacardButtonBkgnd.png"];
    return [image stretchableImageWithLeftCapWidth:8 topCapHeight:22];
}

+ (UIImage *)_pressedImage {
    UIImage *image = [UIImage imageNamed:@"UIPlacardButtonPressedBkgnd.png"];
    return [image stretchableImageWithLeftCapWidth:8 topCapHeight:22];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        if (![UIView instancesRespondToSelector:@selector(tintColor)]) {
            [self setBackgroundImage:[[self class] _normalImage] forState:UIControlStateNormal];
            [self setBackgroundImage:[[self class] _pressedImage] forState:UIControlStateHighlighted];
            [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
            [[self titleLabel] setFont:[UIFont boldSystemFontOfSize:14.0f]];
        } else {
            [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [self setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
            [[self titleLabel] setFont:[UIFont systemFontOfSize:22.0f]];
        }
    }
    
    return self;
}

@end

