//
//  ColorfulNavigationBar.h
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

// done-052314

#import <UIKit/UIKit.h>

@class ColorfulBarView;

@interface ColorfulNavigationBar : UINavigationBar
{
    ColorfulBarView *barView;
    
    NSTimer *_partyTimer;
    float partyHue;
}

@property (nonatomic, assign) BOOL colorful;

@property (nonatomic, assign) BOOL shouldParty;

@end
