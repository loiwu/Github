//
//  NETUser.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NETObject.h"

#ifdef NETKIT_RENDERING_ENABLED
@class NETObjectBodyRenderer;
#endif

@interface NETUser : NETObject {
    NSInteger karma;
    float average;
    NSString *created;
    NSString *about;
#ifdef NETKIT_RENDERING_ENABLED
    NETObjectBodyRenderer *renderer;
#endif
}

@property (nonatomic, assign) NSInteger karma;
@property (nonatomic, assign) float average;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *about;
#ifdef NETKIT_RENDERING_ENABLED
@property (nonatomic, readonly) NETObjectBodyRenderer *renderer;
#endif

+ (id)session:(NETSession *)session userWithIdentifier:(id)identifier_;

@end

