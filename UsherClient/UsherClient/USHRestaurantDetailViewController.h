//
//  USHRestaurantDetailViewController.h
//  UsherClient
//
//  Created by Adam Gluck on 2/8/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USHRestaurant.h"

@interface USHRestaurantDetailViewController : UIViewController

- (void)presentInViewController:(UIViewController *)viewController
                 withRestaurant:(USHRestaurant *)restaurant;

@end
