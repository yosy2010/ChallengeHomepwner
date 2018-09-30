//
//  BNRItem.h
//  RandomItem
//
//  Created by YASSER ALTAMIMI on 16/09/2018.
//  Copyright © 2018 YASSER ALTAMIMI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

// properties:
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;
@property (nonatomic, strong) NSString *itemKey; // to hold a distinct key for every item


// methods:
// class methods:
+(instancetype) randomItem;

// instance methods:
// initilizers:
// designated initilizer:
-(instancetype) initWithItemName: (NSString *) itemName
                  valueInDollars: (int) valueInDollars
                    serilaNumber: (NSString *) serialNumber;
// another initilizer:
-(instancetype) initWithItemName: (NSString *) itemName;
// and another:
-(instancetype) initWithName: (NSString *) name serialNumber: (NSString *) serialNumber;


@end
