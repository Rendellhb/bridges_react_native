//
//  ModelUtils.m
//  react_native_otakeys
//
//  Created by Rendell Hoffmann Bernardes on 16/02/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "ModelUtils.h"

@implementation ModelUtils

- (OTAKeyRequest *) getOTAKeyRequestObjectFromJson: (NSString *) otaKeyRequestBuilderJson
{
  NSData* data = [otaKeyRequestBuilderJson dataUsingEncoding:NSUTF8StringEncoding];
  
  NSError *error;
  __block NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  
  return [OTAKeyRequest makeWithBuilder:^(OTAKeyRequestBuilder *builder) {
    builder = [self getOTAKeyRequestFromDictionary: dictionary];
  }];
}

- (OTAKeyPublic *) getOTAKeyPublicObjectFromJson:(NSString *) otaKeyPublicObjectJson
{
  NSData* data = [otaKeyPublicObjectJson dataUsingEncoding:NSUTF8StringEncoding];
  
  NSError *error;
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  return [self getOTAKeyPublicFromDictionary:json];
}

- (NSArray<OTAKeyPublic *> *) getOTAKeyPublicArrayFromJson:(NSString *) otaKeyPublicObjectJson
{
  NSData* data = [otaKeyPublicObjectJson dataUsingEncoding:NSUTF8StringEncoding];

  NSError *error;
  NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  NSMutableArray *otaKeysPublic = [[NSMutableArray alloc] init];
  
  for (NSDictionary *dictionary in jsonArray) {
    if ([dictionary isKindOfClass:[NSDictionary class]])
      [otaKeysPublic addObject:[self getOTAKeyPublicFromDictionary:dictionary]];
  }
  return otaKeysPublic;
}

- (OTAVehiclePublic *) getOTAVehiclePublicObject: (NSString *) otaVehiclePublicJson
{
  NSData* data = [otaVehiclePublicJson dataUsingEncoding:NSUTF8StringEncoding];
  
  NSError *error;
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  OTAVehiclePublic *otaVehiclePublic;
  if ([json isKindOfClass:[NSDictionary class]]){
    NSArray *otaVehiclePublicArray = json[@"directory"];
    if ([otaVehiclePublicArray isKindOfClass:[NSArray class]]) {
      for (NSDictionary *dictionary in otaVehiclePublicArray) {
        otaVehiclePublic = [self getOTAVehiclePublicFromDictionary: dictionary];
      }
    } else {
      otaVehiclePublic = [self getOTAVehiclePublicFromDictionary: json];
    }
  }
  return otaVehiclePublic;
}

- (OTAVehicleData *) getOTAVehicleDataObject: (NSString *) otaVehicleDataJson
{
  NSData* data = [otaVehicleDataJson dataUsingEncoding:NSUTF8StringEncoding];
  
  NSError *error;
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  OTAVehicleData *otaVehicleData;
  if ([json isKindOfClass:[NSDictionary class]]){
    NSArray *otaVehicleDataArray = json[@"directory"];
    if ([otaVehicleDataArray isKindOfClass:[NSArray class]]) {
      for (NSDictionary *dictionary in otaVehicleDataArray) {
        otaVehicleData = [self getOTAVehicleDataFromDictionary: dictionary];
      }
    } else {
      otaVehicleData = [self getOTAVehicleDataFromDictionary: json];
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

- (NSDate *) dateFromIntTimestap: (NSNumber *) timestamp
{
  return [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
}

- (NSDate *) dateFromString:(NSString *) dateString
{
  // Convert string to date object
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"dd-MM-yyyy"];
  
  NSDate *date = [dateFormat dateFromString: dateString];
  
  return date;
}

- (NSString*) convertObjectToJson:(NSDictionary *) object
{
  NSError *error = nil;
  
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
  NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  
  return result;
}

- (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  
  unsigned count;
  objc_property_t *properties = class_copyPropertyList([obj class], &count);
  
  for (int i = 0; i < count; i++) {
    NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
    if ([[obj valueForKey:key] isKindOfClass:[NSDate class]]) {
      [dict setObject:[self changeDateToDateString: [obj valueForKey:key]] forKey:key];
    } else {
      [dict setObject:[obj valueForKey:key] forKey:key];
    }
  }
  
  free(properties);
  
  return dict;
}

- (NSString *) changeDateToDateString: (NSDate *) date
{
  return [NSString stringWithFormat:@"%.0f", date.timeIntervalSince1970];
}

- (NSString *) getJsonFromNSArray: (NSArray *) array
{
  NSError *error = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
  return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString *) getJsonFromNSDictionary: (NSDictionary *) dictionary
{
  NSError *error = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
  return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (OTAKeyRequestBuilder *) getOTAKeyRequestFromDictionary: (NSDictionary *) dictionary
{
  OTAKeyRequestBuilder *keyRequest = [[OTAKeyRequestBuilder alloc] init];
  keyRequest.otaId = [dictionary objectForKey:@"otaId"];
  keyRequest.extId = [dictionary objectForKey:@"extId"];
  keyRequest.beginDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"beginDate"] integerValue]]];
  keyRequest.endDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"endDate"] integerValue]]];
  keyRequest.vehicleId = [NSNumber numberWithInteger:[[dictionary objectForKey:@"vehicleId"] integerValue]];
  keyRequest.vehicleExtId = [dictionary objectForKey:@"vehicleExtId"];
  keyRequest.enableNow = [[dictionary objectForKey:@"enableNow"] boolValue];
  keyRequest.tokenAmount = [NSNumber numberWithInteger:[[dictionary objectForKey:@"tokenAmount"] integerValue]];
  keyRequest.singleShotSecurity = [[dictionary objectForKey:@"singleShotSecurity"] boolValue];
  keyRequest.security = [dictionary objectForKey:@"security"];
  
  return keyRequest;
}

- (OTAKeyPublic *) getOTAKeyPublicFromDictionary: (NSDictionary *) dictionary
{
  OTAKeyPublic *otaKeyPublic = [[OTAKeyPublic alloc] init];
  otaKeyPublic.extId = [dictionary objectForKey:@"extId"];
  otaKeyPublic.otaId = [dictionary objectForKey:@"otaId"];
  otaKeyPublic.beginDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"beginDate"] integerValue]]];
  otaKeyPublic.endDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"endDate"] integerValue]]];
  otaKeyPublic.enabled = [[dictionary objectForKey:@"enabled"] boolValue];
  otaKeyPublic.mileageLimit = [NSNumber numberWithInteger:[[dictionary objectForKey:@"mileageLimit"] integerValue]];
  otaKeyPublic.singleShotSecurity = [[dictionary objectForKey:@"singleShotSecurity"] boolValue];
  otaKeyPublic.keyArgs = [dictionary objectForKey:@"keyArgs"];
  otaKeyPublic.keySensitiveArgs = [dictionary objectForKey:@"keySensitiveArgs"];
  
  OTAVehiclePublic *vehicle = [self getOTAVehiclePublicFromDictionary:[dictionary objectForKey:@"vehicle"]];
  otaKeyPublic.vehicle = vehicle;
  
  OTALastVehicleSynthesisPublic *lastVehicleSynthesisPublic = [self getOTALastVehicleSynthesisPublicFromDictionary: [dictionary objectForKey:@"lastVehicleSynthesis"]];
  otaKeyPublic.lastVehicleSynthesis = lastVehicleSynthesisPublic;
  
  return otaKeyPublic;
}

- (OTAVehiclePublic *) getOTAVehiclePublicFromDictionary: (NSDictionary *) dictionary
{
  OTAVehiclePublic *otaVehiclePublic = [[OTAVehiclePublic alloc] init];
  otaVehiclePublic.otaId = [dictionary objectForKey:@"otaId"];
  otaVehiclePublic.extId = [dictionary objectForKey:@"extId"];
  otaVehiclePublic.vin = [dictionary objectForKey:@"vin"];
  otaVehiclePublic.brand = [dictionary objectForKey:@"brand"];
  otaVehiclePublic.model = [dictionary objectForKey:@"model"];
  otaVehiclePublic.plate = [dictionary objectForKey:@"plate"];
  otaVehiclePublic.year = [NSNumber numberWithInteger:[[dictionary objectForKey:@"year"] integerValue]];
  otaVehiclePublic.enabled = [[dictionary objectForKey:@"enabled"] boolValue];
  otaVehiclePublic.engine = [dictionary objectForKey:@"engine"];
  otaVehiclePublic.mileageOffset = [NSNumber numberWithInteger:[[dictionary objectForKey:@"mileageOffset"] integerValue]];
  
  OTAVehicleData *vehicleData = [self getOTAVehicleDataFromDictionary: [dictionary objectForKey:@"vehicleData"]];
  otaVehiclePublic.vehicleData = vehicleData;
  
  return otaVehiclePublic;
}

- (OTAVehicleData *) getOTAVehicleDataFromDictionary: (NSDictionary *) dictionary
{
  OTAVehicleData *otaVehicleData = [[OTAVehicleData alloc] init];
  otaVehicleData = [[OTAVehicleData alloc] init];
  otaVehicleData.date = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"date"] integerValue]]];
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
  otaVehicleData.gpsCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"gpsCaptureDate"] integerValue]]];
  otaVehicleData.gprsLatitude = [NSNumber numberWithInteger:[[dictionary objectForKey:@"gprsLatitude"] integerValue]];
  otaVehicleData.gprsLongitude = [NSNumber numberWithInteger:[[dictionary objectForKey:@"gprsLongitude"] integerValue]];
  otaVehicleData.gprsLastCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"gprsLastCaptureDate"] integerValue]]];
  otaVehicleData.gprsInitialCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"gprsInitialCaptureDate"] integerValue]]];
  otaVehicleData.lastMileageCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"lastMileageCaptureDate"] integerValue]]];
  otaVehicleData.lastEnergyCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"lastEnergyCaptureDate"] integerValue]]];
  
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
  otaVehicleData.sdkGpsCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"sdkGpsCaptureDate"] integerValue]]];
  
  return otaVehicleData;
}

- (OTALastVehicleSynthesisPublic *) getOTALastVehicleSynthesisPublicFromDictionary: (NSDictionary *) dictionary
{
  OTALastVehicleSynthesisPublic *lastVehicleSynthesisPublic = [[OTALastVehicleSynthesisPublic alloc] init];
  lastVehicleSynthesisPublic.lastCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"lastCaptureDate"] integerValue]]];
  
  OTALastVehicleSynthesisGpsCoordinatesPublic *lastVehicleSynthesisGpsCoordinatesPublic = [self getOTALastVehicleSynthesisGpsCoordinatePublicFromDictionary: [dictionary objectForKey:@"gpsCoordinates"]];
  lastVehicleSynthesisPublic.gpsCoordinates = lastVehicleSynthesisGpsCoordinatesPublic;
  
  OTADoorsState doorsState = [[dictionary objectForKey:@"doorsState"] integerValue];
  lastVehicleSynthesisPublic.doorsState = doorsState;
  
  lastVehicleSynthesisPublic.engineRunning = [[dictionary objectForKey:@"engineRunning"] boolValue];
  lastVehicleSynthesisPublic.lastMileageCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"lastMileageCaptureDate"] integerValue]]];
  lastVehicleSynthesisPublic.mileage = [NSNumber numberWithInteger:[[dictionary objectForKey:@"mileage"] integerValue]];
  lastVehicleSynthesisPublic.lastEnergyCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[dictionary objectForKey:@"lastEnergyCaptureDate"]]];
  lastVehicleSynthesisPublic.energyLevel = [NSNumber numberWithInteger:[[dictionary objectForKey:@"energyLevel"] integerValue]];
  lastVehicleSynthesisPublic.batteryVoltage = [NSNumber numberWithInteger:[[dictionary objectForKey:@"batteryVoltage"] integerValue]];
  lastVehicleSynthesisPublic.connectedToCharger = [[dictionary objectForKey:@"connectedToCharger"] boolValue];
  lastVehicleSynthesisPublic.malfunctionIndicatorLamp = [[dictionary objectForKey:@"malfunctionIndicatorLamp"] boolValue];
  
  OTAEnergyType energyType = [[dictionary objectForKey:@"energyType"] integerValue];
  lastVehicleSynthesisPublic.energyType = energyType;
  
  OTAFuelUnit fueltUnit = [[dictionary objectForKey:@"fuelUnit"] integerValue];
  lastVehicleSynthesisPublic.fuelUnit = fueltUnit;
  
  OTAOdometerUnit odometerUnit = [[dictionary objectForKey:@"odometerUnit"] integerValue];
  lastVehicleSynthesisPublic.odometerUnit = odometerUnit;
  
  lastVehicleSynthesisPublic.activeDtcNumber = [NSNumber numberWithInteger:[[dictionary objectForKey:@"activeDtcNumber"] integerValue]];
  
  return lastVehicleSynthesisPublic;
}

- (OTALastVehicleSynthesisGpsCoordinatesPublic *) getOTALastVehicleSynthesisGpsCoordinatePublicFromDictionary: (NSDictionary *) dictionary
{
  OTALastVehicleSynthesisGpsCoordinatesPublic *lastVehicleSynthesisGpsCoordinatesPublic = [[OTALastVehicleSynthesisGpsCoordinatesPublic alloc] init];
  lastVehicleSynthesisGpsCoordinatesPublic.initialCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"initialCaptureDate"] integerValue]]];
  lastVehicleSynthesisGpsCoordinatesPublic.lastCaptureDate = [self dateFromIntTimestap:[NSNumber numberWithInteger:[[dictionary objectForKey:@"lastCaptureDate"] integerValue]]];
  lastVehicleSynthesisGpsCoordinatesPublic.latitude = [NSNumber numberWithInteger:[[dictionary objectForKey:@"latitude"] integerValue]];
  lastVehicleSynthesisGpsCoordinatesPublic.longitude = [NSNumber numberWithInteger:[[dictionary objectForKey:@"longitude"] integerValue]];
  return lastVehicleSynthesisGpsCoordinatesPublic;
}

- (NSDictionary *) resolveOTAKeyPublicDictionary: (NSDictionary *) dictionary
{
  OTAVehiclePublic *vehiclePublic = [dictionary objectForKey:@"vehicle"];
  OTAVehicleData *vehicleData = vehiclePublic.vehicleData;
  
  NSDictionary *vehicleDataDictionary = [self dictionaryWithPropertiesOfObject: vehicleData];
  NSDictionary *vehiclePublicDictionary = [self dictionaryWithPropertiesOfObject:vehiclePublic];
  
  [vehiclePublicDictionary setValue:vehicleDataDictionary forKey:@"vehicleData"];
  
  OTALastVehicleSynthesisPublic *vehicleSynthesis = [dictionary objectForKey:@"lastVehicleSynthesis"];
  OTALastVehicleSynthesisGpsCoordinatesPublic *gpsCoordinates = vehicleSynthesis.gpsCoordinates;
  
  NSDictionary *vehicleSynthesisDictionary = [self dictionaryWithPropertiesOfObject: vehicleSynthesis];
  NSDictionary *vehicleGpsCoordinatesDictionary = [self dictionaryWithPropertiesOfObject:gpsCoordinates];
  
  [vehicleSynthesisDictionary setValue:vehicleGpsCoordinatesDictionary forKey:@"gpsCoordinates"];
  
  [dictionary setValue:vehiclePublicDictionary forKey:@"vehicle"];
  [dictionary setValue:vehicleSynthesisDictionary forKey:@"lastVehicleSynthesis"];
  
  return dictionary;
}

- (NSDictionary *) resolveOTALastVehicleSynthesisPublic: (OTALastVehicleSynthesisPublic *) lastVehicleSynthesis
{
  ModelUtils *utils = [[ModelUtils alloc] init];
  OTALastVehicleSynthesisGpsCoordinatesPublic *gpsCoordinates = lastVehicleSynthesis.gpsCoordinates;
  NSDictionary *gpsCoordinatesDic = [utils dictionaryWithPropertiesOfObject:gpsCoordinates];
  NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:lastVehicleSynthesis];
  [dic setValue:gpsCoordinatesDic forKey:@"gpsCoordinates"];
  return dic;
}

@end

