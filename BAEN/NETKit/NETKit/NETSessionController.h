//
//  NETSessionController.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"

extern NSString *kNETSessionControllerSessionsChangedNotification;

@class NETSession;

@interface NETSessionController : NSObject {
    NSMutableArray *sessions;
}

+ (id)sessionController;

@property (nonatomic, copy, readonly) NSArray *sessions;
@property (nonatomic, retain) NETSession *recentSession;

- (NSInteger)numberOfSessions;

- (void)addSession:(NETSession *)session;
- (void)removeSession:(NETSession *)session;
- (void)moveSession:(NETSession *)session toIndex:(NSInteger)index;

- (void)refresh;

@end

