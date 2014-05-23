//
//  NETContainer.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETShared.h"
#import "NETObject.h"

#define kNETContainerLoadingStateLoadingMore 0x00010000

@interface NETContainer : NETObject {
    NSArray *entries;
    
    NETMoreToken moreToken;
    NETAPIRequest *moreRequest;
    NSArray *pendingMoreEntries;
}

@property (nonatomic, retain) NSArray *entries;
@property (nonatomic, copy) NETMoreToken moreToken;

- (void)beginLoadingMore;
- (BOOL)isLoadingMore;
- (void)cancelLoadingMore;

- (void)loadMoreFromDictionary:(NSDictionary *)dictionary complete:(BOOL)complete;

@end

