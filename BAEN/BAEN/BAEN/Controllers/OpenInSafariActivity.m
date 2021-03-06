//
//  OpenInSafariActivity.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "OpenInSafariActivity.h"

@implementation OpenInSafariActivity

- (void)dealloc {
    [url release];
    
    [super dealloc];
}

- (NSString *)activityType {
    return @"com.apple.safari.open-in";
}

- (NSString *)activityTitle {
    return @"Open in Safari";
}

- (UIImage *)activityImage {
    if ([[self class] respondsToSelector:@selector(activityCategory)]) {
        return [UIImage imageNamed:@"openinsafari7.png"];
    } else {
        return [UIImage imageNamed:@"openinsafari.png"];
    }
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    [url release];
    
    url = [[activityItems lastObject] copy];
}

- (void)performActivity {
    [[UIApplication sharedApplication] openURL:url];
    [self activityDidFinish:YES];
}

@end

