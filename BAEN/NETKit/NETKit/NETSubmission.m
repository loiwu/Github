//
//  NETSubmission.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETSubmission.h"

@implementation NETSubmission
@synthesize type, target, destination, title, body, direction;

- (id)initWithSubmissionType:(NETSubmissionType)type_ {
    if ((self = [super init])) {
        type = type_;
    }
    
    return self;
}

- (void)submissionCompletedSuccessfully:(BOOL)successfully withError:(NSError *)error {
    if (successfully) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNETSubmissionSuccessNotification object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNETSubmissionFailureNotification object:self userInfo:[NSDictionary dictionaryWithObject:error forKey:@"error"]];
    }
}

- (void)dealloc {
    [target release];
    [destination release];
    [body release];
    [title release];
    
    [super dealloc];
}

@end
