//
//  BNRImageStore.h
//  Homepwner
//
//  Created by YASSER ALTAMIMI on 30/09/2018.
//  Copyright © 2018 YASSER ALTAMIMI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRImageStore : NSObject

// global store
+ (instancetype)SharedStore;

// setting and getting and deletign the images debending on the key they have
- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageforKey:(NSString*)key;
-(void)deleteImageForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
