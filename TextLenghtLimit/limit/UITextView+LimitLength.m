//
//  UITextView+LimitLength.m
//  TextLenghtLimit
//
//  Created by YJ on 16/7/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "UITextView+LimitLength.h"
#import <objc/runtime.h>

static char textViewLimitLength;

@implementation UITextView (LimitLength)

- (void)setLimitLength:(NSInteger)limitLength
{
    objc_setAssociatedObject(self, &textViewLimitLength, @(limitLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (limitLength > 0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textView_textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
}

- (NSInteger)limitLength
{
    return [objc_getAssociatedObject(self, &textViewLimitLength) integerValue];
}

- (void)textView_textDidChange:(NSNotification *)notification
{
    if (self.limitLength <= 0) {
        return;
    }
    
    UITextView *textView = notification.object;
    if ([textView.text length] > self.limitLength) {
        textView.text = [textView.text substringToIndex:self.limitLength];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

@end
