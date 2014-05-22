//
//  UIColor+Orange.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

// -loi- // Control the main UI dominant tone - choose blue

#import "UIColor+Orange.h"

@implementation UIColor (Orange)

+ (UIColor *)mainOrangeColor {
    return [UIColor colorWithRed:(65.0f / 255.0f) green:(105.0f / 255.0f) blue:(225.0f / 255.0f) alpha:1.0f];
}

+ (UIColor *)lightOrangeColor {
    return [UIColor colorWithRed:(30.0f / 255.0f) green:(144.0f / 255.0f) blue:(255.0f / 255.0f) alpha:1.0f];
}

+ (UIColor *)paleOrangeColor {
    return [UIColor colorWithRed:(176.0f / 255.0f) green:(196.0f / 255.0f) blue:(222.0f / 255.0f) alpha:1.0f];
}

@end
