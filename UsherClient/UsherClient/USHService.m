//
//  USHService.m
//  UsherClient
//
//  Created by Adam Gluck on 2/4/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import "USHRestaurant.h"
#import "USHService.h"

NSString *const USHServiceRestaurantsUpdated = @"service-restaurants-updated";
NSString *const USHServiceRestaurantsInfoKey = @"service-restaurants-info-key";

@implementation USHService

static USHService *__sharedInstance;

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[self alloc] init];
    });
    
    return __sharedInstance;
}

- (void)start
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(_timerFired:) userInfo:nil repeats:NO];
}

#pragma mark - Internal

- (void)_timerFired:(NSTimer*)timer
{
    NSDictionary *restaurantInfo = @{@"waitType":@"none",
                                     @"waitTime":@"15",
                                     @"latitude": @"38.900543",
                                     @"longitude": @"-77.044533",
                                     
                                     @"name": @"",
                                     @"address": @"1924 Pennsylvania Ave NW Washington, DC 20006",
                                     @"phone": @"(202) 822-8783",
                                     @"descriptors" : @[@"American (traditional)"]};
    
    USHRestaurant *restaurant = [[USHRestaurant alloc] initWithRestaurantInfo:restaurantInfo];
    
    NSDictionary *userInfo = @{USHServiceRestaurantsInfoKey : @[restaurant]};
    [[NSNotificationCenter defaultCenter] postNotificationName:USHServiceRestaurantsUpdated object:self userInfo:userInfo];
}

@end
