//
//  UITextView+LimitLength.h
//  TextLenghtLimit
//
//  Created by YJ on 16/7/20.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface UITextView (LimitLength)

@property (nonatomic, assign) IBInspectable NSInteger limitLength;

@end
