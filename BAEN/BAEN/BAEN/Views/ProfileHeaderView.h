//
//  ProfileHeaderView.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

@class NETUser;
@interface ProfileHeaderView : UIView {
    NETUser *user;
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    
    CGFloat padding;
}

+ (CGFloat)defaultHeight;

@property (nonatomic, retain) NETUser *user;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) CGFloat padding;

@end

