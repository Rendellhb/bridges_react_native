//
//  OTAKeyRequestBuilder.h
//  OTASDK
//
//  Created by Sébastien Kalb on 16/01/2017.
//  Copyright © 2017 OTA keys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTAKeyRequestBuilder : NSObject
@property (nonatomic, retain) NSString *otaId;
@property (nonatomic, retain) NSString *extId;
@property (nonatomic, retain) NSDate *beginDate;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSNumber *vehicleId;
@property (nonatomic, retain) NSString *vehicleExtId;
@property (nonatomic) BOOL enableNow;
@property (nonatomic, retain) NSNumber *tokenAmount;
@property (nonatomic) BOOL singleShotSecurity;
@property (nonatomic, retain) NSString *security;
@end
