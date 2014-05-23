//
//  NETAPISearch.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETKit.h"

#import "NSString+URLEncoding.h"

@interface NETAPISearch : NSObject {
    NETSession *session;
    
	NSMutableData *responseData;
	NSMutableArray *entries;
	NETSearchType searchType;
    
    NSDateFormatter *dateFormatter;
}

@property (nonatomic, retain, readonly) NETSession *session;
@property (nonatomic, retain) NSMutableArray *entries;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, assign) NETSearchType searchType;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;

- (id)initWithSession:(NETSession *)session_;

- (void)handleResponse;
- (NSDictionary *)itemFromRaw:(NSDictionary *)rawDictionary;
- (void)performSearch:(NSString *)searchQuery;

@end

