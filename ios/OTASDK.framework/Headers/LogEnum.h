//
//  LogEnum.h
//  SmartAccessLoggingObjcIos
//
//  Created by Artur Matusiak on 25/07/2018.
//  Copyright © 2018 Artur Matusiak. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LogEnum) {
    LogEnumVerbose = 0,
    LogEnumDebug = 1,
    LogEnumInfo = 2,
    LogEnumWarning = 3,
    LogEnumError = 4,
    LogEnumNone = 1000
};
