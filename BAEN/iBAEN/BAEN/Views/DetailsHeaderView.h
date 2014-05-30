//
//  DetailsHeaderView.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "BodyTextView.h"

@protocol DetailsHeaderViewDelegate;

@class NETEntry;
@interface DetailsHeaderView : UIView <BodyTextViewDelegate> {
    NETEntry *entry;
    __weak id<DetailsHeaderViewDelegate> delegate;
    
    UIView *detailsHeaderContainer;
    UIView *containerContainer;
    BodyTextView *bodyTextView;
    
    BOOL highlighted;
    BOOL navigationCancelled;
}

@property (nonatomic, assign) id<DetailsHeaderViewDelegate> delegate;
@property (nonatomic, retain) NETEntry *entry;
@property (nonatomic, assign, getter = isHighlighted) BOOL highlighted;

- (id)initWithEntry:(NETEntry *)entry_ widthWidth:(CGFloat)width;
- (CGFloat)suggestedHeightWithWidth:(CGFloat)width;
+ (CGSize)offsets;

@end

@protocol DetailsHeaderViewDelegate<NSObject>
@optional

- (void)detailsHeaderView:(DetailsHeaderView *)header selectedURL:(NSURL *)url;

@end

