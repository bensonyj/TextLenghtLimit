//
//  UITextField+LimitLength.m
//  TextLenghtLimit
//
//  Created by YJ on 16/7/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "UITextField+LimitLength.h"
#import <objc/runtime.h>

static char textFieldLimitLength;

@implementation UITextField (LimitLength)

- (void)setLimitLength:(NSInteger)limitLength
{
    objc_setAssociatedObject(self, &textFieldLimitLength, @(limitLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (limitLength > 0) {
        // 1 可注册通知形式对文本添加监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textField_textDidChange:) name:UITextFieldTextDidChangeNotification object:self];
        
        // 2 可通过target
//        [self addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventAllEditingEvents];
    }else{
        // 2 target
//        [self removeTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventAllEditingEvents];
    }
}

- (NSInteger)limitLength
{
    return [objc_getAssociatedObject(self, &textFieldLimitLength) integerValue];
}

// 2.target
//- (void)valueChange:(UITextField *)textField
//{
//    if(self.limitLength <= 0)
//        return;
//    
//    if(textField.text.length <= self.limitLength)
//        return;
//    
//    NSString *string = [textField.text substringToIndex:self.limitLength];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        textField.text = string;
//        [textField sendActionsForControlEvents:UIControlEventEditingChanged];
//    });
//}

- (void)textField_textDidChange:(NSNotification *)notification
{
    if (self.limitLength <= 0) {
        return;
    }
    
    UITextField *textField = notification.object;
    if ([textField.text length] > self.limitLength) {
        textField.text = [textField.text substringToIndex:self.limitLength];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}

@end
