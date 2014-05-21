//
//  LoadMoreButton.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "LoadingIndicatorView.h"

@interface LoadMoreButton : UIButton {
    LoadingIndicatorView *indicatorView;
    UILabel *moreLabel;
}

- (void)startLoading;
- (void)stopLoading;

@end

