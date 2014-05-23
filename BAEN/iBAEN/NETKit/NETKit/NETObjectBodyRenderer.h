//
//  NETObjectBodyRenderer.h
//  NETKit
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NETShared.h"

#ifdef NETKIT_RENDERING_ENABLED

#import <CoreText/CoreText.h>

@class NETObject;

@interface NETObjectBodyRenderer : NSObject {
    NETObject *object;
    
    NSAttributedString *attributed;
    CTFramesetterRef framesetter;
}

@property (nonatomic, readonly, assign) NETObject *object;

@property (nonatomic, readonly, copy) NSString *HTMLString;
@property (nonatomic, readonly, copy) NSAttributedString *attributedString;
@property (nonatomic, readonly, copy) NSString *string;

+ (CGFloat)defaultFontSize;
+ (void)setDefaultFontSize:(CGFloat)size;

- (id)initWithObject:(NETObject *)object;

- (CGSize)sizeForWidth:(CGFloat)width;
- (void)renderInContext:(CGContextRef)context rect:(CGRect)rect;
- (NSURL *)linkURLAtPoint:(CGPoint)point forWidth:(CGFloat)width rects:(NSSet **)rects;

@end

#endif

