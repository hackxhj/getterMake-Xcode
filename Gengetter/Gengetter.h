//
//  Gengetter.h
//  Gengetter
//
//  Created by yuhuajun on 16/4/19.
//  Copyright © 2016年 hackxhj. All rights reserved.
//

#import <AppKit/AppKit.h>

@class Gengetter;

static Gengetter *sharedPlugin;

@interface Gengetter : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end