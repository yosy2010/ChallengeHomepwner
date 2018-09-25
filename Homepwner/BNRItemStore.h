//
//  BNRItemStore.h
//  Homepwner
//
//  Created by YASSER ALTAMIMI on 22/09/2018.
//  Copyright © 2018 YASSER ALTAMIMI. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem; // to tell the header there is a file by that name

NS_ASSUME_NONNULL_BEGIN

@interface BNRItemStore : NSObject

// properties
@property (nonatomic, readonly) NSArray *allItems; // the interface here says that this is NSArray so other object will treat as one even if we return an NSMUtable array

// class method to singlize this object (only one instance of it will ever be created)
+ (instancetype)sharedStore;

- (BNRItem *)createItem; // this will create a random item
- (void)removeItem: (BNRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end

NS_ASSUME_NONNULL_END
