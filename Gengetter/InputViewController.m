//
//  InputViewController.m
//  Gengetter
//
//  Created by 余华俊 on 16/5/5.
//  Copyright © 2016年 hackxhj. All rights reserved.
//





#import "InputViewController.h"

@interface InputViewController ()

@property(nonatomic,strong)NSString *mstr;
@property(nonatomic,strong)NSString *nstr;
@property(nonatomic,strong)NSWindow* xwindows;
@end

@implementation InputViewController






-(void)windowWillClose:(NSNotification *)notification{
    if ([self.delegate respondsToSelector:@selector(windowWillClose)]) {
        [self.delegate windowWillClose];
    }
}


- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
-(void)close{
    [super close];
}

- (IBAction)OnCancel:(id)sender {
    [self close];

}

- (IBAction)OnEnter:(id)sender {
    [self close];
    NSTextView *textView = self.inputTextView;
//    NSLog(@"%@",textView.string);
    NSString *result=textView.string;
    
    NSString *allResult=@"";
    NSArray *newArr=[result componentsSeparatedByString:@"\n"];
    
    for (NSString *output in newArr) {
        if(output==nil||[output isEqualToString:@""])
        {
            continue;
        }
       // NSLog(@"%@\n....",[self formatGetter:output]);
        NSString *spaceStr=[NSString stringWithFormat:@"%@\n",[self formatGetter:output]];
        allResult=[allResult stringByAppendingString:spaceStr];
    }
    
    if([self.delegate respondsToSelector:@selector(outputResult:)])
    {
        [self.delegate outputResult:allResult];
    }
    
}


-(NSString*)formatGetter:(NSString*)sourceStr
{
    NSString *myResult;
    NSRange rangLeft=[sourceStr rangeOfString:@")"];
    NSRange rangRight=[sourceStr rangeOfString:@"*"];
    
    if(rangLeft.location==NSNotFound||rangRight.location==NSNotFound)
    {
        NSLog(@"错误的格式或者对象");
        return nil;
    }
    //类型名
    NSRange typePoint=NSMakeRange(rangLeft.location+1, rangRight.location-rangLeft.location);
    NSString *typeName=[sourceStr substringWithRange:typePoint];
    typeName=[typeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //属性名
    NSRange unamePoint=NSMakeRange(rangRight.location+1, sourceStr.length-rangRight.location-2);
    NSString *uName=[sourceStr substringWithRange:unamePoint];
    uName=[uName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    
    NSString *strFirst=[NSString stringWithFormat:@"\n-(%@)%@",typeName,uName];
    myResult=[strFirst stringByAppendingString:@"\n{"];
    NSString *underLineName=[NSString stringWithFormat:@"_%@",uName];
    NSString *tempSecion=[NSString stringWithFormat:@"\n    if(!%@)",underLineName];
    myResult=[myResult stringByAppendingString:tempSecion];
    myResult=[myResult stringByAppendingString:@"\n    {"];
    NSString *noxinghaoStr=[typeName stringByReplacingOccurrencesOfString:@"*" withString:@""];
    NSString *tempThird=[NSString stringWithFormat:@"\n        %@=[%@ new];",underLineName,noxinghaoStr];
    myResult=[myResult stringByAppendingString:tempThird];
    myResult=[myResult stringByAppendingString:@"\n    }"];
    NSString *tempFour=[NSString stringWithFormat:@"\n    return %@;",underLineName];
    myResult=[myResult stringByAppendingString:tempFour];
    myResult=[myResult stringByAppendingString:@"\n}"];
    return myResult;
}

 



@end
