//
//  USHRestaurantAnnotation.h
//  UsherClient
//
//  Created by Adam Gluck on 2/3/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "USHRestaurant.h"

@interface USHRestaurantAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong, readonly) USHRestaurant *restaurant;

- (instancetype)initWithRestaurant:(USHRestaurant *)restaurant;

@end
