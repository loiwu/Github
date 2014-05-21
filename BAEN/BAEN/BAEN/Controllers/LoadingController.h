//
//  LoadingController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <MessageUI/MFMailComposeViewController.h>

#import <NETKit/NETKit.h>

#import "LoginController.h"

#import "BarButtonItem.h"
#import "ActivityIndicatorItem.h"
#import "PlacardButton.h"

@class LoadingIndicatorView;
@interface LoadingController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    NETObject *source;
    
    UIView *statusView;
    NSMutableSet *statusViews;
    
    PlacardButton *retryButton;
    LoadingIndicatorView *indicator;
    
    NSDate *lastUpdatedOnAppearDate;
    
    BarButtonItem *actionItem;
    NSInteger openInSafariIndex;
    NSInteger mailLinkIndex;
    NSInteger copyLinkIndex;
    NSInteger readLaterIndex;
}

@property (nonatomic, retain) NETObject *source;

- (id)initWithSource:(NETObject *)source_;
- (NSString *)sourceTitle;
- (void)finishedLoading;

- (void)addStatusView:(UIView *)view;
- (void)removeStatusView:(UIView *)view;
- (void)updateStatusDisplay;

- (void)sourceStartedLoading;
- (void)sourceFinishedLoading;
- (void)sourceFailedLoading;

@end

