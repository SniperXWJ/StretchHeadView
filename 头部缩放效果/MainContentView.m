//
//  MainContentView.m
//  头部缩放效果
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 com.xuwenjie. All rights reserved.
//

#import "MainContentView.h"

@implementation MainContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor orangeColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // 创建Quartz上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 先填充一个灰色矩形
    CGContextSetRGBFillColor(context, 0.99f, 0.01f, 0.01f, 1.0f);
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, 100.0f, 100.0f));
    
    // 设置阴影透明度，0表示阴影被完全透明掉，不显示出来
    self.layer.shadowOpacity = 1.0f;
    
    // 设置阴影的偏移，即阴影与当前视图的偏移。
    // width值为正表示往右偏；height值为正表示往下偏
    self.layer.shadowOffset = CGSizeMake(-3.0f, 3.0f);
    
    // 设置阴影半径。阴影半径将产生阴影渐变效果
    self.layer.shadowRadius = 3.0f;
    
    // 创建一个矩形Path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, &CGAffineTransformIdentity, CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height));
    
    // 设置阴影path
    self.layer.shadowPath = path;
    
    // 释放一次path对象
    CGPathRelease(path);
}


@end
