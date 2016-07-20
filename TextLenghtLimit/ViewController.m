//
//  ViewController.m
//  TextLenghtLimit
//
//  Created by YJ on 16/7/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+LimitLength.h"
#import "UITextField+LimitLength.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;

@property (weak, nonatomic) IBOutlet UITextView *rightTextView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _firstTextField.limitLength = 5;
    _textField.limitLength = 10;
    
    _rightTextView.limitLength = 8;
//    [self logTextView];
}

- (void)logTextView
{
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([UITextView class], &outCount);
    NSLog(@"---------- begin textView ivar ---------");
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSLog(@"name: %@ , type: %@ ",name,type);
    }
    free(ivars);
    NSLog(@"---------- end textView ivar ---------");
    
    //得到_placeholderLabel，
    
    NSLog(@"---------- begin textView property ---------");
    objc_property_t *properties = class_copyPropertyList([UITextView class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        NSString *type = [NSString stringWithUTF8String:property_getAttributes(property)];
        NSLog(@"proper_name: %@ , type: %@ ",name, type);
    }
    free(properties);
    NSLog(@"---------- end textView property ---------");
    //得到NSString(placeHolder)、UIColor(placeColor)
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
