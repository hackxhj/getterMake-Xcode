//
//  Gengetter.m
//  Gengetter
//
//  Created by yuhuajun on 16/4/19.
//  Copyright © 2016年 hackxhj. All rights reserved.
//

#import "Gengetter.h"
#import "InputViewController.h"

@interface Gengetter()<InputViewControllerDelegate>

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong) InputViewController *inputCtrl;
@property (nonatomic, copy) NSString *currentFilePath;
@property (nonatomic) NSTextView *currentTextView;
@property (nonatomic, assign) BOOL notiTag;

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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationLog:) name:NSTextViewDidChangeSelectionNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationLog:) name:@"IDEEditorDocumentDidChangeNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationLog:) name:@"PBXProjectDidOpenNotification" object:nil];
        
        
    }
    return self;
}

- (void)notificationLog:(NSNotification *)notify
{
    if (!self.notiTag) return; //避免自定义的输入框进入下面的方法

     if ([notify.name isEqualToString:NSTextViewDidChangeSelectionNotification]) {
        if ([notify.object isKindOfClass:[NSTextView class]]) {
            NSTextView *text = (NSTextView *)notify.object;
            self.currentTextView = text;
            NSLog(@"----- %@",self.currentTextView.string);
        }
    }else if ([notify.name isEqualToString:@"IDEEditorDocumentDidChangeNotification"]){
        //Track the current open paths
        NSObject *array = notify.userInfo[@"IDEEditorDocumentChangeLocationsKey"];
        NSURL *url = [[array valueForKey:@"documentURL"] firstObject];
        if (![url isKindOfClass:[NSNull class]]) {
            NSString *path = [url absoluteString];
            self.currentFilePath = path;
        
        }
    }
}





- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    
    self.notiTag = YES;

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
    if (!(self.currentTextView && self.currentFilePath)) {
        NSError *error = [NSError errorWithDomain:@"获取不到当前的项目文件的焦点，请鼠标点击" code:0 userInfo:nil];
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
        return;
    }
    
    self.notiTag = NO;

    self.inputCtrl = [[InputViewController alloc] initWithWindowNibName:@"InputViewController"];
    self.inputCtrl.delegate=self;
    [self.inputCtrl showWindow:self.inputCtrl];
}

-(void)windowWillClose{
    self.notiTag = YES;
}

-(void)outputResult:(NSString *)result
{
      NSRange range=[self.currentTextView.string rangeOfString:@"@end" options:NSBackwardsSearch];
    if(range.location==NSNotFound)
    {
        NSError *error = [NSError errorWithDomain:@"没找到末尾合适的位置,或插入到光标位置 请注意" code:0 userInfo:nil];
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
        
        [self.currentTextView insertText:result];

        return;
    }
     NSRange newRange=NSMakeRange(range.location-1, 0);
     [self.currentTextView insertText:result replacementRange:newRange];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
