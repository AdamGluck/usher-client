//
//  USHRestaurant.m
//  UsherClient
//
//  Created by Adam Gluck on 2/4/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import "USHRestaurant.h"

@interface USHRestaurant()

@property (nonatomic) USHRestaurantWaitType waitType;
@property (nonatomic) NSInteger waitTime;
@property (nonatomic) CLLocationCoordinate2D locationCoordinate;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *formattedAddress;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSArray *descriptors;

@property (nonatomic, strong) NSURL *imageUrl;

@end

@implementation USHRestaurant

- (instancetype)initWithRestaurantInfo:(NSDictionary *)restaurantInfo
{
    self = [super init];
    if (self) {
        self.waitTime = [restaurantInfo[@"waitTime"] integerValue];
        self.waitType = [self _waitTypeFromString:restaurantInfo[@"waitType"]];
        self.locationCoordinate = CLLocationCoordinate2DMake([restaurantInfo[@"latitude"] doubleValue], [restaurantInfo[@"longitude"] doubleValue]);
        
        self.name = restaurantInfo[@"name"];
        self.formattedAddress = restaurantInfo[@"address"];
        self.phone = restaurantInfo[@"phone"];
        self.descriptors = restaurantInfo[@"descriptors"];
        
        self.imageUrl = [NSURL URLWithString:restaurantInfo[@"imageUrl"]];
    }
    return self;
}

#pragma mark - internal

- (USHRestaurantWaitType)_waitTypeFromString:(NSString *)string
{
    if ([string isEqualToString:@"short"]) {
        return USHRestaurantWaitTypeShort;
    } else if ([string isEqualToString:@"long"]) {
        return  USHRestaurantWaitTypeLong;
    } else {
        return USHRestaurantWaitTypeNone;
    }
}

@end
