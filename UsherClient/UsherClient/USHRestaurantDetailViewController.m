//
//  USHRestaurantDetailViewController.m
//  UsherClient
//
//  Created by Adam Gluck on 2/8/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import "USHRestaurantDetailViewController.h"
#import <Masonry/Masonry.h>

#define RESTAURANT_DETAIL_CONTAINER_HEIGHT [UIScreen mainScreen].bounds.size.height / 4

static CGFloat const USHRestaurantDetailBlackLineImageSize = 37.0f;
static CGFloat const USHRestaurantDetailHorizontalPadding = 15.0f;
static CGFloat const USHRestaurantDetailVerticalPadding = 15.0f;
static CGFloat const USHRestaurantDetailSmallTextHeight = 20.0f;
static CGFloat const USHRestaurantDetailAnimationDuration = 0.2f;

@interface USHRestaurantDetailViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) USHRestaurant *restaurant;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *restaurantImageView;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UITextView *nameTextView;
@property (nonatomic, strong) UITextView *adjectivesTextView;
@property (nonatomic, strong) UITextView *addressTextView;
@property (nonatomic, strong) UITextView *waitTimeTextView;
@property (nonatomic, strong) UITapGestureRecognizer *dismissTapGestureRecognizer;

@property (nonatomic) BOOL isPresenting;

@end

@implementation USHRestaurantDetailViewController


#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self.containerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, screenSize.height - RESTAURANT_DETAIL_CONTAINER_HEIGHT, screenSize.width, RESTAURANT_DETAIL_CONTAINER_HEIGHT)];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self.view addSubview:self.containerView];
    
    self.restaurantImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor grayColor];
        imageView;
    });
    [self.containerView addSubview:self.restaurantImageView];
    
    self.nameTextView = ({
        UITextView *textView = [[UITextView alloc] init];
        textView.font = [UIFont systemFontOfSize:20.0f];
        textView.textColor = [UIColor blackColor];
        textView.backgroundColor = [UIColor clearColor];
        textView;
    });
    [self.containerView addSubview:self.nameTextView];
    
    self.adjectivesTextView = ({
        UITextView *textView = [[UITextView alloc] init];
        textView.backgroundColor = [UIColor clearColor];
        textView;
    });
    [self.containerView addSubview:self.adjectivesTextView];
    
    self.addressTextView = ({
        UITextView *textView = [[UITextView alloc] init];
        textView.font = [UIFont systemFontOfSize:10.0f];
        textView.textColor = [UIColor lightGrayColor];
        textView.text = self.restaurant.formattedAddress;
        textView.backgroundColor = [UIColor clearColor];
        textView;
    });
    [self.containerView addSubview:self.addressTextView];
    
    self.lineImageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"line_black"];
        imageView;
    });
    [self.containerView addSubview:self.lineImageView];
    
    self.waitTimeTextView = ({
        UITextView *textView = [[UITextView alloc] init];
        textView.font = [UIFont systemFontOfSize:12.0f];
        textView.backgroundColor = [UIColor clearColor];
        textView;
    });
    [self.containerView addSubview:self.waitTimeTextView];
    
    self.dismissTapGestureRecognizer = ({
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_didTapDismissRecognizer:)];
        tapGestureRecognizer.delegate = self;
        tapGestureRecognizer;
    });
    [self.view addGestureRecognizer:self.dismissTapGestureRecognizer];
    
    self.isPresenting = NO;
}

- (void)updateViewConstraints
{
    [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.restaurantImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.top.mas_offset(UIEdgeInsetsMake(USHRestaurantDetailVerticalPadding, 0.0f, USHRestaurantDetailVerticalPadding, 0.0f));
        make.left.mas_equalTo(self.containerView.mas_left).with.offset(USHRestaurantDetailHorizontalPadding);
        
        make.width.mas_equalTo(75.0f);
    }];
    
    [self.nameTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView.mas_top).with.offset(USHRestaurantDetailVerticalPadding - 10.0f);
        make.left.mas_equalTo(self.restaurantImageView.mas_right).with.offset(USHRestaurantDetailHorizontalPadding / 2);
        make.right.mas_equalTo(self.lineImageView.mas_left).with.offset(-USHRestaurantDetailHorizontalPadding);
        
        make.height.mas_equalTo(30.0f);
    }];
    
    [self.adjectivesTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTextView.mas_bottom).with.offset(-2.0f);
        make.left.mas_equalTo(self.nameTextView.mas_left).with.offset(2.0f);
        make.right.mas_equalTo(self.nameTextView.mas_right);
        
        make.height.mas_greaterThanOrEqualTo(USHRestaurantDetailSmallTextHeight * 2.0f);
    }];
    
    [self.addressTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.adjectivesTextView.mas_bottom).with.offset(-5.0f);
        make.left.mas_equalTo(self.nameTextView.mas_left).with.offset(1.0f);
        make.right.mas_equalTo(self.nameTextView.mas_right);
        
        make.height.mas_greaterThanOrEqualTo(USHRestaurantDetailSmallTextHeight * 3.0f);
    }];
    
    [self.lineImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.containerView.mas_right).with.offset(-USHRestaurantDetailHorizontalPadding * 2.0f);
        
        make.height.mas_equalTo(USHRestaurantDetailBlackLineImageSize);
        make.width.mas_equalTo(USHRestaurantDetailBlackLineImageSize);
        
        make.centerY.mas_equalTo(self.containerView.mas_centerY).with.offset(-10.0f);
    }];
    
    [self.waitTimeTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineImageView.mas_bottom);
        make.bottom.mas_equalTo(self.containerView.mas_bottom).with.offset(USHRestaurantDetailVerticalPadding);
        
        make.width.mas_equalTo(75.0);
        
        make.centerX.mas_equalTo(self.lineImageView.mas_centerX);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Public

- (void)presentInViewController:(UIViewController *)viewController
                 withRestaurant:(USHRestaurant *)restaurant
{
    if (self.isPresenting) {
        [self _updateViewsForRestaurant:restaurant];
        return;
    }
    
    [viewController addChildViewController:self];
    
    CGPoint parentViewControllerViewCenter = viewController.view.center;
    self.view.center = CGPointMake(parentViewControllerViewCenter.x, parentViewControllerViewCenter.y + RESTAURANT_DETAIL_CONTAINER_HEIGHT);
    [self _updateViewsForRestaurant:restaurant];
    
    [viewController.view addSubview:self.view];
    
    [UIView animateWithDuration:USHRestaurantDetailAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.view.center = parentViewControllerViewCenter;
                        }
                     completion:^(BOOL finished){
                         [self didMoveToParentViewController:viewController];
                        }];
}

- (void)dismiss
{
    CGPoint parentViewControllerViewCenter = self.parentViewController.view.center;
    CGPoint targetCenter = CGPointMake(parentViewControllerViewCenter.x, parentViewControllerViewCenter.y - RESTAURANT_DETAIL_CONTAINER_HEIGHT);
    
    [UIView animateWithDuration:0.2f
                          delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.view.center = targetCenter;
                     }
                     completion:^(BOOL finished) {
                         [self.view removeFromSuperview];
                         [self removeFromParentViewController];
                     }];
}

#pragma mark - Internal

- (void)_updateViewsForRestaurant:(USHRestaurant *)restaurant
{
    self.nameTextView.text = restaurant.name;
    self.addressTextView.text = restaurant.formattedAddress;
    
    if (restaurant.descriptors) {
        NSString *adjectives = [restaurant.descriptors componentsJoinedByString:@", "];
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont italicSystemFontOfSize:12.0f],
                                     NSForegroundColorAttributeName: [UIColor lightGrayColor]};
        self.adjectivesTextView.attributedText = [[NSAttributedString alloc] initWithString:adjectives attributes:attributes];
    }
    
    self.waitTimeTextView.text = [NSString stringWithFormat:@"%ld minutes", (long) restaurant.waitTime];
    
    [self.view layoutIfNeeded];
    [self updateViewConstraints];
}

- (void)_didTapDismissRecognizer:(UITapGestureRecognizer *)sender
{
    [self dismiss];
}

@end
