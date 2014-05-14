//
//  BNRItemStore.h
//  HomePwner
//
//  Created by John Gallagher on 1/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

//No need to import BNRItem.h here, and can speed up the compile times considerably 
@class BNRItem; //@class directice tells the compiler that there is a BNRItem class

@interface BNRItemStore : NSObject
//BNRItemStore returns a immutable NSArray to represent the array of items and declares the property as readonly
//Internally, it needs to be mutate the array
@property (nonatomic, readonly) NSArray *allItems;

// Notice that this is a class method and prefixed with a + instead of a -
+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;

- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex;

- (BOOL)saveChanges;

- (NSArray *)allAssetTypes;

@end
