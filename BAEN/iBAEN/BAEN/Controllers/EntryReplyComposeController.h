//
//  EntryReplyComposeController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "ComposeController.h"

@interface EntryReplyComposeController : ComposeController {
    NETEntry *entry;
    UILabel *replyLabel;
}

@property (nonatomic, readonly, retain) NETEntry *entry;

- (id)initWithEntry:(NETEntry *)entry_;

@end
