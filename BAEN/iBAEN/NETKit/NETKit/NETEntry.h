//
//  NETEntry.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETShared.h"
#import "NETContainer.h"

#ifdef NETKIT_RENDERING_ENABLED
@class NETObjectBodyRenderer;
#endif

@class NETUser;
@interface NETEntry : NETContainer {
    NSInteger points;
    NSInteger children;
    NETUser *submitter;
    NSString *body;
    NSString *posted;
    NETEntry *parent;
    NETEntry *submission;
    NSURL *destination;
    NSString *title;
#ifdef NETKIT_RENDERING_ENABLED
    NETObjectBodyRenderer *renderer;
#endif
}

@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) NSInteger children;
@property (nonatomic, retain) NETUser *submitter;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, retain) NSString *posted;
@property (nonatomic, retain) NETEntry *parent;
@property (nonatomic, retain) NETEntry *submission;
@property (nonatomic, copy) NSURL *destination;
@property (nonatomic, copy) NSString *title;
#ifdef NETKIT_RENDERING_ENABLED
@property (nonatomic, readonly) NETObjectBodyRenderer *renderer;
#endif

- (BOOL)isComment;
- (BOOL)isSubmission;

+ (id)session:(NETSession *)session entryWithIdentifier:(id)identifier_;

@end
