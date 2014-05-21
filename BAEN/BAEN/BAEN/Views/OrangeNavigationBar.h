//
//  OrangeNavigationBar.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrangeBarView;

@interface OrangeNavigationBar : UINavigationBar {
    OrangeBarView *barView;
    
    NSTimer *_partyTimer;
    float partyHue;
}

@property (nonatomic, assign) BOOL orange;

@property (nonatomic, assign) BOOL shouldParty;

@end
