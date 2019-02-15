//
//  OTAVehicleSynthesisPublic.h
//  OTASDK
//
//  Created by Sébastien Kalb on 28/07/16.
//  Copyright © 2017 OTA keys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTAEnums.h"

@class OTALastVehicleSynthesisGpsCoordinatesPublic;

@interface OTALastVehicleSynthesisPublic : NSObject

@property (nonatomic, retain) NSDate *lastCaptureDate;
@property (nonatomic, retain) OTALastVehicleSynthesisGpsCoordinatesPublic *gpsCoordinates;
@property (nonatomic) OTADoorsState doorsState;
@property (nonatomic) BOOL engineRunning;
@property (nonatomic, retain) NSDate *lastMileageCaptureDate;
@property (nonatomic, retain) NSNumber *mileage;
@property (nonatomic, retain) NSDate *lastEnergyCaptureDate;
@property (nonatomic, retain) NSNumber *energyLevel;
@property (nonatomic, retain) NSNumber *batteryVoltage;
@property (nonatomic) BOOL connectedToCharger;
@property (nonatomic) BOOL malfunctionIndicatorLamp;
@property (nonatomic) OTAEnergyType energyType;
@property (nonatomic) OTAFuelUnit fuelUnit;
@property (nonatomic) OTAOdometerUnit odometerUnit;
@property (nonatomic, retain) NSNumber *activeDtcNumber;

@end
