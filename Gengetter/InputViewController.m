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
//啊啊
@property(nonatomic,strong)NSString *nstr;

/**
 desc(using)
 */
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
        NSString *spaceStr=[NSString stringWithFormat:@"%@",[self formatGetter:output]];
        allResult=[allResult stringByAppendingString:spaceStr];
    }
    
    if([self.delegate respondsToSelector:@selector(outputResult:)])
    {
        [self.delegate outputResult:allResult];
    }
    
}

//输出的字符串
-(NSString*)formatGetter:(NSString*)sourceStr
{
    NSString *myResult;
    NSRange rangLeft=[sourceStr rangeOfString:@")"];
    NSRange rangRight=[sourceStr rangeOfString:@"*"];
    
    if(rangLeft.location==NSNotFound||rangRight.location==NSNotFound)
    {
        NSLog(@"错误的格式或者对象");
        return @"";
    }
    //类型名
    NSRange typePoint=NSMakeRange(rangLeft.location+1, rangRight.location-rangLeft.location);
    NSString *typeName=[sourceStr substringWithRange:typePoint];
    typeName=[typeName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //class
    NSString *className = [typeName stringByReplacingOccurrencesOfString:@"*" withString:@""];
    className = [className stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //属性名
    NSRange unamePoint=NSMakeRange(rangRight.location+1, sourceStr.length-rangRight.location-2);
    NSString *uName=[sourceStr substringWithRange:unamePoint];
    uName=[uName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //_属性名
    NSString *underLineName=[NSString stringWithFormat:@"_%@",uName];
    
    
    NSString *line1 = [NSString stringWithFormat:@"\n- (%@ *)%@{",className,uName];
    NSString *line2 = [NSString stringWithFormat:@"\n    if(!%@){",underLineName];
    NSString *line3 = [NSString stringWithFormat:@"\n        %@ = ({",underLineName];
    NSString *line4 = [NSString stringWithFormat:@"\n            %@ * object = [[%@ alloc]init];",className,className];
    NSString *line5 = [NSString stringWithFormat:@"\n            object;"];
    NSString *line6 = [NSString stringWithFormat:@"\n       });"];
    NSString *line7 = [NSString stringWithFormat:@"\n    }"];
    NSString *line8 = [NSString stringWithFormat:@"\n    return %@;",underLineName];
    NSString *line9 = [NSString stringWithFormat:@"\n}"];
    
    myResult = [NSString stringWithFormat:@"\n%@%@%@%@%@%@%@%@%@",line1,line2,line3,line4,line5,line6,line7,line8,line9];
    
    return myResult;
}
@end
