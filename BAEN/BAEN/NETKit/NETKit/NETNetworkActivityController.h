//
//  NETNetworkActivityController.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NETNetworkActivityController : NSObject

+ (void (^)())newtorkActivityBeganBlock;
+ (void)setNetworkActivityBeganBlock:(void (^)())block;

+ (void (^)())newtorkActivityEndedBlock;
+ (void)setNetworkActivityEndedBlock:(void (^)())block;

+ (void)networkActivityBegan;
+ (void)networkActivityEnded;

@end