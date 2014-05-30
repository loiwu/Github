//
//  NETTimeline.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <NETKit/NETEntryList.h>

#ifdef ENABLE_TIMELINE

#define kNETEntryListIdentifierTimeline @"timeline"

@class NETSession;

@interface NETTimeline : NETEntryList {
    NETSession *session;
    NSMutableSet *loadingUsers;
    NSMutableSet *loadedUsers;
}

+ (NETTimeline *)timelineForSession:(NETSession *)session;

@end

#endif
