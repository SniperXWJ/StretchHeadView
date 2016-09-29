//
//  SecondViewController.m
//  头部缩放效果
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 com.xuwenjie. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Second";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //navigationBar设置为透明的
    UIImage *backgroundImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [self setBackgroundViewColor];
    
}



- (void)viewDidAppear:(BOOL)animated {
    if (animated) {
        [self setBackgroundViewColor];
    }
}

- (void)setBackgroundViewColor {
    UIView *uiBarBackground = self.navigationController.navigationBar.subviews.firstObject;
    
    UIView *backgroundView = uiBarBackground.subviews.firstObject;
    
    backgroundView.alpha = 1.0;
}

@end
