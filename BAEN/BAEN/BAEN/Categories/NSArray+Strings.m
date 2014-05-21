//
//  NSArray+Strings.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NSArray+Strings.h"


@implementation NSArray (Strings)

- (BOOL)containsString:(NSString *)string {
    for(NSString *element in self) {
        if([element isKindOfClass:[NSString class]] && [element isEqualToString:string])
            return true;
    }
    return false;
}

@end
