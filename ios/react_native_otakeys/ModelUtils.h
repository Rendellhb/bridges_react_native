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
#import <objc/runtime.h>

@class OTAKeyPublic;
@class OTAKeyRequest;
@class OTAKeyRequestBuilder;
@class OTALastVehicleSynthesisGpsCoordinatesPublic;

@interface ModelUtils : NSObject

- (OTAKeyPublic *) getOTAKeyPublicObjectFromJson: (NSString *)otaKeyPublicJson;

- (NSArray<OTAKeyPublic *> *) getOTAKeyPublicArrayFromJson:(NSString *) otaKeyPublicObjectJson;

- (OTAKeyRequest *) getOTAKeyRequestObjectFromJson: (NSString *) otaKeyRequestJson;

- (NSArray *)getOTAKeyRequestArrayFromJson: (NSString *) otaKeyRequestsJson;

- (OTAKeyRequestBuilder *) getOTAKeyRequestBuilderFromJson: (NSString *) otaKeyRequestBuilder;

- (OTALastVehicleSynthesisGpsCoordinatesPublic *) getOTALastVehicleSynthesisGpsCoordinatesPublicFromJson: (NSString *) otaLastVehicleSynthesisGpsCoordinatesPublic;

- (NSDate *)dateFromString:(NSString *) dateString;

- (NSString *) convertObjectToJson:(NSObject *) object;

- (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj;

- (NSString *) changeDateToDateString :(NSDate *) date;

- (NSString *) getJsonFromNSArray: (NSArray *) array;

- (NSString *) getJsonFromNSDictionary: (NSDictionary *) dictionary;

- (NSDictionary *) resolveOTAKeyPublicDictionary: (NSDictionary *) dictionary;

- (NSDictionary *) resolveOTALastVehicleSynthesisPublic: (OTALastVehicleSynthesisPublic *) lastVehicleSynthesis;

@end
