//
//  NETAnonymousSession.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"
#import "NETSession.h"

@interface NETAnonymousSession : NETSession

@end

@interface NETSession (NETAnonymousSession)

@property (nonatomic, readonly) BOOL isAnonymous;

@end
