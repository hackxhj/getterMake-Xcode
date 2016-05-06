//
//  NSObject_Extension.m
//  Gengetter
//
//  Created by yuhuajun on 16/4/19.
//  Copyright © 2016年 hackxhj. All rights reserved.
//



#import "NSObject_Extension.h"
#import "Gengetter.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[Gengetter alloc] initWithBundle:plugin];
        });
    }
}


@end
