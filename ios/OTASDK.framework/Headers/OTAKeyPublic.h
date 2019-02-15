//
//  OTAKeyPublic.h
//
//  Created by Sébastien Kalb on 3/03/15.
//  Copyright © 2017 OTA keys. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OTAVehiclePublic;
@class OTALastVehicleSynthesisPublic;

@interface OTAKeyPublic : NSObject

@property (nonatomic, retain) NSString *extId;
@property (nonatomic, retain) NSString *otaId;
@property (nonatomic, retain) NSDate *beginDate;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic) BOOL enabled;
@property (nonatomic, retain) NSNumber *mileageLimit;
@property (nonatomic) BOOL singleShotSecurity;
@property (nonatomic, retain) NSString *keyArgs;
@property (nonatomic, retain) NSString *keySensitiveArgs;
@property (nonatomic, retain) OTAVehiclePublic *vehicle;
@property (nonatomic, retain) OTALastVehicleSynthesisPublic *lastVehicleSynthesis;

@end
