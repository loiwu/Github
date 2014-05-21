//
//  HackerNewsLoginController.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "HackerNewsLoginController.h"

#import "UIColor+Orange.h"

@implementation HackerNewsLoginController
@synthesize session;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [topLabel setText:@"Hacker News"];
    [bottomLabel setText:@"Your info is only shared with Hacker News."];
    
    if ([self respondsToSelector:@selector(topLayoutGuide)]) {
        [topLabel setTextColor:[UIColor blackColor]];
        [bottomLabel setTextColor:[UIColor darkGrayColor]];
        
        [topLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:34.0]];
    } else {
        [topLabel setTextColor:[UIColor whiteColor]];
        [topLabel setShadowColor:[UIColor blackColor]];
        [bottomLabel setTextColor:[UIColor whiteColor]];
        
        [topLabel setFont:[UIFont boldSystemFontOfSize:30.0f]];
        [topLabel setShadowOffset:CGSizeMake(0, 1.0f)];
    }
    
    [bottomLabel setFont:[UIFont systemFontOfSize:14.0f]];
}

- (BOOL)requiresPassword {
    return YES;
}

- (void)sessionAuthenticatorDidRecieveFailure:(NETSessionAuthenticator *)authenticator {
    [authenticator autorelease];
    [self finish];
    [self fail];
}

- (void)sessionAuthenticator:(NETSessionAuthenticator *)authenticator didRecieveToken:(NETSessionToken)token {
    session = [[NETSession alloc] initWithUsername:[usernameField text] password:[passwordField text] token:token];
    [[NETSessionController sessionController] addSession:session];
    [authenticator autorelease];
    
    [self finish];
    [self succeed];
}

- (void)dealloc {
    [session release];
    
    [super dealloc];
}

- (NSArray *)gradientColors {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:(id) [[UIColor lightOrangeColor] CGColor]];
    [array addObject:(id) [[UIColor mainOrangeColor] CGColor]];
    return array;
}

- (void)authenticate {
	[super authenticate];
    
    NSString *username = [usernameField text];
    
    for (NETSession *session_ in [[NETSessionController sessionController] sessions]) {
        if ([[session_ identifier] isEqual:username]) {
            [self finish];
            [self fail];
            return;
        }
    }
    
    NETSessionAuthenticator *authenticator = [[NETSessionAuthenticator alloc] initWithUsername:username password:[passwordField text]];
    [authenticator setDelegate:self];
    [authenticator beginAuthenticationRequest];
}

AUTOROTATION_FOR_PAD_ONLY

@end
