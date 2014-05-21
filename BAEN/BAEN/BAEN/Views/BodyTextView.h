//
//  BodyTextView.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <NETKit/NETKit.h>

@protocol BodyTextViewDelegate;

@interface BodyTextView : UIView {
    NETObjectBodyRenderer *renderer;
    __weak id<BodyTextViewDelegate> delegate;
    
    UILongPressGestureRecognizer *linkLongPressRecognizer;
    
    UIView *bodyTextRenderView;
    NSSet *highlightedRects;
}

@property (nonatomic, retain) NETObjectBodyRenderer *renderer;
@property (nonatomic, assign) id<BodyTextViewDelegate> delegate;

- (BOOL)linkHighlighted;

- (void)drawContentView:(CGRect)rect;

@end

@protocol BodyTextViewDelegate <NSObject>
@optional

- (void)bodyTextView:(BodyTextView *)header selectedURL:(NSURL *)url;

@end

