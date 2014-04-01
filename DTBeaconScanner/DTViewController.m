//
//  DTViewController.m
//  DTBeaconScanner
//
//  Created by 田單單 on 2014/4/1.
//  Copyright (c) 2014年 Tien Wei Shin. All rights reserved.
//

#import "DTViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface DTViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) CLLocationManager *beaconManager;
@end

@implementation DTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	//Setting Beacon Region
	NSUUID *UUID = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
	CLBeaconRegion *beaconReigon = [[CLBeaconRegion alloc] initWithProximityUUID:UUID identifier:@"DTBeaconScannerDemo"];

	//Setting Beacon Manager
	self.beaconManager = [[CLLocationManager alloc] init];
	self.beaconManager.delegate = self;
	self.beaconManager.desiredAccuracy = kCLLocationAccuracyBest;
	[self.beaconManager startRangingBeaconsInRegion:beaconReigon];
}

#pragma mark - CLLocationManagerDelegate methods
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
	NSMutableString *mString = [[NSMutableString alloc] init];
	for (CLBeacon *beacon in  beacons) {
		[mString appendFormat:@"Beacon:\nmajor:%i minor:%i proximity:%i accuracy:%f\n\n",[beacon.major intValue],[beacon.minor intValue],beacon.proximity,beacon.accuracy];
	}
	self.label.text = mString;
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}
@end
