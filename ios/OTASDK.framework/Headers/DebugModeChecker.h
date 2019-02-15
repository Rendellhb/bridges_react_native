//
//  DebugModeChecker.h
//  OTASDK
//
//  Created by Artur Matusiak on 27/07/2018.
//  Copyright © 2018 OTA keys. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <assert.h>
#include <stdbool.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>

@interface DebugModeChecker : NSObject

+ (BOOL)isRunningUnderDebugger;

@end
