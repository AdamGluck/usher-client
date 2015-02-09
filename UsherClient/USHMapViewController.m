//
//  USHMapViewController.m
//  UsherClient
//
//  Created by Adam Gluck on 2/3/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import "USHMapViewController.h"
#import "USHRestaurant.h"
#import "USHRestaurantAnnotation.h"
#import "USHRestaurantAnnotationView.h"
#import "USHRestaurantDetailViewController.h"
#import "USHService.h"

#import <MapKit/MapKit.h>

@interface USHMapViewController () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) USHRestaurantDetailViewController *restaurantDetailController;

@end

@implementation USHMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_restaurantsUpdated:) name:USHServiceRestaurantsUpdated object:nil];
    
    [USHServiceSharedInstance start];
    
    [self.view addSubview:self.mapView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - MKMapViewDelegate 

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    USHRestaurantAnnotationView *restaurantAnnotationView;
    if ([annotation isKindOfClass:[USHRestaurantAnnotation class]]) {
        restaurantAnnotationView = (USHRestaurantAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"USHRestaurantAnnotationView"];
        if (!restaurantAnnotationView) {
            restaurantAnnotationView = [[USHRestaurantAnnotationView alloc] initWithRestaurantAnnotation:(USHRestaurantAnnotation *)annotation reuseIdentifier:@"USHRestaurantAnnotationView"];
        }
    }
    return restaurantAnnotationView;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view isKindOfClass:[USHRestaurantAnnotationView class]]) {
        USHRestaurant *restaurant = ((USHRestaurantAnnotationView *)view).restaurantAnnotation.restaurant;
        [self.restaurantDetailController presentInViewController:self
                                                  withRestaurant:restaurant];
    }
}


#pragma mark - Internal

- (void)_restaurantsUpdated:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSArray *restaurants = userInfo[USHServiceRestaurantsInfoKey];
    USHRestaurant *restaurant = [restaurants firstObject];
    
    USHRestaurantAnnotation *restaurantAnnotation = [[USHRestaurantAnnotation alloc] initWithRestaurant:restaurant];
    [self.mapView addAnnotation:restaurantAnnotation];
}

- (CLLocationCoordinate2D)_centerCoordinate
{
    // D.C. for now
    return CLLocationCoordinate2DMake(38.890932, -77.035681);
}

- (MKCoordinateRegion)_centerRegion
{
    MKCoordinateSpan mapSpan = MKCoordinateSpanMake(0.2, 0.2);
    return MKCoordinateRegionMake([self _centerCoordinate], mapSpan);
}

#pragma mark - Lazy Instantiation

- (MKMapView *)mapView
{
    if (!_mapView) {
        CLLocationCoordinate2D centerCoordinate = [self _centerCoordinate];
        MKCoordinateRegion coordinateRegion = [self _centerRegion];
        
        _mapView = ({
            MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
            mapView.centerCoordinate = centerCoordinate;
            mapView.region = coordinateRegion;
            mapView.delegate = self;
            mapView;
        });
    }
    return _mapView;
}

- (USHRestaurantDetailViewController *)restaurantDetailController
{
    if (!_restaurantDetailController) {
        _restaurantDetailController = [[USHRestaurantDetailViewController alloc] init];
    }
    return _restaurantDetailController;
}

@end
