//
//  ColorfulToolbar.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorfulBarView;

@interface ColorfulToolbar : UIToolbar {
    ColorfulBarView *barView;
    
    NSTimer *_partyTimer;
    float partyHue;
}

@property (nonatomic, assign) BOOL colorful;

@property (nonatomic, assign) BOOL shouldParty;

@end

