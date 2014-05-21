//
//  NETAnonymousSession.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"
#import "NETAnonymousSession.h"
#import "NETSubmission.h"

@implementation NETSession (NETAnonymousSession)

- (BOOL)isAnonymous {
    return NO;
}

@end

@implementation NETAnonymousSession

- (id)init {
    if ((self = [super initWithUsername:nil password:nil token:nil])) {
    }
    
    return self;
}

- (void)performSubmission:(NETSubmission *)submission target:(id)target action:(SEL)action {
    [target performSelector:action withObject:nil withObject:[NSNumber numberWithBool:NO]];
}

- (BOOL)isAnonymous {
    return YES;
}

- (NSString *)identifier {
    return @"NETKit-NETAnonymousSession";
}

- (void)reloadToken {
    // do nothing
}

@end
