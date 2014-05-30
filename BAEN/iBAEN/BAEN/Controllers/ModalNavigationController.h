//
//  ModalNavigationController.h
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "NavigationController.h"

#import "BarButtonItem.h"

@interface ModalNavigationController : NavigationController <UINavigationControllerDelegate> {
    BarButtonItem *doneItem;
    UIViewController *currentController;
}

@end

