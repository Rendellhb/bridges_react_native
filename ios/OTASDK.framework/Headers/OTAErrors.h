//
//  OTAErrors.h
//
//  Created by OTA keys on 11/02/15.
//  Copyright © 2017 OTA keys. All rights reserved.
//

typedef NS_ENUM(NSInteger,OTAErrorCode) {
    
    OTA_NO_ERROR = 0,
    OTA_ACCESS_DENIED = 1,
    OTA_USER_ALREADY_HAS_A_BOOKING = 2,
    OTA_VEHICLE_NOT_AVAILABLE = 3,
    OTA_START_DATE_AFTER_END_DATE = 4,
    OTA_START_DATE_BEFORE_NOW = 5,
    OTA_DISTANCE_EQUAL_ZERO = 6,
    OTA_BOOKING_NOT_ENOUGH_LONG = 7,
    OTA_ERROR_ENDING_BOOKING = 8,
    OTA_ERROR_ADDING_DAMAGE = 9,
    OTA_ERROR_GETTING_LAST_NEWS = 10,
    OTA_ERROR_GETTING_NEXT_BOOKINGS = 11,
    OTA_ERROR_GETTING_USER_PROFILE = 12,
    OTA_ERROR_GETTING_USER_VEHICLES = 13,
    OTA_ERROR_CREATING_BOOKING = 14,
    OTA_ERROR_UPDATING_BOOKING = 15,
    OTA_ERROR_CANCELLING_BOOKING = 16,
    OTA_ERROR_COMPUTING_NB_MINUTES_AVAILABLE_FOR_EXTEND = 17,
    OTA_ERROR_EXTENDING_BOOKING = 18,
    OTA_NO_ERROR_AND_FIRST_CONNECTION = 19,
    OTA_ERROR_UUID_NOT_THE_SAME = 20,
    OTA_ERROR_UPDATING_IMEI = 21,
    OTA_ERROR_DOING_INVENTORY = 22,
    OTA_ERROR_GETTING_USER_MESSAGES = 23,
    OTA_ERROR_GETTING_AVAILABLE_VEHICLES = 24,
    OTA_ERROR_COMPUTING_POSSIBLE_ALTERNATIVES = 25,
    OTA_ERROR_DELETING_USER_NEWS = 26,
    OTA_ERROR_DELETING_USER_MESSAGE = 27,
    OTA_WARNING_VERSION_NOT_MATCH = 28,
    OTA_ERROR_RESET_PASSWORD = 29,
    OTA_ERROR_GETTING_LATEST_E_GOLF_STATUS = 30,
    OTA_ERROR_NO_STATUS_FOR_E_GOLF = 31,
    OTA_ERROR_VEHICLE_IS_NOT_AN_E_GOLF = 32,
    OTA_ERROR_UPLOADING_PICTURE_DAMAGE = 33,
    OTA_WARNING_CHECK_OUT_ALREADY_DONE = 34,
    OTA_WARNING_CHECK_IN_ALREADY_DONE = 35,
    OTA_WARNING_LEGAL_NOTICE_HAS_TO_BE_AGREED = 36,
    OTA_ERROR_GETTING_BOOKING_STATUS = 37,
    OTA_WARNING_NO_SECRET_QUESTION = 38,
    OTA_ERROR_UPDATING_SECRET_QUESTION = 39,
    OTA_ERROR_INVALID_SECRET_QUESTION = 40,
    OTA_ERROR_INVALID_SECRET_RESPONSE = 41,
    OTA_ERROR_NO_RIGHT_TO = 42,
    OTA_ERROR_GETTING_DAMAGES_ON_VEHICLES = 43,
    OTA_ERROR_STRUCTURE_TRANSACTION_FILE = 44,
    OTA_ERROR_STRUCTURE_DAMAGE_FILE = 45,
    OTA_ERROR_PARSING_TRANSACTION_FILE = 46,
    OTA_ERROR_PARSING_DAMAGE_FILE = 47,
    OTA_ERROR_TRANSACTION_FILE_IMPORT = 48,
    OTA_ERROR_DAMAGE_FILE_IMPORT = 49,
    OTA_ERROR_GETTING_DAMAGE = 50,
    OTA_ERROR_UPLOADING = 51,
    OTA_ERROR_DAMAGE_NOT_EXIST = 52,
    OTA_ERROR_GETTING_STATIONS = 53,
    OTA_ERROR_GETTING_VEHICLE_STATIONS = 54,
    // ERROR_INVALID_PARAMETER = 55,
    OTA_ERROR_INVALID_FILE = 56,
    OTA_ERROR_GETTING_FAQ = 57,
    OTA_ERROR_SENDING_MAIL = 58,
    OTA_ERROR_SAVE_ENTITY = 59,
    /* Exception */
    OTA_ERROR_EXCEPTION = 100,
    OTA_ERROR_WS_INVALID_PARAMETER = 101,
    OTA_ERROR_INVALID_PARAMETER = 102,
    OTA_ERROR_INVALID_AUTH_API_KEY = 110,
    OTA_ERROR_INVALID_AUTH_TIMESTAMP = 111,
    OTA_ERROR_INVALID_AUTH_TOKEN = 112,
    OTA_ERROR_INVALID_AUTH_SIGNATURE = 113,
    OTA_ERROR_INVALID_AUTH_TIME_DELAY = 114,
    
    OTA_ERROR_INVALID_AUTH_APP_ID = 120,
    /* Community Error */
    OTA_ERROR_COMMUNITY_NAME_NOT_UNIQUE = 200,
    OTA_ERROR_COMMUNITY_NAME_INVALID = 201,
    /* Station Error */
    OTA_ERROR_STATION_NAME_NOT_UNIQUE = 300,
    OTA_ERROR_STATION_NAME_INVALID = 301,
    OTA_ERROR_STATION_USER_INVALID = 302,
    OTA_ERROR_STATION_ACCOUNT_INVALID = 303,
    OTA_ERROR_STATION_LONGITUDE_INVALID = 304,
    OTA_ERROR_STATION_LATITUDE_INVALID = 305,
    OTA_ERROR_STATION_UTC_INVALID = 306,
    /* Assignation Error */
    OTA_ERROR_ASSIGNATION_NO_START_DATE = 601,
    OTA_ERROR_ASSIGNATION_START_DATE_IN_PAST = 602,
    OTA_ERROR_ASSIGNATION_END_BEFORE_START = 603,
    OTA_ERROR_ASSIGNATION_CHANGE_START_AFTER_BEGIN = 604,
    OTA_ERROR_ASSIGNATION_CANNOT_CHANGE_END = 605,
    OTA_ERROR_ASSIGNATION_CANNOT_CHANGE_STATION = 606,
    OTA_ERROR_ASSIGNATION_ALREADY_ON_EXISTING_PERIOD = 607,
    OTA_ERROR_ASSIGNATION_START_DATE_SAME_END = 608,
    OTA_ERROR_ASSIGNATION_COMMUNITY_ALREADY_ON_EXISTING_PERIOD = 650,
    OTA_ERROR_ASSIGNATION_MAX_COMMUNITY_TO_USER = 651,
    OTA_ERROR_US_FORBIDDEN_ACCESS = 652,
    OTA_ERROR_ASSIGNATION_STATION_ALREADY_ON_EXISTING_PERIOD = 660,
    OTA_ERROR_ASSIGNATION_MAX_STATION_TO_COMMUNITY = 661,
    OTA_ERROR_CS_FORBIDDEN_ACCESS = 662,
    OTA_ERROR_ASSIGNATION_VEHICLE_ALREADY_ON_EXISTING_PERIOD = 670,
    OTA_ERROR_ASSIGNATION_MAX_STATION_TO_VEHICLE = 671,
    OTA_ERROR_VS_FORBIDDEN_ACCESS = 672,
    /* User Error */
    OTA_ERROR_USER_LOGIN_EXIST = 700,
    OTA_ERROR_USER_EMAIL_EXIST = 701,
    OTA_ERROR_USER_LOGIN_NOT_EXIST = 702,
    OTA_ERROR_USER_DEACTIVATED = 703,
    OTA_ERROR_USER_WRONG_SECRET_RESPONSE = 704,
    OTA_ERROR_USER_NO_COMMUNITY = 705,
    OTA_ERROR_USER_NO_STATION = 706,
    OTA_ERROR_USER_LOGIN_BAD_CHARACTERS = 707,
    OTA_ERROR_UPDATE_PASSWORD_INVALID_LOGIN = 708,
    OTA_ERROR_USER_INVALID_SECRET_QUESTION = 709,
    OTA_ERROR_USER_INVALID_SECRET_RESPONSE = 710,
    OTA_ERROR_USER_FORBIDDEN_ACCESS = 711,
    OTA_ERROR_USER_LOGIN = 712,
    OTA_ERROR_USER_PASSWORD = 713,
    OTA_ERROR_USER_SECRET_QUESTION_EMPTY = 714,
    /* Status Error */
    OTA_ERROR_SAME_ACTIVATION_STATUS = 800,
    /* Legal Notice */
    OTA_ERROR_LEGAL_NOTICE_FORBIDDEN_ACCESS = 900,
    OTA_ERROR_LEGAL_NOTICE_HAS_TO_BE_AGREED = 901,
    /* Booking */
    OTA_ERROR_BOOKING_NO_INVENTORY = 1002,
    OTA_ERROR_BOOKING_FORBIDDEN_ACCESS = 1003,
    OTA_ERROR_BOOKING_CANCEL_ALREADY_DELEGATED = 1004,
    OTA_ERROR_BOOKING_CANCEL_ALREADY_CANCELED = 1005,
    OTA_ERROR_BOOKING_CANCEL_ALREADY_BEGUN = 1006,
    OTA_ERROR_BOOKING_CANCEL_ALREADY_ENDED = 1007,
    OTA_ERROR_BOOKING_UPDATE_ALREADY_BEGUN = 1008,
    OTA_ERROR_BOOKING_UPDATE_ALREADY_ENDED = 1009,
    OTA_ERROR_BOOKING_EXTEND_NOT_ENOUGH_TIME_ADD = 1010,
    OTA_ERROR_BOOKING_EXTERNAL_REFERENCE = 1011,
    OTA_ERROR_BOOKING_UPDATE_ALREADY_DELEGATED = 1012,
    OTA_ERROR_BOOKING_UPDATE_ALREADY_CANCELED = 1013,
    OTA_ERROR_BOOKING_SHORTEN_BEFORE_NOW = 1014,
    OTA_ERROR_BOOKING_SHORTEN_AFTER_OLD_END = 1015,
    OTA_ERROR_BOOKING_EXTENDS_BEFORE_OLD_END = 1016,
    OTA_ERROR_BOOKING_UPDATE_BEFORE_NOW = 1017,
    /* Damage */
    OTA_ERROR_DAMAGE_NO_AREA_EXISTING = 1101,
    OTA_ERROR_DAMAGE_ALREADY_CREATED = 1102,
    OTA_ERROR_DAMAGE_WRONG_NEW_STATE_OLDER_STATE_NOT_COMPATIBLE = 1103,
    /* Vehicle */
    OTA_ERROR_VEHICLE_LICENCE_PLATE_EMPTY = 1201,
    OTA_ERROR_INVALID_VEHICLE_ID = 1202,
    OTA_ERROR_VEHICLE_MANUFACTURER_EMPTY = 1203,
    OTA_ERROR_VEHICLE_MODEL_EMPTY = 1204,
    /* Transaction state */
    OTA_ERROR_FILE_STATE_NOT_ENDED = 1300,
    /* Transaction info */
    OTA_ERROR_FILE_INFO_NOT_ENDED = 1350,
    /* Account */
    OTA_ERROR_ACCOUNT_FORBIDDEN_ACCESS = 1400,
    OTA_ERROR_ACCOUNT_NOT_AVAILABLE = 1401,
    OTA_ERROR_ACCOUNT_DISABLE = 1402,
    /* Device */
    OTA_ERROR_INVALID_DEVICE_OS = 1500,
    OTA_ERROR_INVALID_DEVICE_ACCESS = 1501,
    OTA_ERROR_UUID_DEVICE_NOT_THE_SAME = 1502,
    /* App */
    OTA_ERROR_UUID_APP_NOT_THE_SAME = 1600,
    /* Extends */
    OTA_ERROR_EXTENDS_NO_AVAILABLE_TIME = 1700,
    /* Mail */
    OTA_ERROR_MAIL_NOT_SEND = 1800,
    /* Date exception */
    OTA_ERROR_PARSING_DATE = 2000,
    OTA_ERROR_INVALID_DATE_PERIOD = 2001,
    OTA_ERROR_NOT_COMPATIBLE_PERIOD = 2002,
    OTA_ERROR_PERIOD_NOT_IN_ASSIGNATION_PERIOD = 2003,
    /* Invalide role access */
    OTA_ERROR_NO_PERMISSION_ACCESS = 2100,
    OTA_ERROR_END_BEFORE_NOW = 2600,
    OTA_ERROR_KEY_END_BEFORE_START = 2601,
    OTA_ERROR_KEY_ACCESS_DENIED_ID = 2620,
    OTA_ERROR_KEY_INVALID_ID = 2621,
    
    OTA_ERROR_SDK_NULL_OBJECT = 10000,
    OTA_ERROR_SDK_OBJECT_ILLEGAL_ACCESS = 10001,
    OTA_ERROR_SDK_OBJECT_NOT_FOUND = 10002,
    OTA_NO_INTERNET_CONNECTIVITY = 1009,
    OTA_NETWORK_ERROR = 9999,
    OTA_UNKNOWN_ERROR = 999,
    OTAErrorCodeSignatureErrorTokenIdEmpty = 30000,
    OTAErrorCodeSignatureErrorAppIdEmpty = 30001,
    OTAErrorCodeSignatureErrorSdkIdEmpty = 30002,
    OTAErrorCodeSignatureErrorMethodEmpty = 30003,
    OTAErrorCodeSignatureErrorPathEmpty = 30004,
    OTAErrorCodeSignatureErrorTimestampEmpty = 30005,
    OTAErrorCodeSignatureErrorUnknown = 30006,
    OTAErrorMissingKeyRequestObject = 40000,
    OTAErrorMethodAlreadyInProgress = 50000
};

typedef NS_ENUM(NSInteger, OTABLEErrorCode)
{
    /// No error
    OTABLENOError = 0,

    /// Bluetooth is off, please switch in on
    OTABLEOff = 1,

    /// Device is visible, but can't connect to it (too far, or already someone is connected to the device), raised by the SDK
    OTABLETimeOutConnexion = 2,

    /// Action has not been performed, or no response has been received
    OTABLETimeOutAction = 3,

    /// You have a key but it is currently not enabled, please enable it in order to connect to the vehicle
    OTABLEKeyNotEnabled = 4,

    /// You currently have no key, please select one first (switch to key)
    OTABLENoKey = 5,

    /// The key is invalid, bad configuration backend side, device needs a reconfiguration
    OTABLEInvalidKey = 6,

    /// It is currently not possible to start the engine, when the doors are locked for example
    OTABLERevoked = 7,

    /// This action is not possible because the CSM does not support it or is deactivated
    OTABLEUnavailableFeature = 8,

    /// No need to connect again, already connected to the device
    OTABLEAlreadyConnected = 9,

    /// Action can't be performed because not connected to device
    OTABLENotConnectedToDevice = 10,

    /// Device has not been found after 10s searching
    OTABLEDeviceNotFound = 11,

    /// Can't process the action, as a previous one is still in progress, wait for it to finish
    OTABLEActionAlreadyInProgress = 12,

    /// same as OTABLENoKey
    OTABLENoStatus = 13,

    /// Action is not possible because you are to far from the device, get closer and try again
    OTABLEOutOfRange = 14,

    /// Mileage from token is below the mileage of the vehicle
    OTABLEIncorrectMileage = 16,

    /// You are trying to use a key which is in the future, wait for the start date given to be reached
    OTABLETooEarly = 17,

    /// You are trying to use a key which is in the past, create a new one
    OTABLETooLate = 18,

    /// A new key has been enabled in the backend, and has been used with the vehicle, this is because of a security counter. Generate and enable a new key to bypass this
    OTABLEBadCounter = 19,

    /// Vin from token is not matching with the device one.
    OTABLEBadVin = 20,

    /// The time is not set in the device, network coverage is required at this time to let the SDK set it for you.
    OTABLENoTimeSet = 21,

    /// The access end date is now in the past, but lock/unlock will work without auhorisation to start according to the time defined in the device (default is 30min)
    OTABLEGracePeriod = 22,

    /// A critical error occured in the device, action has been dropped, retry
    OTABLEInternalError = 23,

    /// A critical error occured in the device, action has been dropped, retry
    OTABLETokenError = 24,

    /// The previous connection has been lost without being explicitly terminated
    OTABLELostConnection = 25,

    /// Writing first part of data to the CSM has failed
    OTABLEWritePart1ToCSMError = 26,

    /// Writing second part of data to the CSM has failed
    OTABLEWritePart2ToCSMError = 27,

    /// Reading synthesis data from the CSM has failed
    OTABLEReadSynthesisFromCSMError = 28,

    /// The action to send to the vehicle is unknown and has not been sent to the CSM
    OTABLEUnknownActionError = 29,

    /// The operation state received from the CSM is unknown in this SDK version.
    OTABLEUnknownOperationState = 30,

    /// Reading CSM/Modem/BLE firmware versions from the CSM has failed
    OTABLEReadVersionsFromCSMError = 31,

    /// Error occurred while connecting to the CSM
    OTABLEErrorCodeConnectionError = 32,

    /// The connection was explicitly terminated by the device
    OTABLEErrorCodeConnectionTerminated = 33,

    /// Your current key is enabled but has no tokens left, please generate new tokens.
    OTABLEErrorCodeOutOfTokens = 34,
    
    /// The BLE scan has been explicitly stopped by calling the stop scan method.
    OTABLEErrorCodeScanInterrupted = 35,
    
    /// The BLE scan has timed out.
    OTABLEErrorCodeScanTimeout = 36,
    
    /// The GPS data could not be read from the CSM while locking/unlocking.
    OTABLEErrorReadGPSFromCSMError = 37,
    
    /// The action has been executed by the CSM (lock/unlock) but completed event has not been received in time. Possible that doors are already locked or unlocked.
    OTABLETimeoutActionCompleted = 38,
    
    /// Bluetooth is on
    OTABLEOn = 39,
    
    //'unknown' BLE state
    OTABLEUnknownState = 40,
    
    /// Not handled state, should not happen
    OTABLEUnknownError = 999
    
    
};

@interface OTAErrors : NSObject

+ (NSString *)displayNameOTABLEErrorCode:(OTABLEErrorCode)bleErrorCode;

@end
