//
//  NETAPIRequest.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

@interface NETAPIRequest : NSObject {
    NETSession *session;
    
    id target;
    SEL action;
    NSMutableData *received;
    NSURLConnection *connection;
    NSString *path;
}

- (NETAPIRequest *)initWithSession:(NETSession *)session_ target:(id)target_ action:(SEL)action_;
- (void)performRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
- (void)cancelRequest;
- (BOOL)isLoading;

@end

