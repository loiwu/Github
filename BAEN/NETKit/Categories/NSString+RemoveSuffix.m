//
//  NSString+RemoveSuffix.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NSString+RemoveSuffix.h"

@implementation NSString (RemoveSuffix)

- (NSString *)stringByRemovingSuffix:(NSString *)s {
    if([self hasSuffix:s])
        self = [self substringToIndex:[self length] - [s length]];
    return self;
}

@end
