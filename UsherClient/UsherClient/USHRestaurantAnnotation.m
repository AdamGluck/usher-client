//
//  USHRestaurantAnnotation.m
//  UsherClient
//
//  Created by Adam Gluck on 2/3/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import "USHRestaurantAnnotation.h"

@interface USHRestaurantAnnotation ()

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) USHRestaurant *restaurant;

@end

@implementation USHRestaurantAnnotation

- (instancetype)initWithRestaurant:(USHRestaurant *)restaurant
{
    self = [super init];
    if (self) {
        self.restaurant = restaurant;
        self.coordinate = restaurant.locationCoordinate;
    }
    return self;
}

@end
