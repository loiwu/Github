//
//  ModalNavigationController.m
//  BAEN
//
//  Created by loi on 5/21/14.
//  Copyright (c) 2014 GWrabbit. All rights reserved.
//

#import "ModalNavigationController.h"

#import "UINavigationItem+MultipleItems.h"

@implementation ModalNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setModalPresentationStyle:UIModalPresentationFormSheet];
    [self setDelegate:self];
    
    doneItem = [[BarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Don't release doneItem here, because we depend on it staying the same
    // object for the lifetime of this navigation controller (for removal).
}

- (void)dealloc {
    [doneItem release];
    
    [super dealloc];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [[currentController navigationItem] removeRightBarButtonItem:doneItem];
    [[viewController navigationItem] addRightBarButtonItem:doneItem atPosition:UINavigationItemPositionRight];
    
    currentController = viewController;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

AUTOROTATION_FOR_PAD_ONLY

@end

