//
//  ColorfulNavigationBar.m
//  iBAEN
//
//  Created by loi on 5/23/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

// done-052314

#import "UIColor+Colorful.h"
#import "ColorfulBarView.h"
#import "ColorfulNavigationBar.h"

@implementation ColorfulNavigationBar
@synthesize colorful;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        if ([self respondsToSelector:@selector(barTintColor)]) {
            barView = [[ColorfulBarView alloc] init];
            [barView setHidden:YES];
            
            UITapGestureRecognizer *tripleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                         action:@selector(startTheParty:)];
            tripleTapGestureRecognizer.numberOfTapsRequired = 3;
            [self addGestureRecognizer:tripleTapGestureRecognizer];
            
            self.shouldParty = [[NSUserDefaults standardUserDefaults] boolForKey:@"PartyStarted"];
        }
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [barView layoutInsideBar:self];
}

- (void)dealloc {
    [barView release];
    
    [super dealloc];
}

- (void)setColorful:(BOOL)colorful_ {
    colorful = colorful_;
    
    if (colorful) {
        if ([self respondsToSelector:@selector(setBarTintColor:)]) {
            [self setBarTintColor:[ColorfulBarView barColorfulColor]];
            [self setTintColor:[UIColor whiteColor]];
            
            NSDictionary *titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
            [self setTitleTextAttributes:titleTextAttributes];
        } else {
            [self setTintColor:[UIColor mainColorfulColor]];
        }
    } else {
        if ([self respondsToSelector:@selector(setBarTintColor:)]) {
            [self setBarTintColor:nil];
        }
        
        [self setTintColor:nil];
        [self setTitleTextAttributes:nil];
    }
    
    [barView setHidden:!colorful];
}

#pragma mark -
#pragma mark Party Mode

- (void)setPartyTimer:(NSTimer *)partyTimer {
    if (partyTimer == _partyTimer)
        return;
    
    [_partyTimer invalidate];
    _partyTimer = partyTimer;
}

- (void)startTheParty:(UIGestureRecognizer *)sender {
    BOOL isPartying = self.shouldParty;
    self.shouldParty = !isPartying;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:!isPartying forKey:@"PartyStarted"];
    [userDefaults synchronize];
}

- (void)setShouldParty:(BOOL)shouldParty {
    _shouldParty = shouldParty;
    
    if (shouldParty) {
        NSTimer *partyTimer = [NSTimer timerWithTimeInterval:1.0 / 30.0
                                                      target:self
                                                    selector:@selector(keepThePartyGoing:)
                                                    userInfo:nil
                                                     repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:partyTimer forMode:NSRunLoopCommonModes];
        self.partyTimer = partyTimer;
    } else {
        self.partyTimer = nil;
        self.colorful = colorful;
    }
}

- (void)keepThePartyGoing:(NSTimer *)timer {
    partyHue += 1.0f / 360.0f;
    if (partyHue > 1.0f)
        partyHue = 0.0f;
    
    UIColor *partyColor = [UIColor colorWithHue:partyHue
                                     saturation:1.0f
                                     brightness:1.0f
                                          alpha:1.0f];
    
    if ([self respondsToSelector:@selector(setBarTintColor:)]) {
        [self setBarTintColor:partyColor];
        [self setTintColor:[UIColor whiteColor]];
        
        NSDictionary *titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        [self setTitleTextAttributes:titleTextAttributes];
    } else {
        [self setTintColor:partyColor ];
    }
}

@end
