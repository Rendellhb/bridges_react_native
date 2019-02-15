//
//  Plop.h
//  SmartAccessLoggingObjcIos
//
//  Created by Artur Matusiak on 25/07/2018.
//  Copyright © 2018 Artur Matusiak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tree.h"

@interface Plop : NSObject

+ (void)addTree:(Tree*)tree;
+ (void)addTrees:(NSArray<Tree*>*)trees;
+ (void)cleanTrees;

+ (void)d:(id)object message:(NSString*)message;
+ (void)v:(id)object message:(NSString*)message;
+ (void)w:(id)object message:(NSString*)message;
+ (void)e:(id)object message:(NSString*)message;
+ (void)i:(id)object message:(NSString*)message;

@end
