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
 */
RCT_EXPORT_METHOD(printSomething: (NSString *) name
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  name != nil ? resolve(name) : reject(@"No name", @"Não passou nenhum nome", nil);
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

RCT_EXPORT_METHOD(authenticated: (NSNull *) null
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] authenticated] ? resolve(@YES) : reject(@"Error", @"Error get informed by authentication status", nil);
}

RCT_EXPORT_METHOD(configureWithAppId: (NSString *) appID
                  SDKInstanceID: (NSString *) sdkInstanceID)
{
  
  [[OTAManager instance] configureWithAppId:(NSString *) appID
                              SDKInstanceID:(NSString *) sdkInstanceID];
}

RCT_EXPORT_METHOD(closeSession: (NSNull *) null)
{
  [[OTAManager instance] closeSession];
}

RCT_EXPORT_METHOD(switchToKeyWithID: (NSString *) otaKey
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [[OTAManager instance] switchToKeyWithID:otaKey
                           completionBlock:^(BOOL completed) {
                             completed ? resolve(@YES) : reject(@"Error", @"Error switching to key with ID", nil);
                           }];
}

RCT_EXPORT_METHOD(accessDeviceTokenWithForceRefresh: (BOOL) forceRefresh
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  NSString *result = [[OTAManager instance] accessDeviceTokenWithForceRefresh:(BOOL) forceRefresh];
  result != nil && [result length] == 0 ? reject(@"Error", @"Error accessing device token with force refresh", nil) : resolve(result);
}

RCT_EXPORT_METHOD(createKey: (NSString *) otaKeyRequestJSON
                  findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  ModelUtils *utils = [[ModelUtils alloc] init];
  OTAKeyRequest *keyRequest = [[[ModelUtils alloc] init] getOTAKeyRequestObjectFromJson:otaKeyRequestJSON];
  
  NSString *jsonresult = [utils convertObjectToJson:keyRequest];
  
  resolve(jsonresult);
  
//  [[OTAManager instance] createKey:(OTAKeyRequest *) keyRequest completion:^(OTAKeyPublic * keyPublic, NSError * error) {
//    error == nil ? resolve(
//  }]
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
  [[OTAManager instance] localKeyWithCompletionBlock:^(OTAKeyPublic * _Nullable otaKeyPublic) {
    
    
    NSArray *otaKeyPublicArray = [NSArray arrayWithObjects:otaKeyPublic.extId, otaKeyPublic.otaId, otaKeyPublic.beginDate, otaKeyPublic.endDate, otaKeyPublic.enabled, otaKeyPublic.mileageLimit, otaKeyPublic.singleShotSecurity, otaKeyPublic.keyArgs, otaKeyPublic.keySensitiveArgs, otaKeyPublic.vehicle, otaKeyPublic.lastVehicleSynthesis, nil];
    otaKeyPublic ? resolve(otaKeyPublicArray) : reject(@"Error", @"Error getting local key completion block", nil);
  }];
}

@end
