//
//  NETNetworkActivityController.m
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETNetworkActivityController.h"

@implementation NETNetworkActivityController

static void (^networkActivityBeganBlock)();
static void (^networkActivityEndedBlock)();

+ (void (^)())newtorkActivityBeganBlock {
    return networkActivityBeganBlock;
}

+ (void)setNetworkActivityBeganBlock:(void (^)())block {
    if (networkActivityBeganBlock != block) {
        [networkActivityBeganBlock release];
        networkActivityBeganBlock = [block copy];
    }
}

+ (void (^)())newtorkActivityEndedBlock {
    return networkActivityEndedBlock;
}

+ (void)setNetworkActivityEndedBlock:(void (^)())block {
    if (networkActivityEndedBlock != block) {
        [networkActivityEndedBlock release];
        networkActivityEndedBlock = [block copy];
    }
}

+ (void)networkActivityBegan {
    if (networkActivityBeganBlock != NULL) {
        networkActivityBeganBlock();
    }
}

+ (void)networkActivityEnded {
    if (networkActivityEndedBlock != NULL) {
        networkActivityEndedBlock();
    }
}

@end

