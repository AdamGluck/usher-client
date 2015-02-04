//
//  USHRestaurantAnnotationView.h
//  UsherClient
//
//  Created by Adam Gluck on 2/3/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "USHRestaurantAnnotation.h"

@interface USHRestaurantAnnotationView : MKAnnotationView

- (instancetype)initWithRestaurantAnnotation:(USHRestaurantAnnotation *)restaurantAnnotation
                             reuseIdentifier:(NSString *)reuseIdentifier;

@end
