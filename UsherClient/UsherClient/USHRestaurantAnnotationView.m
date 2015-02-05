//
//  USHRestaurantAnnotationView.m
//  UsherClient
//
//  Created by Adam Gluck on 2/3/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import "USHRestaurantAnnotationView.h"

@interface USHRestaurantAnnotationView ()

@property (nonatomic, strong) USHRestaurantAnnotation *restaurantAnnotation;

@end

@implementation USHRestaurantAnnotationView

- (instancetype)initWithRestaurantAnnotation:(USHRestaurantAnnotation *)restaurantAnnotation
                             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:restaurantAnnotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.restaurantAnnotation = restaurantAnnotation;
        self.image = [self _imageForWaitType:restaurantAnnotation.restaurant.waitType];
    }
    return self;
}

#pragma mark - Internal

- (UIImage *)_imageForWaitType:(USHRestaurantWaitType)waitType
{
    switch (waitType) {
        case USHRestaurantWaitTypeNone:
            return [UIImage imageNamed:@"no_wait"];
        case USHRestaurantWaitTypeShort:
            return [UIImage imageNamed:@"short_wait"];
        case USHRestaurantWaitTypeLong:
            return [UIImage imageNamed:@"long_wait"];
    }
    return nil;
}

@end
