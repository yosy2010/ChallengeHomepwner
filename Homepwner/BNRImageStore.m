//
//  BNRImageStore.m
//  Homepwner
//
//  Created by YASSER ALTAMIMI on 30/09/2018.
//  Copyright © 2018 YASSER ALTAMIMI. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *privateDictionary;

@end

@implementation BNRImageStore

// global store
+ (instancetype)SharedStore
{
    static BNRImageStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc]initPrivate];
    }
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"use [BNRImageStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        _privateDictionary = [[NSMutableDictionary alloc]init];
    }
    
    return self;
}

// setting and getting and deletign the images debending on the key they have
- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.privateDictionary[key] = image;
}

- (UIImage *)imageforKey:(NSString*)key
{
    return self.privateDictionary[key];
}
-(void)deleteImageForKey:(NSString *)key
{
    [self.privateDictionary removeObjectForKey:key];
}


@end
