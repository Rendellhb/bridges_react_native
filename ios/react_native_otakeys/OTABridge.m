//
//  OTABridge.m
//  react_native_otakeys
//
//  Created by Rendell Hoffmann Bernardes on 15/02/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "OTABridge.h"
#import "ModelUtils.h"

@implementation OTABridge

// To export a module named CalendarManager
RCT_EXPORT_MODULE();

/*
 The easiest way to start creating a bridge, send a string get it back and print
 I left this one just for an example so you guys can use as a guide
 */
RCT_EXPORT_METHOD(printSomething: (NSString *) awesomeText
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  awesomeText != nil ? resolve(awesomeText) : reject(@"No text", @"C'mom gimme some text!", nil);
}

RCT_EXPORT_METHOD(openSessionWithToken: (NSString *) token
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] openSessionWithToken:@"token"
                                      success:^(bool success) {
                                        resolve(@YES);
                                      }
                                      failure:^(OTAErrorCode errorCode, NSError *error) {
                                        reject(@"Error", @"Error opening session", error);
                                      }];
}

RCT_EXPORT_METHOD(authenticated:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] authenticated] ? resolve(@YES) : reject(@"Error", @"Error get informed by authentication status", nil);
}

RCT_EXPORT_METHOD(configureWithAppId: (NSString *) appID
                  SDKInstanceID: (NSString *) sdkInstanceID
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  
  [[OTAManager instance] configureWithAppId:(NSString *) appID
                              SDKInstanceID:(NSString *) sdkInstanceID];
  resolve(@YES);
}

RCT_EXPORT_METHOD(closeSession: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] closeSession];
  resolve(@YES);
}

RCT_EXPORT_METHOD(switchToKeyWithID: (NSString *) otaKey
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  __block BOOL isResolved = NO;
  [[OTAManager instance] switchToKeyWithID:otaKey
     completionBlock:^(BOOL completed) {
       if (!isResolved) {
         completed ? resolve(@YES) : reject(@"Error", @"Error switching to key with ID", nil);
       }
       isResolved = YES;
     }];
}

RCT_EXPORT_METHOD(accessDeviceTokenWithForceRefresh: (BOOL) forceRefresh
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  NSString *result = [[OTAManager instance] accessDeviceTokenWithForceRefresh:(BOOL) forceRefresh];
  result == nil || [result length] == 0 ? reject(@"Error", @"Error accessing device token with force refresh", nil) : resolve(result);
}

RCT_EXPORT_METHOD(createKey: (NSString *) otaKeyRequestJSON
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  ModelUtils *utils = [[ModelUtils alloc] init];
//  OTAKeyRequest *keyRequest = [utils getOTAKeyRequestObjectFromJson:otaKeyRequestJSON];
  
  NSData* data = [otaKeyRequestJSON dataUsingEncoding:NSUTF8StringEncoding];
  
  NSError *error;
  __block NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  
  OTAKeyRequest *keyRequest = [OTAKeyRequest makeWithBuilder:^(OTAKeyRequestBuilder *builder) {
    OTAKeyRequestBuilder *krBuilder = [utils getOTAKeyRequestFromDictionary: dictionary];
    builder.otaId = krBuilder.otaId;
    builder.extId = krBuilder.extId;
    builder.beginDate = krBuilder.beginDate;
    builder.endDate = krBuilder.endDate;
    builder.vehicleId = krBuilder.vehicleId;
    builder.vehicleExtId = krBuilder.vehicleExtId;
    builder.enableNow = krBuilder.enableNow;
    builder.tokenAmount = krBuilder.tokenAmount;
    builder.singleShotSecurity = krBuilder.singleShotSecurity;
    builder.security = krBuilder.security;
  }];
  
  [[OTAManager instance] createKey:(OTAKeyRequest *) keyRequest completion:^(OTAKeyPublic * keyPublic, NSError * error) {
    if  (error == nil) {
      NSDictionary *dic = [utils dictionaryWithPropertiesOfObject: keyPublic];
      NSDictionary *treatedDic = [utils resolveOTAKeyPublicDictionary:dic];
      NSString *jsonresult = [utils convertObjectToJson:treatedDic];
      resolve(jsonresult);
    } else {
      reject(@"Error", @"Error creating key", error);
    }
  }];
}

RCT_EXPORT_METHOD(updateKey: (NSString *) otaKeyRequestJSON
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  ModelUtils *utils = [[ModelUtils alloc] init];
  OTAKeyRequest *keyRequest = [utils getOTAKeyRequestObjectFromJson:otaKeyRequestJSON];
  
  [[OTAManager instance] updateKey:(OTAKeyRequest *) keyRequest completion:^(OTAKeyPublic * keyPublic, NSError * error) {
    if  (error == nil) {
      NSDictionary *dic = [utils dictionaryWithPropertiesOfObject: keyPublic];
      NSDictionary *treatedDic = [utils resolveOTAKeyPublicDictionary:dic];
      NSString *jsonresult = [utils convertObjectToJson:treatedDic];
      resolve(jsonresult);
    } else {
      reject(@"Error", @"Error updating key", error);
    }
  }];
}

RCT_EXPORT_METHOD(enableKey: (NSString *) otaKeyRequestJSON
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  ModelUtils *utils = [[ModelUtils alloc] init];
  OTAKeyRequest *keyRequest = [utils getOTAKeyRequestObjectFromJson:otaKeyRequestJSON];
  
  [[OTAManager instance] enableKey:(OTAKeyRequest *) keyRequest completion:^(OTAKeyPublic * keyPublic, NSError * error) {
    if  (error == nil) {
      NSDictionary *dic = [utils dictionaryWithPropertiesOfObject: keyPublic];
      NSDictionary *treatedDic = [utils resolveOTAKeyPublicDictionary:dic];
      NSString *jsonresult = [utils convertObjectToJson:treatedDic];
      resolve(jsonresult);
    } else {
      reject(@"Error", @"Error enabling key", error);
    }
  }];
}

RCT_EXPORT_METHOD(endKey: (NSString *) otaKeyRequestJSON
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  ModelUtils *utils = [[ModelUtils alloc] init];
  OTAKeyRequest *keyRequest = [utils getOTAKeyRequestObjectFromJson:otaKeyRequestJSON];
  
  [[OTAManager instance] endKey:(OTAKeyRequest *) keyRequest completion:^(OTAKeyPublic * keyPublic, NSError * error) {
    if  (error == nil) {
      NSDictionary *dic = [utils dictionaryWithPropertiesOfObject: keyPublic];
      NSDictionary *treatedDic = [utils resolveOTAKeyPublicDictionary:dic];
      NSString *jsonresult = [utils convertObjectToJson:treatedDic];
      resolve(jsonresult);
    } else {
      reject(@"Error", @"Error ending key", error);
    }
  }];
}

RCT_EXPORT_METHOD(endKeyWithId: (NSString *) keyID
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] endKeyWithID:keyID success:^(OTAKeyPublic *keyPublic) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject: keyPublic];
    NSDictionary *treatedDic = [utils resolveOTAKeyPublicDictionary:dic];
    NSString *jsonresult = [utils convertObjectToJson:treatedDic];
    resolve(jsonresult);
  } failure:^(OTAErrorCode otaErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat:@"Error ending key with id: %li", otaErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(keysWithSuccess: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] keysWithSuccess:^(NSArray<OTAKeyPublic *> *otaKeyPublicArray) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSMutableArray *dicArray = [[NSMutableArray alloc] init];

    for (OTAKeyPublic *keyPublic in otaKeyPublicArray) {
      NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:keyPublic];
      NSDictionary *keyPublicDictionary = [utils resolveOTAKeyPublicDictionary:dic];
      [dicArray addObject:keyPublicDictionary];
    }

    NSString *json = [utils getJsonFromNSArray: dicArray];
    resolve(json);
  } failure:^(OTAErrorCode otaErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat:@"Error keys without success: %li", otaErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(scanForVehicleWithCompletion :(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] scanForVehicleWithCompletion:^(NSError *error) {
    error == nil ? resolve(@YES) : reject(@"Error", @"Error scanning vehicle with completion", error);
  }];
}

RCT_EXPORT_METHOD(scanForVehicleWithTimeout: (NSUInteger *) timeoutInSeconds
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] scanForVehicleWithTimeout:(long)timeoutInSeconds
                                        completion:^(NSError *error) {
                                          error == nil ? resolve(@YES) : reject(@"Error", [NSString stringWithFormat:@"Error scanning vehicle with timeout: %li", (long)timeoutInSeconds], error);
                                        }];
}

RCT_EXPORT_METHOD(connectToVehicle:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] connectToVehicle];
}

RCT_EXPORT_METHOD(connectToVehicleWithCompletion: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] connectToVehicleWithCompletion:^(NSError *error) {
    error == nil ? resolve(@YES) : reject(@"Error", @"Error connecting to vehicle", error);
  }];
}

RCT_EXPORT_METHOD(connectToVehicleWithTimeout: (NSUInteger *) timeoutInSeconds
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] connectToVehicleWithTimeout:(long)timeoutInSeconds completion:^(NSError *error) {
    error == nil ? resolve(@YES) : reject(@"Error", [NSString stringWithFormat:@"Error connecting to vehicle timeout:%li", (long)timeoutInSeconds], error);
  }];
}

RCT_EXPORT_METHOD(connectedToVehicle: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] connectedToVehicle] ? resolve(@YES) : reject(@"Error", @"Error getting information about vehicle connectivity", nil);
}

RCT_EXPORT_METHOD(currentConnectionStatus: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  OTABLEConnectionStatus *status = [[OTAManager instance] currentConnectionStatus];
  resolve([NSString stringWithFormat:@"%li", (long)status]);
}

RCT_EXPORT_METHOD(disconnectFromVehicle: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] disconnectFromVehicle];
}

RCT_EXPORT_METHOD(unlockDoorsWithRequestVehicleData: (BOOL *) requestVehicleData
                  enableEngine: (BOOL *) enableEngine
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] unlockDoorsWithRequestVehicleData:requestVehicleData enableEngine:enableEngine
     success:^(OTAVehicleData *vehicleData) {
       ModelUtils *utils = [[ModelUtils alloc] init];
       NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
       resolve([utils getJsonFromNSDictionary: dic]);
     } failure:^(OTAVehicleData *otaVehicleData, OTABLEErrorCode otableErrorCode, NSError *error) {
       reject(@"Error", [NSString stringWithFormat: @"Unable to unlock doors with request data: %li", (long)otableErrorCode], error);
     }];
}

RCT_EXPORT_METHOD(lockDoorsWithRequestVehicleData: (BOOL *) requestVehicleData
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] lockDoorsWithRequestVehicleData:requestVehicleData success:^(OTAVehicleData *vehicleData) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTAVehicleData *vehicleData, OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to lock doors with request data: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(vehicleDataWithSuccess: (NSString *) otaKeyJson
                  findEventsWithResolver: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] vehicleDataWithSuccess:^(OTAVehicleData *vehicleData) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to request information from vehicle: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(lastVehicleSynthesisWithSuccess: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] lastVehicleSynthesisWithSuccess:^(OTALastVehicleSynthesisPublic *lastVehicleSynthesis) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils resolveOTALastVehicleSynthesisPublic:lastVehicleSynthesis];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to get last synthesis from vehicle with success: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(lastVehicleSynthesis: (NSString *) keyRequestJson
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  ModelUtils *utils = [[ModelUtils alloc] init];
  OTAKeyRequest *keyRequest = [utils getOTAKeyRequestObjectFromJson:keyRequestJson];
  [[OTAManager instance] lastVehicleSynthesis:(OTAKeyRequest *)keyRequest success:^(OTALastVehicleSynthesisPublic *lastVehicleSynthesis) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils resolveOTALastVehicleSynthesisPublic:lastVehicleSynthesis];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to get last synthesis from vehicle: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(lastVehicleSynthesisForKeyWithId: (NSString *) keyId
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] lastVehicleSynthesisForKeyWithId:keyId success:^(OTALastVehicleSynthesisPublic *lastVehicleSynthesis) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils resolveOTALastVehicleSynthesisPublic:lastVehicleSynthesis];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to get last synthesis from vehicle with key id: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(enableEngineWithRequestVehicleData: (BOOL *) requestVehicleData
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] enableEngineWithRequestVehicleData:requestVehicleData success:^(OTAVehicleData *vehicleData) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTAVehicleData *vehicleData, OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to enable engine with request vehicle data: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(disableEngineWithRequestVehicleData: (BOOL *) requestVehicleData
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] disableEngineWithRequestVehicleData:requestVehicleData success:^(OTAVehicleData *vehicleData) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTAVehicleData *vehicledata, OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to disable engine with request vehicle data: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(unnamedAction1WithRequestVehicleData: (BOOL *) requestVehicleData
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] unnamedAction1WithRequestVehicleData:requestVehicleData success:^(OTAVehicleData *vehicleData) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTAVehicleData *vehicleData, OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to perform unnamed Action 1: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(unnamedAction2WithRequestVehicleData: (BOOL *) requestVehicleData
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] unnamedAction2WithRequestVehicleData:requestVehicleData success:^(OTAVehicleData *vehicleData) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTAVehicleData *vehicleData, OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to perform unnamed Action 2: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(unnamedAction3WithRequestVehicleData: (BOOL *) requestVehicleData
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] unnamedAction3WithRequestVehicleData:requestVehicleData success:^(OTAVehicleData *vehicleData) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTAVehicleData *vehicleData, OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to perform unnamed Action 3: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(unnamedAction4WithRequestVehicleData: (BOOL *) requestVehicleData
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] unnamedAction4WithRequestVehicleData:requestVehicleData success:^(OTAVehicleData *vehicleData) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTAVehicleData *vehicleData, OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to perform unnamed Action 4: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(unnamedAction5WithRequestVehicleData: (BOOL *) requestVehicleData
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] unnamedAction5WithRequestVehicleData:requestVehicleData success:^(OTAVehicleData *vehicleData) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTAVehicleData *vehicleData, OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to perform unnamed Action 5: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(unnamedAction6WithRequestVehicleData: (BOOL *) requestVehicleData
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] unnamedAction6WithRequestVehicleData:requestVehicleData success:^(OTAVehicleData *vehicleData) {
    ModelUtils *utils = [[ModelUtils alloc] init];
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:vehicleData];
    resolve([utils getJsonFromNSDictionary: dic]);
  } failure:^(OTAVehicleData *vehicleData, OTABLEErrorCode otableErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to perform unnamed Action 6: %li", (long)otableErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(generateTokens: (NSString *) otaKeyRequestJSON
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  ModelUtils *utils = [[ModelUtils alloc] init];
  OTAKeyRequest *keyRequest = [utils getOTAKeyRequestObjectFromJson:otaKeyRequestJSON];
  
  [[OTAManager instance] generateTokens:(OTAKeyRequest *) keyRequest completion:^(OTAKeyPublic * keyPublic, NSError * error) {
    if  (error == nil) {
      NSDictionary *dic = [utils dictionaryWithPropertiesOfObject: keyPublic];
      NSString *jsonresult = [utils convertObjectToJson:dic];
      resolve(jsonresult);
    } else {
      reject(@"Error", @"Error creating key", error);
    }
  }];
}

RCT_EXPORT_METHOD(localKeys: (NSInteger *) id
                  withExtId: (NSString *) extId
                  findEventsWithResolver: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  NSArray *array = [[OTAManager instance] localKeys];
  ModelUtils *utils = [[ModelUtils alloc] init];
  NSMutableArray *dicArray = [[NSMutableArray alloc] init];
  
  for (OTAKeyPublic *keyPublic in array) {
    NSDictionary *dic = [utils dictionaryWithPropertiesOfObject:keyPublic];
    NSDictionary *keyPublicDictionary = [utils resolveOTAKeyPublicDictionary:dic];
    [dicArray addObject:keyPublicDictionary];
  }
  
  resolve([utils getJsonFromNSArray: dicArray]);
}

RCT_EXPORT_METHOD(localKey: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  ModelUtils *utils = [[ModelUtils alloc] init];
  OTAKeyPublic *keyPublic = [[OTAManager instance] localKey];
  NSDictionary *dic = [utils resolveOTAKeyPublicDictionary:[utils dictionaryWithPropertiesOfObject:keyPublic]];
  
  resolve([utils getJsonFromNSDictionary: dic]);
}

RCT_EXPORT_METHOD(currentKey: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  ModelUtils *utils = [[ModelUtils alloc] init];
  OTAKeyPublic *keyPublic = [[OTAManager instance] currentKey];
  NSDictionary *dic = [utils resolveOTAKeyPublicDictionary:[utils dictionaryWithPropertiesOfObject:keyPublic]];
  
  resolve([utils getJsonFromNSDictionary: dic]);
}

RCT_EXPORT_METHOD(syncVehicleDataWithSuccess: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] syncVehicleDataWithSuccess:^(BOOL success){
    resolve (@YES);
  } failure:^(OTAErrorCode otaErrorCode, NSError *error) {
    reject(@"Error", [NSString stringWithFormat: @"Unable to sync vehicle data: %li", (long)otaErrorCode], error);
  }];
}

RCT_EXPORT_METHOD(activateLogging: (BOOL *) activate
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] activateLogging:activate];
}

RCT_EXPORT_METHOD(localKeyWithCompletionBlock: (NSString *) otaKeyJSON
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] localKeyWithCompletionBlock:^(OTAKeyPublic *otaKeyPublic) {
    
    
    NSArray *otaKeyPublicArray = [NSArray arrayWithObjects:otaKeyPublic.extId, otaKeyPublic.otaId, otaKeyPublic.beginDate, otaKeyPublic.endDate, otaKeyPublic.enabled, otaKeyPublic.mileageLimit, otaKeyPublic.singleShotSecurity, otaKeyPublic.keyArgs, otaKeyPublic.keySensitiveArgs, otaKeyPublic.vehicle, otaKeyPublic.lastVehicleSynthesis, nil];
    otaKeyPublic ? resolve(otaKeyPublicArray) : reject(@"Error", @"Error getting local key completion block", nil);
  }];
}

RCT_EXPORT_METHOD(getAccessDeviceToken:
                  (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  resolve([OTAManager instance].accessDeviceToken);
}

RCT_EXPORT_METHOD(isAuthenticated: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  resolve([NSNumber numberWithBool:[OTAManager instance].authenticated]);
}


@end
