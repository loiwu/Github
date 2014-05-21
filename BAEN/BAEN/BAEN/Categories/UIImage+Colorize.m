//
//  UIImage+Colorize.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "UIImage+Colorize.h"

@implementation UIImage (Colorize)

- (UIImage *)imageTintedToColor:(UIColor *)color {
    UIGraphicsBeginImageContext([self size]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // flip to UIKit coordinates
    CGContextTranslateCTM(context, 0, [self size].height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, [self size].width, [self size].height);
    CGContextDrawImage(context, rect, [self CGImage]);
    
    [color setFill];
    CGContextClipToMask(context, rect, [self CGImage]);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    UIImage *colored = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colored;
}

@end
