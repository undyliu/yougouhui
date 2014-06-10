//
//  ZKHTouchView.m
//  ZheKouHu
//
//  Created by undyliu on 14-6-10.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import "ZKHTouchView.h"

@implementation ZKHTouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(touchesBegan:withEvent:)]){
        [self.delegate view:self touchesBegan:touches withEvent:event];
    }
}

@end
