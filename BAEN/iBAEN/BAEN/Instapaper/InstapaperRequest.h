//
//  InstapaperRequest.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "InstapaperAPI.h"

@class InstapaperSession;
@interface InstapaperRequest : NSObject {
    InstapaperSession *session;
}

@property (nonatomic, readonly) InstapaperSession *session;

- (void)addItemWithURL:(NSURL *)url title:(NSString *)title selection:(NSString *)selection;
- (void)addItemWithURL:(NSURL *)url title:(NSString *)title;
- (void)addItemWithURL:(NSURL *)url;

- (id)initWithSession:(InstapaperSession *)session_;

@end

#define kInstapaperRequestSucceededNotification @"instapaper-request-completed"
#define kInstapaperRequestFailedNotification @"instapaper-request-failed"

