//
//  USHMapViewController.m
//  UsherClient
//
//  Created by Adam Gluck on 2/3/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import "USHMapViewController.h"
#import <MapKit/MapKit.h>

@interface USHMapViewController () <MKMapViewDelegate>

@property (strong, nonatomic) MKMapView *mapView;

@end

@implementation USHMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.mapView];
}

#pragma mark - Internal

- (CLLocationCoordinate2D)_centerCoordinate
{
    return CLLocationCoordinate2DMake(38.890932, -77.035681);;
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

@end
