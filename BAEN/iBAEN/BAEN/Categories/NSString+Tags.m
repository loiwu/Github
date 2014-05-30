//
//  NSString+Tags.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NSString+Tags.h"

@implementation NSString (Tags)

- (NSString *)stringByRemovingHTMLTags {
    NSString *html = self;
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([scanner isAtEnd] == NO) {
        [scanner scanUpToString:@"<" intoString:NULL];
        [scanner scanUpToString:@">" intoString:&text];
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
    }
    
    return html;
}

@end
