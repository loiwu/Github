//
//  NETSubmission.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"
#import "NETAPISubmission.h"

#define kNETSubmissionSuccessNotification @"kNETSubmissionSuccessNotification"
#define kNETSubmissionFailureNotification @"kNETSubmissionFailureNotification"

typedef enum {
    kNETSubmissionTypeSubmission,
    kNETSubmissionTypeVote,
    kNETSubmissionTypeFlag,
    kNETSubmissionTypeReply
} NETSubmissionType;

@class NETEntry;
@interface NETSubmission : NSObject <NETAPISubmissionDelegate> {
    NETSubmissionType type;
    NETEntry *target;
    
    NSURL *destination;
    NSString *title;
    NSString *body;
    
    NETVoteDirection direction;
}

@property (nonatomic, readonly) NETSubmissionType type;
@property (nonatomic, retain) NETEntry *target;
@property (nonatomic, copy) NSURL *destination;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NETVoteDirection direction;

- (NETSubmission *)initWithSubmissionType:(NETSubmissionType)type_;

@end

