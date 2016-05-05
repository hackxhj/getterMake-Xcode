//
//  Gengetter.m
//  Gengetter
//
//  Created by yuhuajun on 16/4/19.
//  Copyright © 2016年 hackxhj. All rights reserved.
//

#import "Gengetter.h"

@interface Gengetter()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation Gengetter

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Window"];
    
    if (menuItem) {
        
        NSMenu *menu = [[NSMenu alloc] init];
        
        //Input JSON window
        NSMenuItem *inputJsonWindow = [[NSMenuItem alloc] initWithTitle:@"Input property  window" action:@selector(doMenuAction) keyEquivalent:@"s"];
        [inputJsonWindow setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
        inputJsonWindow.target = self;
        [menu addItem:inputJsonWindow];
 
        
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"GenGetter" action:nil keyEquivalent:@""];
        item.submenu = menu;
        
        [[menuItem submenu] addItem:item];
    }
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Hello, World"];
    [alert runModal];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
