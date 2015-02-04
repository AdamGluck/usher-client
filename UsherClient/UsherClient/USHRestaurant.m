//
//  USHRestaurant.m
//  UsherClient
//
//  Created by Adam Gluck on 2/4/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import "USHRestaurant.h"

@implementation USHRestaurant

- (instancetype)initWithRestaurantInfo:(NSDictionary *)restaurantInfo
{
    self = [super init];
    if (self) {
        _waitTime = [restaurantInfo[@"waitTime"] integerValue];
        _name = restaurantInfo[@"name"];
        _descriptors = restaurantInfo[@"descriptors"];
        
    }
    return self;
}

@end
