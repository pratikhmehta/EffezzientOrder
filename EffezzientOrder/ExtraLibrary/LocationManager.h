//
//  LocationManager.h
//  Meril
//
//  Created by Manish Patel on 29/04/17.
//  Copyright © 2017 Manish Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    
    NSString *lattitude;
    NSString *longitude;
    CGFloat accuracy;
    
    NSString *placeName;
    NSString *city;
    NSString *area;
    
    BOOL isGpsOn;
}

@property(nonatomic) NSString *lattitude;
@property(nonatomic) NSString *longitude;
@property(nonatomic) CGFloat accuracy;

@property(nonatomic,retain) NSString *placeName;
@property(nonatomic,retain) NSString *city;
@property(nonatomic,retain) NSString *area;

@property(nonatomic) BOOL isGpsOn;

@property(nonatomic) CLLocationCoordinate2D coordinates;

+(LocationManager *)sharedManagerInfo;
-(void)getUserLocation;

@end
