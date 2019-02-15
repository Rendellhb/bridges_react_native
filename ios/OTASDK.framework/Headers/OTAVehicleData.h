//
//  OTAVehicleData.h
//
//  Created by Sébastien Kalb on 3/03/15.
//  Copyright © 2017 OTA keys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTAEnums.h"

@interface OTAVehicleData : NSObject

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSNumber *mileageStart;
@property (nonatomic, retain) NSNumber *mileageCurrent;
@property (nonatomic) BOOL connectedToLoader;
@property (nonatomic, retain) NSNumber *energyStart;
@property (nonatomic, retain) NSNumber *energyCurrent;
@property (nonatomic) BOOL engineRunning;
@property (nonatomic) OTADoorsState doorsState;
@property (nonatomic) BOOL malfunctionIndicatorLamp;
@property (nonatomic, retain) NSNumber *gpsLatitude;
@property (nonatomic, retain) NSNumber *gpsLongitude;
@property (nonatomic, retain) NSNumber *gpsAccuracy;
@property (nonatomic, retain) NSDate *gpsCaptureDate;

@property (nonatomic, retain) NSNumber *gprsLatitude;
@property (nonatomic, retain) NSNumber *gprsLongitude;
@property (nonatomic, retain) NSDate *gprsLastCaptureDate;
@property (nonatomic, retain) NSDate *gprsInitialCaptureDate;
@property (nonatomic, retain) NSDate *lastMileageCaptureDate;
@property (nonatomic, retain) NSDate *lastEnergyCaptureDate;


@property (nonatomic) OTAFuelUnit fuelUnit;
@property (nonatomic) OTAOdometerUnit odometerUnit;
@property (nonatomic, retain) NSNumber *synthesisVersion;
@property (nonatomic, retain) NSNumber *activeDtcErrorCode;
@property (nonatomic, retain) NSNumber *batteryVoltage;
@property (nonatomic) OTAEnergyType energyType;
@property (nonatomic) OTADistanceType distanceType;
@property (nonatomic, retain) NSNumber *timestamp;
@property (nonatomic, retain) NSNumber *sdkGpsLatitude;
@property (nonatomic, retain) NSNumber *sdkGpsLongitude;
@property (nonatomic, retain) NSNumber *sdkGpsAccuracy;
@property (nonatomic, retain) NSDate *sdkGpsCaptureDate;

@end
