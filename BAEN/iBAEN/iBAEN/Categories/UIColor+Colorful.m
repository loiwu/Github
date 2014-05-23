//
//  UIColor+Colorful.m
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

// done-052314

#import "UIColor+Colorful.h"

@implementation UIColor (Colorful)

+ (UIColor *)mainColorfulColor
{
    //return [UIColor colorWithRed:(65.0f / 255.0f) green:(105.0f / 255.0f) blue:(225.0f / 255.0f) alpha:1.0f];
    return [UIColor colorWithRed:(218.0f / 255.0f) green:(165.0f / 255.0f) blue:(32.0f / 255.0f) alpha:1.0f];
}

+ (UIColor *)lightColorfulColor {
    return [UIColor colorWithRed:(30.0f / 255.0f) green:(144.0f / 255.0f) blue:(255.0f / 255.0f) alpha:1.0f];
}

+ (UIColor *)paleColorfulColor {
    return [UIColor colorWithRed:(176.0f / 255.0f) green:(196.0f / 255.0f) blue:(222.0f / 255.0f) alpha:1.0f];
}

@end
