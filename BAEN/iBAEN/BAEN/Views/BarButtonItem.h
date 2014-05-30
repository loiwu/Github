//
//  BarButtonItem.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

@interface BarButtonItem : UIBarButtonItem {
    UIView *buttonView;
    
    id realTarget;
    SEL realAction;
}

@property (nonatomic, readonly) UIView *buttonView;

@end

@interface UIPopoverController (BarButtonItem)

- (void)presentPopoverFromBarButtonItemInWindow:(BarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

@end

@interface UIActionSheet (BarButtonItem)

- (void)showFromBarButtonItemInWindow:(BarButtonItem *)item animated:(BOOL)animated;

@end

