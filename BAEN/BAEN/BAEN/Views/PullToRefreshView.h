//
//  PullToRefreshView.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    PullToRefreshViewStateNormal = 0,
	PullToRefreshViewStateReady,
	PullToRefreshViewStateLoading
} PullToRefreshViewState;

@protocol PullToRefreshViewDelegate;

@interface PullToRefreshView : UIView {
	id<PullToRefreshViewDelegate> delegate;
    UIScrollView *scrollView;
	PullToRefreshViewState state;
    
	UILabel *lastUpdatedLabel;
	UILabel *statusLabel;
	CALayer *arrowImage;
	UIActivityIndicatorView *activityView;
}

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, assign) id<PullToRefreshViewDelegate> delegate;
@property (nonatomic, assign) PullToRefreshViewState state;

@property (nonatomic, copy) UIColor *textShadowColor;

- (void)refreshLastUpdatedDate;
- (void)finishedLoading;

- (id)initWithScrollView:(UIScrollView *)scrollView;

@end

@protocol PullToRefreshViewDelegate <NSObject>

@optional
- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
- (NSDate *)pullToRefreshViewLastUpdated:(PullToRefreshView *)view;

@end

