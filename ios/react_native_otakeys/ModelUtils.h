//
//  ModelUtils.h
//  react_native_otakeys
//
//  Created by Rendell Hoffmann Bernardes on 16/02/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OTASDK/OTAKeyPublic.h>
#import <OTASDK/OTAKeyRequest.h>
#import <OTASDK/OTAKeyRequestBuilder.h>
#import <OTASDK/OTALastVehicleSynthesisGpsCoordinatesPublic.h>
#import <OTASDK/OTAVehiclePublic.h>
#import <OTASDK/OTALastVehicleSynthesisPublic.h>
#import <OTASDK/OTAVehicleData.h>
#import <OTASDK/OTAEnums.h>

@class OTAKeyPublic;
@class OTAKeyRequest;
@class OTAKeyRequestBuilder;
@class OTALastVehicleSynthesisGpsCoordinatesPublic;

@interface ModelUtils : NSObject

- (OTAKeyPublic *) getOTAKeyPublicObjectFromJson: (NSString *)otaKeyPublicJson;

- (OTAKeyRequest *) getOTAKeyRequestObjectFromJson: (NSString *) otaKeyRequestJson;

- (OTAKeyRequestBuilder *) getOTAKeyRequestBuilderFromJson: (NSString *) otaKeyRequestBuilder;

- (OTALastVehicleSynthesisGpsCoordinatesPublic *) getOTALastVehicleSynthesisGpsCoordinatesPublicFromJson: (NSString *) otaLastVehicleSynthesisGpsCoordinatesPublic;

- (NSDate *)dateFromString:(NSString *) dateString;

- (NSString *) convertObjectToJson:(NSObject *) object;

@end