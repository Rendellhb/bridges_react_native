//
//  OTAVehicleSynthesisGpsCoordinatesPublic.h
//  OTASDK
//
//  Created by Sébastien Kalb on 28/07/16.
//  Copyright © 2017 OTA keys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTALastVehicleSynthesisGpsCoordinatesPublic : NSObject

@property (nonatomic, retain) NSDate *initialCaptureDate;
@property (nonatomic, retain) NSDate *lastCaptureDate;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;

@end
