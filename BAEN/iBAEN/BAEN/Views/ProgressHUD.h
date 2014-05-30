//
//  ProgressHUD.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#define kProgressHUDStateLoading @"loading"
#define kProgressHUDStateCompleted @"completed"
#define kProgressHUDStateError @"error"
typedef NSString *ProgressHUDState;

@interface ProgressHUD : UIView {
    UIActivityIndicatorView *spinner;
    UIImageView *image;
    UILabel *label;
    NSString *text;
    UIView *overlay;
    ProgressHUDState state;
}

@property (nonatomic, copy) NSString *text;
@property (nonatomic, readonly) UILabel *label;
@property (nonatomic, copy) ProgressHUDState state;

- (void)showInWindow:(UIWindow *)window;
- (void)dismiss;
- (void)dismissWithAnimation:(BOOL)animated;
- (void)dismissAfterDelay:(NSTimeInterval)delay;
- (void)dismissAfterDelay:(NSTimeInterval)delay animated:(BOOL)animated;

@end
