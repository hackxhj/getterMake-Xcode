//
//  InputViewController.h
//  Gengetter
//
//  Created by 余华俊 on 16/5/5.
//  Copyright © 2016年 hackxhj. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol InputViewControllerDelegate <NSObject>

-(void)outputResult:(NSString*)result;
-(void)windowWillClose;
@end

@interface InputViewController : NSWindowController
@property (unsafe_unretained) IBOutlet NSTextView *inputTextView;
@property(nonatomic,weak)id <InputViewControllerDelegate> delegate;
@end
