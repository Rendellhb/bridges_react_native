//
//  OTAManager.h
//
//  Created by OTA keys on 11/02/15.
//  Copyright © 2017 OTA keys. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OTAEnums.h"
#import "OTAErrors.h"
#import "PlopActivator.h"

@class OTAKeyPublic;
@class OTALastVehicleSynthesisPublic;
@class OTAVehicleData;
@class OTAKeyRequest;
@class OTAKey;
@class OTAVehiclePublic;
/**
 The delegate class for Bluetooth events.
 */
@protocol OTABLEEventsDelegate<NSObject>

/**
 Delegate method for when the Bluetooth state of the SDK has changed.
 
 @param connectionStatus The new status of Bluetooth connectivity.
 @param error Error value related to the status.
 @since 3.3.0
 */
- (void)bluetoothStateChanged:(OTABLEConnectionStatus)connectionStatus withError:(OTABLEErrorCode)error;

/**
 Delegate method for when an operation has occurred on the vehicle's CSM. Operations are not necessarily the result of SDK actions (e.g. engine has started).
 
 @param operationCode Code of the operation, see `OTAOperationCode`.
 @param operationState State of the operation, see `OTAOperationState`.
 @since 3.3.0
 */
- (void)operationPerformedWithCode:(OTAOperationCode)operationCode andState:(OTAOperationState)operationState;

@end

NS_ASSUME_NONNULL_BEGIN

/**
 The main class for handling virtual keys and interacting with OTA keys CSMs.
 */
@interface OTAManager : NSObject

/**
 The delegate object for Bluetooth events.
 */
@property (nonatomic, weak) id<OTABLEEventsDelegate> delegate;

/**
 The database directory URL.
 */
@property (strong, nonatomic) NSURL *databaseDirectoryURL;

/**
 The current instance of OTAManager.
 
 @return The current instance of OTAManager.
 */
+ (instancetype)instance;

/**
 The current version of this SDK.
 
 @return The current version of this SDK.
 */
+ (NSString *)versionNumber;

////////////////////////////////////////////////////////////////////////////////



#pragma mark - Configuration
////////////////////////////////////////////////////////////////////////////////

/**
 Returns whether the SDK is authenticated to the OTA keys middleware.
 Returns true if `openSessionWithToken:success:failure:` was previously called.
 Returns false if `openSessionWithToken:success:failure:` has never been called or if closeSession was previously called.
 
 @since 3.4.0
 */
- (BOOL)authenticated;

/**
 Returns whether the SDK is currently connected to the vehicle's CSM through BLE.
 Connected means fully a fully established BLE connection, therefore excluding "discovering" and "connecting" BLE states.
 See `connectToVehicle` and `disconnectFromVehicle`.
 
 @since 3.4.0
 */
- (BOOL)connectedToVehicle;

/**
 Close the current session on this SDK.
 
 To open a new session, use `openSessionWithToken:success:failure:`.
 
 @since 1.0.0
 */
- (void)closeSession;

/**
 Manually configure the SDK with an existing App ID and SDK ID to bypass the middleware API integration.
 It is required to contact OTA keys to obtain those values.
 
 Note: OTA keys will not provide those values for production use without appropriate justification.
 
 @param appId An existing app ID provided by OTA keys.
 @param sdkInstanceId An existing SDK inctance ID provided by OTA keys.
 
 @since 1.0.0
 */
- (void)configureWithAppId:(NSString *)appId SDKInstanceID:(NSString *)sdkInstanceId;

/**
 Enable or disable the SDK GPS in the syntheses (useful for debugging). Enabling will start location service and trigger the request for the user.
 In order for this to work you must set NSLocationUsageDescription, NSLocationWhenInUseUsageDescription, NSLocationUsageDescription in the plist file of your target.
 
 @since 3.8.0
 */
- (void)enableSDKGPS:(BOOL)enabled;

/**
 Set the environment on which the SDK will connect to.
 
 @param environment The OTA keys environment to connect to.
 
 @since 1.0.0
 */
- (void)configureEnvironment:(OTAEnvironment)environment;

/**
 The access device token required for identifying this SDKs instance between your middleware and OTA keys.
 
 @return The access device token.
 
 @since 1.0.0
 */
- (NSString *)accessDeviceToken;

/**
 Same as `accessDeviceToken` but with a prior deletion of the previous value.
 
 @return The access device token.
 
 @since 1.0.0
 */
- (NSString *)accessDeviceTokenWithForceRefresh:(BOOL)forceRefresh;

////////////////////////////////////////////////////////////////////////////////



#pragma mark - WS methods
////////////////////////////////////////////////////////////////////////////////

/**
 Request a new virtual key from OTA keys middleware. Internet is required for this action.
 
 @param otaKeyRequest The key request object containing the virtual key info. Required set fields in otaKeyRequest: beginDate, endDate, vehicleId or vehicleExtId
 @param completionBlock Block method called after completion.
 
 @since 3.6.0
 */
- (void)createKey:(OTAKeyRequest *)otaKeyRequest
       completion:(void (^ _Nullable)(OTAKeyPublic * _Nullable, NSError * _Nullable))completionBlock;

/**
 Update an existing virtual key through OTA keys middleware. Internet is required for this action.
 
 @param otaKeyRequest The key request object containing the virtual key info. Required set fields in otaKeyRequest: otaId or extId, beginDate, endDate
 @param completionBlock Block method called after completion.
 
 @since 3.6.0
 */
- (void)updateKey:(OTAKeyRequest *)otaKeyRequest
       completion:(void (^ _Nullable)(OTAKeyPublic * _Nullable, NSError * _Nullable))completionBlock;

/**
 Enables an existing virtual key. Enabling a virtual key is required in order to connect to the CSM. Internet is required for this action.
 
 @param otaKeyRequest The key request object containing the virtual key info. Required set fields in otaKeyRequest: otaId or extId
 @param completionBlock Block method called after completion.
 
 @since 3.6.0
 */
- (void)enableKey:(OTAKeyRequest *)otaKeyRequest
       completion:(void (^ _Nullable)(OTAKeyPublic * _Nullable, NSError * _Nullable))completionBlock;

/**
 Ends the usage of a virtual key. After ending, the virtual key may no longer be used with the CSM. Internet is required for this action.
 
 @param otaKeyRequest The key request object containing the virtual key info. Required set fields in otaKeyRequest: otaId or extId
 @param completionBlock Block method called after completion.
 
 @since 3.6.0
 */
- (void)endKey:(OTAKeyRequest *)otaKeyRequest
    completion:(void (^ _Nullable)(OTAKeyPublic * _Nullable, NSError * _Nullable))completionBlock;

/**
 Generates new tokens for the given virtual key.
 
 @param otaKeyRequest The key request object containing the virtual key info. Required set fields in otaKeyRequest: otaId or extId, tokenAmount
 @param completionBlock Block method called after completion.
 
 @since 3.7.0
 */
- (void)generateTokens:(OTAKeyRequest *)otaKeyRequest
            completion:(void (^ _Nullable)(OTAKeyPublic * _Nullable, NSError * _Nullable))completionBlock;

/**
 Returns the amount of tokens for the current virtual key. Returns -1 if the virtual key does not exist or if the current virtual key has not been enabled yet.
 
 @since 3.7.0
 */
- (NSInteger)remainingTokenAmount;

/**
 Returns the amount of tokens for the given virtual key. Returns -1 if the virtual key does not exist, if the given virtual key has not been enabled yet.
 
 @param otaKeyRequest The key request object containing the virtual key info. Required set fields in otaKeyRequest: otaId
 
 @since 3.7.0
 */
- (NSInteger)remainingTokenAmount:(OTAKeyRequest *)otaKeyRequest;

/**
 Returns the amount of tokens for the given virtual key. Returns -1 if the virtual key does not exist, if the given virtual key has not been enabled yet.
 
 @param otaId The ID of the virtual key (`otaId` in `OTAKeyPublic`).
 
 @since 3.7.0
 */
- (NSInteger)remainingTokenAmountForKeyWithId:(NSString *)otaId;

/**
Deletes the tokens for the current virtual key.

@return true if tokens were found and have been deleted.

@since 3.8.0
*/
- (BOOL)cleanTokens;

/**
 Deletes the tokens for the given virtual key.
 
 @param otaKeyRequest The key request object containing the virtual key info. Required set fields in otaKeyRequest: otaId
 
 @return true if tokens were found and have been deleted.
 
 @since 3.8.0
 */
- (BOOL)cleanTokens:(OTAKeyRequest *)otaKeyRequest;

/**
 Deletes the tokens for the given virtual key.
 
 @param otaId The ID of the virtual key (`otaId` in `OTAKeyPublic`).
 
 @return true if tokens were found and have been deleted.
 
 @since 3.8.0
 */
- (BOOL)cleanTokensForKeyWithId:(NSString *)otaId;

 /**
 Authenticate the SDK to the OTA keys middleware. This is only needed on the first run of the SDK.
 
 To close the current session, use `closeSession`.
 
 @param token The token for autnehtication.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 1.0.0
 */
- (void)openSessionWithToken:(NSString *)token
                     success:(void (^ _Nullable)(BOOL))successBlock
                     failure:(void (^ _Nullable)(OTAErrorCode, NSError *))failureBlock;

/**
 Request a new virtual key from OTA keys middleware. Internet is required for this action.
 
 @param vehicleExtID The External ID (aka Client ID) of the vehicle on which to create a virtual key.
 @param extID An external ID for the virtual key.
 @param beginDate Begin date of the virtual key. The CSM will deny Bluetooth connection before that date.
 @param endDate End date of the virtual key. The CSM will deny Bluetooth connection after that date.
 @param enableKey Whether the virtual key should be enabled upon creation. If not, use `enableKeyWithID:success:failure:` to enable it later.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 1.0.0
 */
- (void)createKeyWithVehicleExtID:(NSString *)vehicleExtID
                            extID:(NSString * _Nullable)extID
                        beginDate:(NSDate *)beginDate
                          endDate:(NSDate *)endDate
                        enableKey:(BOOL)enableKey
                          success:(void (^ _Nullable)(OTAKeyPublic * _Nullable))successBlock
                          failure:(void (^ _Nullable)(OTAErrorCode, NSError *))failureBlock;

/**
 Update an existing virtual key through OTA keys middleware. Internet is required for this action.
 
 @param keyID The ID of the virtual key to update.
 @param beginDate New begin date of the virtual key. Mandatory (please provide the same begin date if no changes).
 @param endDate New end date of the virtual key. Mandatory (please provide the same end date if no changes).
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.5.0
 */
- (void)updateKeyWithID:(NSString *)keyID
              beginDate:(NSDate *)beginDate
                endDate:(NSDate *)endDate
                success:(void (^ _Nullable)(OTAKeyPublic * _Nullable))successBlock
                failure:(void (^ _Nullable)(OTAErrorCode, NSError *))failureBlock;

/**
 Enables an existing virtual key. Enabling a virtual key is required in order to connect to the CSM. Internet is required for this action.
 
 @param otaKeyID The ID of the virtual key (`otaId` in `OTAKeyPublic`).
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 1.0.0
 */
- (void)enableKeyWithID:(NSString *)otaKeyID
                success:(void (^ _Nullable)(OTAKeyPublic * _Nullable))successBlock
                failure:(void (^ _Nullable)(OTAErrorCode, NSError *))failureBlock;

/**
 Ends the usage of a virtual key. After ending, the virtual key may no longer be used with the CSM. Internet is required for this action.
 
 @param otaKeyID The ID of the virtual key (`otaId` in `OTAKeyPublic`).
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 1.0.0
 */
- (void)endKeyWithID:(NSString *)otaKeyID
             success:(void (^ _Nullable)(OTAKeyPublic * _Nullable))successBlock
             failure:(void (^ _Nullable)(OTAErrorCode, NSError *))failureBlock;

/**
 Download all the virtual keys of the current session from the OTA keys middleware.
 
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 1.0.0
 */
- (void)keysWithSuccess:(void (^ _Nullable)(NSArray<OTAKeyPublic *> * _Nullable))successBlock
                failure:(void (^ _Nullable)(OTAErrorCode, NSError *))failureBlock;

/**
 Download a specific virtual key from the OTA keys middleware.
 
 @param otaKeyID The ID of the virtual key (`otaId` in `OTAKeyPublic`).
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 1.0.0
 */
- (void)keyWithID:(NSString *)otaKeyID
          success:(void (^ _Nullable)(OTAKeyPublic * _Nullable))successBlock
          failure:(void (^ _Nullable)(OTAErrorCode, NSError *))failureBlock;

/**
 Switch to a specific virtual key in order to interact with the CSM through Bluetooth.
 Returns false if the given keyID could not be found.
 
 @param otaKeyID the ID of the virtual key (`otaId` in `OTAKeyPublic`).
 
 @since 3.4.0
 @deprecated use `switchToKeyWithID:completionBlock:` instead
 */
- (BOOL)switchToKeyWithID:(NSString *)otaKeyID;

/**
 Manually send all pending vehicle data (aka syntheses) saved on the SDK to the OTA keys middleware.
 Note that all vehicle data are also automatically sent during `endKeyWithID:success:failure:`.
 
 @param successBlock Block method if the action succeeded. The BOOL argument is false if the call succeeded but there were no vehicle data to send.
 @param failureBlock Block method if the action failed.
 
 @since 3.0.0
 */
- (void)syncVehicleDataWithSuccess:(void (^ _Nullable)(BOOL))successBlock
                           failure:(void (^ _Nullable)(OTAErrorCode, NSError *))failureBlock;

/**
 Download all the vehicle from the back end.
 
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 1.0.0
 */
- (void)vehiclesWithSuccess:(void (^ _Nullable)(NSArray<OTAVehiclePublic *> * _Nullable))successBlock
                failure:(void (^ _Nullable)(OTAErrorCode, NSError *))failureBlock;

/**
 Download all free vehicle from the back end.
 
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.9.0
 */
- (void)freeVehiclesWithSuccess:(void (^ _Nullable)(NSArray<OTAVehiclePublic *> * _Nullable, NSArray<NSNumber *> * _Nullable))successBlock
                    failure:(void (^ _Nullable)(OTAErrorCode, NSError *))failureBlock;

////////////////////////////////////////////////////////////////////////////////



#pragma mark - Local data methods
////////////////////////////////////////////////////////////////////////////////

/**
 Get the local virtual keys (previously downloaded and saved locally through `keysWithSuccess:failure:` and `createKeyWithVehicleExtID:extID:beginDate:endDate:enableKey:success:failure:`).
 
 @return An array of all the local virtual keys.
 
 @since 1.0.0
 */
- (NSArray<OTAKeyPublic *> *)localKeys;

/**
 Get the current virtual key on the SDK. The current virtual key is the last virtual key called by `switchToKeyWithID:completionBlock:`.
 
 @return The current virtual key.
 
 @since 3.3.0
 */
- (OTAKeyPublic * _Nullable)currentKey;

/**
 Same as `currentKey`.
 
 @return The current virtual key.
 
 @since 1.0.0
 */
- (OTAKeyPublic * _Nullable)localKey;

/**
 Get the vehicle's data history (aka syntheses) collected from the SDK.
 
 @return The array of vehicle data of the current virtual key.
 
 @since 1.0.0
 */
- (NSArray<OTAVehicleData *> *)vehicleDataHistory;

/**
 Get the vehicle's data history (aka syntheses) collected from the SDK for the given key ID.

 @param keyID The ID of the virtual key.

 @return The array of vehicle data of the current virtual key.

 @since 3.7.0
 */
- (NSArray<OTAVehicleData *> *)vehicleDataHistoryForKeyWithId:(NSString *)keyId;

////////////////////////////////////////////////////////////////////////////////



#pragma mark - BLE methods
////////////////////////////////////////////////////////////////////////////////
/**
 Scan for the vehicle's CSM of the current key with the default timeout (10 seconds). This does not actually connect to the vehicle. You must use `switchToKeyWithID:completionBlock:` prior to this.
 
 @param completionBlock Block method called after completion.
 
 @since 3.7.0
 */
- (void)scanForVehicleWithCompletion:(void (^ _Nullable)(NSError * _Nullable))completionBlock;

/**
 Scan for the vehicle's CSM of the current key with the given timeout. This does not actually connect to the vehicle. You must use `switchToKeyWithID:completionBlock:` prior to this.

 @param timeoutInSeconds Scan timeout in seconds.
 @param completionBlock Block method called after completion.
 
 @since 3.7.0
 */
- (void)scanForVehicleWithTimeout:(NSUInteger)timeoutInSeconds
                       completion:(void (^ _Nullable)(NSError * _Nullable))completionBlock;

/**
 Stop the current scan (if in progress). Does nothing if no scan is in progress.
 
 @since 3.7.0
 */
- (void)stopScanning;

/**
 Connect to the vehicle's CSM of the current key. You must use `switchToKeyWithID:completionBlock:` prior to this.
 
 @since 1.0.0
 */
- (void)connectToVehicle;

/**
 Connect to the vehicle's CSM of the current key with the default timeout (10 seconds). You must use `switchToKeyWithID:completionBlock:` prior to this.
 
 @param completionBlock Block method called after completion.
 
 @since 3.6.0
 */
- (void)connectToVehicleWithCompletion:(void (^ _Nullable)(NSError * _Nullable))completionBlock;

/**
 Connect to the vehicle's CSM of the current key. You must use `switchToKeyWithID:completionBlock:` prior to this.
 
 @param timeoutInSeconds Cconnection timeout in seconds.
 @param completionBlock Block method called after completion.
 
 @since 3.7.0
 */
- (void)connectToVehicleWithTimeout:(NSUInteger)timeoutInSeconds
                         completion:(void (^ _Nullable)(NSError * _Nullable))completionBlock;

/**
 Disconnect from the vehicle's CSM of the current key.
 
 @since 1.0.0
 */
- (void)disconnectFromVehicle;

/**
 Perform an unlock action on the vehicle's CSM.

 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.3.1
 */
- (void)unlockDoorsWithRequestVehicleData:(BOOL)requestVehicleData
                                  success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                  failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Perform an unlock action on the vehicle's CSM.
 
 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param enableEngine whether to enable the engine after the unlock. If NO, the behaviour is the same as `unlockDoorsWithRequestVehicleData:success:failure:`.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.6.0
 */
- (void)unlockDoorsWithRequestVehicleData:(BOOL)requestVehicleData
                             enableEngine:(BOOL)enableEngine
                                  success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                  failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Perform a lock action on the vehicle's CSM.
 
 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.3.1
 */
- (void)lockDoorsWithRequestVehicleData:(BOOL)requestVehicleData
                                success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Allow the start of the engine on the vehicle's CSM.
 
 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.3.1
 */
- (void)enableEngineWithRequestVehicleData:(BOOL)requestVehicleData
                                   success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                   failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Disallow the start of the engine on the vehicle's CSM.
 If the user tries to start anyway by inserting the key blade (non-keyless) or pressing Start/Stop (keyless), the vehicle will respond on its dashboard that the key could not be found.
 
 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.3.1
 */
- (void)disableEngineWithRequestVehicleData:(BOOL)requestVehicleData
                                    success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                    failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Perform the unnamed action 1 on the vehicle's CSM.
 Unnamed actions are actions (other than lock/unlock) that can be set during the CSM installation.
 Setting an unnamed action requires that the action is available on one of the buttons of the vehicle's key.
 Calling this method without having an unnamed action set on the CSM will result in an OTABLEUnavailableFeature error.
 
 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.4.0
 */
- (void)unnamedAction1WithRequestVehicleData:(BOOL)requestVehicleData
                                     success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                     failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Perform the unnamed action 2 on the vehicle's CSM.
 Unnamed actions are actions (other than lock/unlock) that can be set during the CSM installation.
 Setting an unnamed action requires that the action is available on one of the buttons of the vehicle's key.
 Calling this method without having an unnamed action set on the CSM will result in an OTABLEUnavailableFeature error.
 
 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.4.0
 */
- (void)unnamedAction2WithRequestVehicleData:(BOOL)requestVehicleData
                                     success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                     failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Perform the unnamed action 3 on the vehicle's CSM.
 Unnamed actions are actions (other than lock/unlock) that can be set during the CSM installation.
 Setting an unnamed action requires that the action is available on one of the buttons of the vehicle's key.
 Calling this method without having an unnamed action set on the CSM will result in an OTABLEUnavailableFeature error.
 
 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.4.0
 */
- (void)unnamedAction3WithRequestVehicleData:(BOOL)requestVehicleData
                                     success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                     failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Perform the unnamed action 4 on the vehicle's CSM.
 Unnamed actions are actions (other than lock/unlock) that can be set during the CSM installation.
 Setting an unnamed action requires that the action is available on one of the buttons of the vehicle's key.
 Calling this method without having an unnamed action set on the CSM will result in an OTABLEUnavailableFeature error.
 
 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.4.0
 */
- (void)unnamedAction4WithRequestVehicleData:(BOOL)requestVehicleData
                                     success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                     failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Perform the unnamed action 5 on the vehicle's CSM.
 Unnamed actions are actions (other than lock/unlock) that can be set during the CSM installation.
 Setting an unnamed action requires that the action is available on one of the buttons of the vehicle's key.
 Calling this method without having an unnamed action set on the CSM will result in an OTABLEUnavailableFeature error.
 
 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.4.0
 */
- (void)unnamedAction5WithRequestVehicleData:(BOOL)requestVehicleData
                                     success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                     failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Perform the unnamed action 6 on the vehicle's CSM.
 Unnamed actions are actions (other than lock/unlock) that can be set during the CSM installation.
 Setting an unnamed action requires that the action is available on one of the buttons of the vehicle's key.
 Calling this method without having an unnamed action set on the CSM will result in an OTABLEUnavailableFeature error.
 
 @param requestVehicleData whether to fill the `OTAVehicleData` object in the success/failure blocks. If NO, the `OTAVehicleData` object will be nil.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.4.0
 */
- (void)unnamedAction6WithRequestVehicleData:(BOOL)requestVehicleData
                                     success:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                                     failure:(void (^ _Nullable)(OTAVehicleData * _Nullable, OTABLEErrorCode, NSError *))failureBlock;

/**
 Get the latest known vehicle synthesis.
 The last vehicle synthesis is not the same as a vehicle data. Last vehicle synthesis contains also the last known capture dates of mileage, energy and synthesis (which could be different than "now").
 
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.

 @since 3.5.0
 */
- (void)lastVehicleSynthesisWithSuccess:(void (^ _Nullable)(OTALastVehicleSynthesisPublic * _Nullable))successBlock
                                failure:(void (^ _Nullable)(OTABLEErrorCode, NSError *))failureBlock;

/**
 Get the latest known vehicle synthesis for the given virtual key ID.
 The last vehicle synthesis is not the same as a vehicle data. Last vehicle synthesis contains also the last known capture dates of mileage, energy and synthesis (which could be different than "now").
 
 @param otaKeyRequest The key request object containing the virtual key info. Required set fields in otaKeyRequest: otaId
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.7.0
 */
- (void)lastVehicleSynthesis:(OTAKeyRequest *)otaKeyRequest
                     success:(void (^ _Nullable)(OTALastVehicleSynthesisPublic * _Nullable))successBlock
                     failure:(void (^ _Nullable)(OTABLEErrorCode, NSError *))failureBlock;


/**
 Get the latest known vehicle synthesis for the given virtual key ID.
 The last vehicle synthesis is not the same as a vehicle data. Last vehicle synthesis contains also the last known capture dates of mileage, energy and synthesis (which could be different than "now").
 
 @param keyID The ID of the virtual key.
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.7.0
 */
- (void)lastVehicleSynthesisForKeyWithId:(NSString *)keyId
                                 success:(void (^ _Nullable)(OTALastVehicleSynthesisPublic * _Nullable))successBlock
                                 failure:(void (^ _Nullable)(OTABLEErrorCode, NSError *))failureBlock;

/**
 Get the current vehicle data (aka synthesis) from the vehicle's CSM.
 
 @param successBlock Block method if the action succeeded.
 @param failureBlock Block method if the action failed.
 
 @since 3.0.0
 */
- (void)vehicleDataWithSuccess:(void (^ _Nullable)(OTAVehicleData * _Nullable))successBlock
                       failure:(void (^ _Nullable)(OTABLEErrorCode, NSError *))failureBlock;

/**
 Get the current connection status of the SDK with the CSM.
 
 @return The current connection status.
 
 @since 3.3.0
 */
- (OTABLEConnectionStatus)currentConnectionStatus;

////////////////////////////////////////////////////////////////////////////////

#pragma mark - ASYNC

/**
 Get the current virtual key on the SDK with asynchronous approach. The current virtual key is the last virtual key called by `switchToKeyWithID:completionBlock:`.
 
 @since 3.10.0
 */
- (void)currentKeyWithCompletionBlock:(void(^)(OTAKeyPublic * _Nullable))block;

/**
 Same as `currentKeyWithCompletionBlock`.
 
 @since 3.10.0
 */
- (void)localKeyWithCompletionBlock:(void(^)(OTAKeyPublic * _Nullable))block;

/**
 
 @since 3.10.0
 */
- (void)activateLogging:(BOOL)active;

/**
 Switch to a specific virtual key in order to interact with the CSM through Bluetooth.
 Returns false if the given keyID could not be found.
 
 @param otaKeyID the ID of the virtual key (`otaId` in `OTAKeyPublic`).
 
 @since 3.11.0
 */
- (void)switchToKeyWithID:(NSString *)otaKeyID completionBlock:(void(^)(BOOL))block;

@end
NS_ASSUME_NONNULL_END
