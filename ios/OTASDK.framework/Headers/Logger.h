//
//  Logger.h
//  SmartAccessLoggingObjcIos
//
//  Created by Artur Matusiak on 25/07/2018.
//  Copyright © 2018 Artur Matusiak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Logger

- (void)v:(NSString*)tag message:(NSString*)msg;
- (void)d:(NSString*)tag message:(NSString*)msg;
- (void)i:(NSString*)tag message:(NSString*)msg;
- (void)w:(NSString*)tag message:(NSString*)msg;
- (void)e:(NSString*)tag message:(NSString*)msg;

@end
