//
//  ModelUtils.m
//  react_native_otakeys
//
//  Created by Rendell Hoffmann Bernardes on 16/02/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "ModelUtils.h"

@implementation ModelUtils

- (OTAKeyRequest *) getOTAKeyRequestObjectFromJson: (NSString *) otaKeyRequestJson
{
  NSData* data = [otaKeyRequestJson dataUsingEncoding:NSUTF8StringEncoding];
  
  NSError *error;
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  OTAKeyRequest *keyRequest;
  
  NSString *string = [[json objectForKey:@"otaId"] stringValue];
  if ([json isKindOfClass:[NSDictionary class]]){
    NSArray *keyRequestArray = json[@"directory"];
    if ([keyRequestArray isKindOfClass:[NSArray class]]){
      for (NSDictionary *dictionary in keyRequestArray) {
        keyRequest.otaId = [[dictionary objectForKey:@"otaId"] stringValue];
        keyRequest.extId = [[dictionary objectForKey:@"extId"] stringValue];
        keyRequest.beginDate = [self dateFromString:[[dictionary objectForKey:@"beginDate"] string]];
        keyRequest.endDate = [self dateFromString:[[dictionary objectForKey:@"endDate"] string]];
        keyRequest.vehicleId = [NSNumber numberWithInteger:[[dictionary objectForKey:@"vehicleId"] integerValue]];
        keyRequest.vehicleExtId = [[dictionary objectForKey:@"vehicleExtId"] stringValue];
        keyRequest.enableNow = [[dictionary objectForKey:@"enableNow"] boolValue];
        keyRequest.tokenAmount = [NSNumber numberWithInteger:[[dictionary objectForKey:@"tokenAmount"] integerValue]];
        keyRequest.singleShotSecurity = [[dictionary objectForKey:@"singleShotSecurity"] boolValue];
        keyRequest.security = [[dictionary objectForKey:@"security"] stringValue];
      }
    }
  }
  return keyRequest;
}

- (OTAKeyPublic *) getOTAKeyPublicObjectFromJson:(NSString *) otaKeyPublicObjectJson
{
  NSData* data = [otaKeyPublicObjectJson dataUsingEncoding:NSUTF8StringEncoding];
  
  NSError *error;
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  OTAKeyPublic *otaKeyPublic;
  if ([json isKindOfClass:[NSDictionary class]]){
    NSArray *otaKeyPublicObjectArray = json[@"directory"];
    if ([otaKeyPublicObjectArray isKindOfClass:[NSArray class]]){
      for (NSDictionary *dictionary in otaKeyPublicObjectArray) {
        otaKeyPublic = [[OTAKeyPublic alloc] init];
        otaKeyPublic.extId = [[dictionary objectForKey:@"extId"] stringValue];
        otaKeyPublic.otaId = [[dictionary objectForKey:@"otaId"] stringValue];
        otaKeyPublic.beginDate = [self dateFromString: [[dictionary objectForKey:@"beginDate"] stringValue]];
        otaKeyPublic.endDate = [self dateFromString: [[dictionary objectForKey:@"endDate"] stringValue]];
        otaKeyPublic.enabled = [[dictionary objectForKey:@"enabled"] boolValue];
        otaKeyPublic.mileageLimit = [NSNumber numberWithInteger:[[dictionary objectForKey:@"mileageLimit"] integerValue]];
        otaKeyPublic.singleShotSecurity = [[dictionary objectForKey:@"singleShotSecurity"] boolValue];
        otaKeyPublic.keyArgs = [[dictionary objectForKey:@"keyArgs"] stringValue];
        otaKeyPublic.keySensitiveArgs = [[dictionary objectForKey:@"keySensitiveArgs"] stringValue];
        
        OTAVehiclePublic *vehicle = [self getOTAVehiclePublicObject:[[dictionary objectForKey:@"vehicle"] stringValue]];
        otaKeyPublic.vehicle = vehicle;
        
        otaKeyPublic.extId = [[dictionary objectForKey:@"extId"] stringValue];
      }
    }
  }
  return otaKeyPublic;
}

- (OTAVehiclePublic *) getOTAVehiclePublicObject: (NSString *) otaVehiclePublicJson {
  NSData* data = [otaVehiclePublicJson dataUsingEncoding:NSUTF8StringEncoding];
  
  NSError *error;
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  OTAVehiclePublic *otaVehiclePublic;
  if ([json isKindOfClass:[NSDictionary class]]){
    NSArray *otaVehiclePublicArray = json[@"directory"];
    if ([otaVehiclePublicArray isKindOfClass:[NSArray class]]){
      for (NSDictionary *dictionary in otaVehiclePublicArray) {
        otaVehiclePublic.otaId = [[dictionary objectForKey:@"otaId"] stringValue];
        otaVehiclePublic.extId = [[dictionary objectForKey:@"extId"] stringValue];
        otaVehiclePublic.vin = [[dictionary objectForKey:@"vin"] stringValue];
        otaVehiclePublic.brand = [[dictionary objectForKey:@"brand"] stringValue];
        otaVehiclePublic.model = [[dictionary objectForKey:@"model"] stringValue];
        otaVehiclePublic.plate = [[dictionary objectForKey:@"plate"] stringValue];
        otaVehiclePublic.year = [NSNumber numberWithInteger:[[dictionary objectForKey:@"year"] integerValue]];
        otaVehiclePublic.enabled = [[dictionary objectForKey:@"enabled"] boolValue];
        otaVehiclePublic.engine = [[dictionary objectForKey:@"engine"] stringValue];
        otaVehiclePublic.mileageOffset = [NSNumber numberWithInteger:[[dictionary objectForKey:@"mileageOffset"] integerValue]];
        
        OTAVehicleData *vehicleData = [self getOTAVehicleDataObject:[[dictionary objectForKey:@"engine"] stringValue]];
        otaVehiclePublic.vehicleData = vehicleData;
      }
    }
  }
  return otaVehiclePublic;
}

- (OTAVehicleData *) getOTAVehicleDataObject: (NSString *) otaVehicleDataJson {
  NSData* data = [otaVehicleDataJson dataUsingEncoding:NSUTF8StringEncoding];
  
  NSError *error;
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  OTAVehicleData *otaVehicleData;
  if ([json isKindOfClass:[NSDictionary class]]){
    NSArray *otaVehicleDataArray = json[@"directory"];
    if ([otaVehicleDataArray isKindOfClass:[NSArray class]]){
      for (NSDictionary *dictionary in otaVehicleDataArray) {
        otaVehicleData = [[OTAVehicleData alloc] init];
        otaVehicleData.date = [self dateFromString:[[dictionary objectForKey:@"date"] string]];
        otaVehicleData.mileageStart = [NSNumber numberWithInteger:[[dictionary objectForKey:@"mileageStart"] integerValue]];
        otaVehicleData.mileageCurrent = [NSNumber numberWithInteger:[[dictionary objectForKey:@"mileageCurrent"] integerValue]];
        otaVehicleData.doorsState = [[dictionary objectForKey:@"doorsState"] boolValue];
        otaVehicleData.energyStart = [NSNumber numberWithInteger:[[dictionary objectForKey:@"energyStart"] integerValue]];
        otaVehicleData.energyCurrent = [NSNumber numberWithInteger:[[dictionary objectForKey:@"energyCurrent"] integerValue]];
        otaVehicleData.engineRunning = [[dictionary objectForKey:@"engineRunning"] boolValue];
        
        OTADoorsState state = [[dictionary objectForKey:@"doorsState"] integerValue];
        otaVehicleData.doorsState = state;
        
        otaVehicleData.malfunctionIndicatorLamp = [[dictionary objectForKey:@"malfunctionIndicatorLamp"] boolValue];
        otaVehicleData.gpsLatitude = [NSNumber numberWithInteger:[[dictionary objectForKey:@"gpsLatitude"] integerValue]];
        otaVehicleData.gpsLongitude = [NSNumber numberWithInteger:[[dictionary objectForKey:@"gpsLongitude"] integerValue]];
        otaVehicleData.gpsAccuracy = [NSNumber numberWithInteger:[[dictionary objectForKey:@"gpsAccuracy"] integerValue]];
        otaVehicleData.gpsCaptureDate = [self dateFromString:[[dictionary objectForKey:@"gpsCaptureDate"] string]];
        otaVehicleData.gprsLatitude = [NSNumber numberWithInteger:[[dictionary objectForKey:@"gprsLatitude"] integerValue]];
        otaVehicleData.gprsLongitude = [NSNumber numberWithInteger:[[dictionary objectForKey:@"gprsLongitude"] integerValue]];
        otaVehicleData.gprsLastCaptureDate = [self dateFromString:[[dictionary objectForKey:@"gprsLastCaptureDate"] string]];
        otaVehicleData.gprsInitialCaptureDate = [self dateFromString:[[dictionary objectForKey:@"gprsInitialCaptureDate"] string]];
        otaVehicleData.lastMileageCaptureDate = [self dateFromString:[[dictionary objectForKey:@"lastMileageCaptureDate"] string]];
        otaVehicleData.lastEnergyCaptureDate = [self dateFromString:[[dictionary objectForKey:@"lastEnergyCaptureDate"] string]];
        
        OTAFuelUnit fueltUnit = [[dictionary objectForKey:@"fuelUnit"] integerValue];
        otaVehicleData.fuelUnit = fueltUnit;
        
        OTAOdometerUnit odometerUnit = [[dictionary objectForKey:@"odometerUnit"] integerValue];
        otaVehicleData.odometerUnit = odometerUnit;
        
        otaVehicleData.synthesisVersion = [NSNumber numberWithInteger:[[dictionary objectForKey:@"synthesisVersion"] integerValue]];
        otaVehicleData.activeDtcErrorCode = [NSNumber numberWithInteger:[[dictionary objectForKey:@"activeDtcErrorCode"] integerValue]];
        otaVehicleData.batteryVoltage = [NSNumber numberWithInteger:[[dictionary objectForKey:@"batteryVoltage"] integerValue]];
        
        OTAEnergyType energyType = [[dictionary objectForKey:@"energyType"] integerValue];
        otaVehicleData.energyType = energyType;
        
        OTADistanceType distanceType = [[dictionary objectForKey:@"distanceType"] integerValue];
        otaVehicleData.distanceType = distanceType;
        
        otaVehicleData.timestamp = [NSNumber numberWithInteger:[[dictionary objectForKey:@"timestamp"] integerValue]];
        otaVehicleData.sdkGpsLatitude = [NSNumber numberWithInteger:[[dictionary objectForKey:@"sdkGpsLatitude"] integerValue]];
        otaVehicleData.sdkGpsLongitude = [NSNumber numberWithInteger:[[dictionary objectForKey:@"sdkGpsLongitude"] integerValue]];
        otaVehicleData.sdkGpsAccuracy = [NSNumber numberWithInteger:[[dictionary objectForKey:@"sdkGpsAccuracy"] integerValue]];
        otaVehicleData.sdkGpsCaptureDate = [self dateFromString:[[dictionary objectForKey:@"sdkGpsCaptureDate"] string]];
      }
    }
  }
  return otaVehicleData;
}

- (OTAKeyRequestBuilder *) getOTAKeyRequestBuilderFromJson: (NSString *) otaKeyRequestBuilderJson
{
  return nil;
}

- (OTALastVehicleSynthesisGpsCoordinatesPublic *) getOTALastVehicleSynthesisGpsCoordinatesPublicFromJson: (NSString *) otaLastVehicleSynthesisGpsCoordinatesPublicJson
{
  return nil;
}



- (NSDate *) dateFromString:(NSString *) dateString
{
  // Convert string to date object
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
  
  NSDate *date = [dateFormat dateFromString: dateString];
  
  return date;
}

- (NSString*) convertObjectToJson:(NSObject*) object
{
  NSError *error = nil;
  
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
  NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
  return result;
}

@end

