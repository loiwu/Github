//
//  NETAPISubmission.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

@protocol NETAPISubmissionDelegate;

typedef enum {
    kNETAPISubmissionLoadingStateReady,
    kNETAPISubmissionLoadingStateFormTokens,
    kNETAPISubmissionLoadingStateFormSubmit
} NETAPISubmissionLoadingState;

@class NETSubmission;
@interface NETAPISubmission : NSObject {
    NETSession *session;
    NETSubmission *submission;
    
    NETAPISubmissionLoadingState loadingState;
    NSMutableData *received;
    NSURLConnection *connection;
}

@property (nonatomic, readonly, retain) NETSubmission *submission;

- (id)initWithSession:(NETSession *)session_ submission:(NETSubmission *)submission_;
- (void)performSubmission;
- (BOOL)isLoading;

@end

@protocol NETAPISubmissionDelegate
@optional

- (void)submissionCompletedSuccessfully:(BOOL)successfully withError:(NSError *)error;

@end

