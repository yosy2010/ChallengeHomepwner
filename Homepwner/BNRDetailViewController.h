//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by YASSER ALTAMIMI on 26/09/2018.
//  Copyright © 2018 YASSER ALTAMIMI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem; // so it knows about it

NS_ASSUME_NONNULL_BEGIN

@interface BNRDetailViewController : UIViewController

@property (nonatomic, strong)BNRItem *item; // tom hold the passed item from the BNRItemsViewController

@end

NS_ASSUME_NONNULL_END
