//
//  USHRestaurant.h
//  UsherClient
//
//  Created by Adam Gluck on 2/4/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, USHRestaurantWaitType) {
    USHRestaurantWaitTypeNone,
    USHRestaurantWaitTypeShort,
    USHRestaurantWaitTypeLong
};

@interface USHRestaurant : NSObject

@property (nonatomic, readonly) USHRestaurantWaitType waitType;
@property (nonatomic, readonly) NSInteger waitTime;
@property (nonatomic, readonly) CLLocationCoordinate2D locationCoordinate;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *formattedAddress;
@property (nonatomic, strong, readonly) NSString *phone;
@property (nonatomic, strong, readonly) NSArray *descriptors;

@property (nonatomic, strong, readonly) NSURL *imageUrl;

- (instancetype)initWithRestaurantInfo:(NSDictionary *)restaurantInfo;

@end
