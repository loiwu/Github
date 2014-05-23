//
//  NSString+URLEncoding.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)stringByURLEncodingString {
    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef) self, NULL, (CFStringRef) @"!*'\"();:@&=+$,/?%#[]% ", kCFStringEncodingUTF8);
    return [(NSString *) encoded autorelease];
}

@end
