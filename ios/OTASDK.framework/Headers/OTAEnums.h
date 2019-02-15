//
//  OTAEnums.h
//
//  Created by OTA keys on 3/03/15.
//  Copyright © 2017 OTA keys. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 The doors' state of a vehicle.
 */
typedef NS_ENUM(NSInteger, OTADoorsState)
{
    /// Unknown doors state (currently not used)
    OTADoorsStateUnknown = 0,
    
    /// Locked doors
    OTADoorsStateLocked = 1,
    
    /// Unlocked doors
    OTADoorsStateUnlocked = 3,
    
    /// All Unlocked
    OTADoorsStateAllUnlocked
};

/**
 The environment of OTA keys middleware.
 */
typedef NS_ENUM(NSInteger, OTAEnvironment)
{
    /// OTA keys Sandbox environment
    OTAEnvironmentSandbox,

    /// OTA keys QA environment
    OTAEnvironmentQA,
    
    /// OTA keys VA environment
    OTAEnvironmentVA,
    
    /// OTA keys Production environment
    OTAEnvironmentProduction
};

/**
 The connection status between the SDK and the CSM.
 */
typedef NS_ENUM(NSInteger, OTABLEConnectionStatus) {
    /// Connected to the device
    OTABLEConnected,

    /// Currently looking for devices
    OTABLEDiscoveryInProgress,
    
    /// Currently connecting to a device
    OTABLEConnectionInProgress,
    
    /// Attempted to call currentConnectionStatus prior to connecting to a device. Not used.
    OTABLENotAvailable,
    
    /// Not connected to a device, or BLE is off
    OTABLENotConnected
};

/**
 The fuel unit of the fuel value (both found in OTAVehicleData).
 */
typedef NS_ENUM(NSInteger, OTAFuelUnit)
{
    /// Fuel value is in percentage
    OTAFuelUnitPercent = 0,
    
    /// Fuel value is in liters
    OTAFuelUnitLiters = 1,
    
    /// Fuel value is in gallons
    OTAFuelUnitGallons = 2,
    
    /// Fuel value is in unknown
    OTAFuelUnitUnknown
};

/**
 The energy type of the energy value (both found in OTAVehicleData).
 */
typedef NS_ENUM(NSInteger, OTAEnergyType)
{
    /// The vehicle uses regular fuel
    OTAEnergyTypeFuel = 0,
    
    /// The vehicle is electric
    OTAEnergyTypeElectric = 1,
    
    /// The vehicle is Unknown,
    OTAEnergyTypeUnknown
};

/**
 The unit for the odometer value (both found in OTAVehicleData).
 */
typedef NS_ENUM(NSInteger, OTAOdometerUnit)
{
    /// The unit on the odometer is kilometers
    OTAOdometerUnitKilometers = 0,
    
    /// The unit on the odometer is miles
    OTAOdometerUnitMiles = 1,
    
    /// The unit on the odometer is unknown
    OTAOdometerUnitUnknown
};

/**
 The distance type for the mileage value (both found in OTAVehicleData).
 */
typedef NS_ENUM(NSInteger, OTADistanceType)
{
    /// The distance is since last garage service
    OTADistanceTypeSinceDTC = 0,
    
    /// The distance is the same as on the odometer
    OTADistanceTypeOdometer = 1
};

/**
 The operation code received from the CSM after an action occured (whether it originates from a SDK action or not, see `operationPerformedWithCode:andState:`).
 */
typedef NS_ENUM(NSInteger, OTAOperationCode)
{
    /// No operation occurred
    OTAOperationCodeNoOperation = 0,
    
    /// Locking doors
    OTAOperationCodeLock = 1,
    
    /// Unlocking doors
    OTAOperationCodeUnlock = 2,
    
    /// Ending virtual key
    OTAOperationCodeEnd = 3,
    
    /// Engine is allowed to start
    OTAOperationCodeEngineReady = 4,
    
    /// Engine has stopped
    OTAOperationCodeEngineStopped = 5,
    
    /// Engine has started
    OTAOperationCodeEngineStarted = 6,
    
    /// Keyless unlock has occurred (when available)
    OTAOperationCodeKeylessEntry = 7,
    
    /// Going into reprog mode (for configuration only)
    OTAOperationCodeReprogMode = 8,
    
    /// Unnamed action 1 occurred
    OTAOperationCodeUnnamedAction1 = 9,
    
    /// Unnamed action 2 occurred
    OTAOperationCodeUnnamedAction2 = 10,
    
    /// Unnamed action 3 occurred
    OTAOperationCodeUnnamedAction3 = 11,
    
    /// Unnamed action 4 occurred
    OTAOperationCodeUnnamedAction4 = 12,
    
    /// Unnamed action 5 occurred
    OTAOperationCodeUnnamedAction5 = 13,
    
    /// Unnamed action 6 occurred
    OTAOperationCodeUnnamedAction6 = 14,
    
    /// Unknown operation
    OTAOperationCodeUnknown = 999
};

/**
 The state of the operation received from the CSM, see `OTAOperationCode`.
 */
typedef NS_ENUM(NSInteger, OTAOperationState)
{
    /// No status on operation
    OTAOperationStateNoStatus = 0,
    
    /// Currently no virtual key on this CSM
    OTAOperationStateNoKey = 1,
    
    /// The given virtual key is not valid
    OTAOperationStateInvalidKey = 2,
    
    /// No longer allowed to start the engine (usually goes with `OTAOperationCodeEngineReady`)
    OTAOperationStateRevoked = 3,
    
    /// Operation performed correctly
    OTAOperationStateOK = 4,
    
    /// Operation requires to be closer to the vehicle (optional on CSM, default is disabled). Only occurs with the allow engine start operation.
    OTAOperationStateOutOfRange = 5,
    
    /// Operation exists but is not set on the CSM (see unnamed actions)
    OTAOperationStateUnavailableFeature = 6,
    
    /// Operation is done (not the same as OK)
    OTAOperationStateOperationCompleted = 7,
    
    /// The vehicle has exceeded the mileage limit set on the virtual key (optional on CSM, default is disabled)
    OTAOperationStateIncorrectMileage = 8,
    
    /// The current date is before the begin date of the virtual key
    OTAOperationStateTooEarly = 9,
    
    /// The current date is after the end date of the virtual key
    OTAOperationStateTooLate = 10,
    
    /// The given security counter is below the expected counter on the CSM
    OTAOperationStateBadCounter = 11,
    
    /// The given VIN was different than the VIN set on the CSM
    OTAOperationStateBadVin = 12,
    
    /// The CSM currently has no time set
    OTAOperationStateNoTimeSet = 13,
    
    /// The virtual key is now in grace period, lock/unlock work but can't start the engine (default 30 min)
    OTAOperationStateGracePeriod = 14,
    
    /// An internal error on the CSM occurred (please contact OTA keys)
    OTAOperationStateInternalError = 15,
    
    /// The given token is incorrect
    OTAOperationStateTokenError = 16
};

@interface OTAEnums : NSObject

+ (NSString *)displayNameOTABLEConnectionStatus:(OTABLEConnectionStatus)connectionStatus;
+ (NSString *)displayNameOTAOperationCode:(OTAOperationCode)operationCode;
+ (NSString *)displayNameOTAOperationState:(OTAOperationState)operationState;

@end
