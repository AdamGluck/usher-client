//
//  USHRestaurant.h
//  UsherClient
//
//  Created by Adam Gluck on 2/4/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, USHRestaurantWaitType) {
    USHRestaurantWaitTypeNone,
    USHRestaurantWaitTypeShort,
    USHRestaurantWaitTypeLong
};

@interface USHRestaurant : NSObject

@property (nonatomic, readonly) USHRestaurantWaitType waitType;
@property (nonatomic, readonly) NSInteger waitTime;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSArray *descriptors;

- (instancetype)initWithRestaurantInfo:(NSDictionary *)restaurantInfo;

@end
