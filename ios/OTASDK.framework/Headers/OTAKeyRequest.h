//
//  OTAKeyRequest.h
//  OTASDK
//
//  Created by Sébastien Kalb on 08/11/2016.
//  Copyright © 2017 OTA keys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTAKeyRequestBuilder.h"

NS_ASSUME_NONNULL_BEGIN
@interface OTAKeyRequest : NSObject
@property (nonatomic, retain, nullable) NSString *otaId;
@property (nonatomic, retain, nullable) NSString *extId;
@property (nonatomic, retain, nullable) NSDate *beginDate;
@property (nonatomic, retain, nullable) NSDate *endDate;
@property (nonatomic, retain, nullable) NSNumber *vehicleId;
@property (nonatomic, retain, nullable) NSString *vehicleExtId;
@property (nonatomic) BOOL enableNow;
@property (nonatomic, retain, nullable) NSNumber *tokenAmount;
@property (nonatomic) BOOL singleShotSecurity;
@property (nonatomic, retain, nullable) NSString *security;

- (instancetype)initWithBuilder:(OTAKeyRequestBuilder * _Nonnull)builder;
+ (instancetype)makeWithBuilder:(void (^ _Nullable)(OTAKeyRequestBuilder * _Nonnull))updateBlock;
NS_ASSUME_NONNULL_END
@end
