//
//  OTAVehiclePublic.h
//
//  Created by Sébastien Kalb on 3/03/15.
//  Copyright © 2017 OTA keys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTAVehicleData.h"

@interface OTAVehiclePublic : NSObject

@property (nonatomic, retain) NSString *otaId;
@property (nonatomic, retain) NSString *extId;
@property (nonatomic, retain) NSString *vin;
@property (nonatomic, retain) NSString *brand;
@property (nonatomic, retain) NSString *model;
@property (nonatomic, retain) NSString *plate;
@property (nonatomic, retain) NSNumber *year;
@property (nonatomic) BOOL enabled;
@property (nonatomic, retain) NSString *engine;
@property (nonatomic, retain) NSNumber *mileageOffset;
@property (nonatomic, retain) OTAVehicleData *vehicleData;

@end
