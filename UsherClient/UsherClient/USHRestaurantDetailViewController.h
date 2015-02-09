//
//  USHRestaurantDetailViewController.h
//  UsherClient
//
//  Created by Adam Gluck on 2/8/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USHRestaurant.h"

@protocol USHRestaurantDetailViewControllerDelegate;

@interface USHRestaurantDetailViewController : UIViewController

@property (nonatomic, weak) id <USHRestaurantDetailViewControllerDelegate> delegate;
- (void)presentInViewController:(UIViewController *)viewController
                 withRestaurant:(USHRestaurant *)restaurant;

@end

@protocol USHRestaurantDetailViewControllerDelegate <NSObject>

@optional
- (void)restaurantDetailViewControllerDidDismiss:(USHRestaurantDetailViewController *)detailViewController;

@end
