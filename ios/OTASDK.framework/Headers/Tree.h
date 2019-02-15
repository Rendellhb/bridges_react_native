//
//  Tree.h
//  SmartAccessLoggingObjcIos
//
//  Created by Artur Matusiak on 25/07/2018.
//  Copyright © 2018 Artur Matusiak. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Logger.h"
#import "LogEnum.h"

@interface Tree : NSObject

@property (nonatomic) id<Logger> logger;
@property (nonatomic) LogEnum logType;

- (instancetype)initWithLogger:(id<Logger> _Nonnull)logger andType:(LogEnum)type;

@end
