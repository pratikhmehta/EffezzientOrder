//
//  LocationManager.m
//  Meril
//
//  Created by Manish Patel on 29/04/17.
//  Copyright © 2017 Manish Patel. All rights reserved.
//

#import "LocationManager.h"

LocationManager *sharedLocationManagerInfo = nil;

@implementation LocationManager

@synthesize lattitude;
@synthesize longitude;
@synthesize accuracy;

@synthesize placeName;
@synthesize city;
@synthesize area;

@synthesize isGpsOn;

+(LocationManager *)sharedManagerInfo
{
    if(sharedLocationManagerInfo == nil)
    {
        sharedLocationManagerInfo = [[LocationManager alloc] init];
        [sharedLocationManagerInfo customInit];
    }
    return sharedLocationManagerInfo;
}

-(void)customInit
{
    isGpsOn = NO;
    lattitude = @"";
    longitude = @"";
    accuracy = 0;
    placeName = @"";
    city = @"";
    area = @"";
}

-(void)getUserLocation
{
    if([CLLocationManager locationServicesEnabled])
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.pausesLocationUpdatesAutomatically = NO;
        [locationManager startUpdatingLocation];
        self.isGpsOn = 1;
    }
    else
    {
        self.isGpsOn = 0;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"locations: %@",locations);
    CLLocation *location = [locations objectAtIndex:0];
    
    CLLocationCoordinate2D coordinate = [location coordinate];
    _coordinates = coordinate;
    self.lattitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    CLGeocoder *ceo = [[CLGeocoder alloc] init];
    [ceo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
    {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
//        MMLog(@"place mark : %@",placemark);
//        NSLog(@"name : %@",placemark.name);
//        NSLog(@"city : %@",placemark.locality); // city
//        NSLog(@"subLocality : %@",placemark.subLocality); // checkinarea
        NSArray *addressLines = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
        self.placeName = [addressLines componentsJoinedByString:@", "];
        self.city = placemark.locality;
        self.area = placemark.subLocality;
        
//        NSLog(@"placeName : %@",self.placeName);
//        NSLog(@"latitude : %@",self.lattitude);
//        NSLog(@"longitude : %@",self.longitude);
    }];
    
    [locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"location error : %@",[error localizedDescription]);
}


@end
