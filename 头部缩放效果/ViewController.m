//
//  ViewController.m
//  头部缩放效果
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 com.xuwenjie. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "MainContentView.h"


#define kTableHeaderViewHeight      400  //tableHeaderView的高度

#define kTableViewUpHeight          200  //tableView整体上移高度

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UIView *_navigationBackgroundView;
}

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,weak) MainContentView *mainContentView;

@end

@implementation ViewController
#pragma mark - Life Cycle （生命周期）
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self mainContentView];
    
    [self tableView];
    
    [self navigationConfig];
    
}
#pragma mark - Lazy Load （懒加载）

- (MainContentView *)mainContentView {
    if (!_mainContentView) {
        MainContentView *mainContentView = [[MainContentView alloc] initWithFrame:self.view.bounds];

        [self.view addSubview:mainContentView];
        _mainContentView = mainContentView;
    }
    return _mainContentView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        //将整个tableView上移并加长上移的高度
        CGRect temp = tableView.frame;
        temp.origin.y -= kTableViewUpHeight;
        temp.size.height += kTableViewUpHeight;
        tableView.frame = temp;
        
        tableView.showsVerticalScrollIndicator = NO;
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kTableHeaderViewHeight)];
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:tableHeaderView.bounds];
        
        backgroundImageView.tag = 1000;
        
        backgroundImageView.image = [UIImage imageNamed:@"background_image.jpg"];
        
        backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [tableHeaderView addSubview:backgroundImageView];
        
        UIView *avatarBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 54, 54)];
        
        avatarBackView.backgroundColor = [UIColor whiteColor];
        
        avatarBackView.center = CGPointMake(tableHeaderView.frame.size.width / 2, tableHeaderView.frame.size.height - 50);
        
        avatarBackView.layer.cornerRadius = avatarBackView.frame.size.width/2;
        
        avatarBackView.clipsToBounds = YES;
        
        UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        
        avatarView.center = CGPointMake(avatarBackView.frame.size.width / 2, avatarBackView.frame.size.height / 2);
        
        avatarView.layer.cornerRadius = avatarView.frame.size.width/2;
        
        avatarView.clipsToBounds = YES;
        
        
        avatarView.backgroundColor = [UIColor whiteColor];
        
        avatarView.image = [UIImage imageNamed:@"1"];
        
        [avatarBackView addSubview:avatarView];
        
        
        UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        
        nickLabel.center = CGPointMake(avatarBackView.center.x, avatarBackView.center.y + 50);
        
        nickLabel.text = @"～汪星人～";
        
        nickLabel.textAlignment = NSTextAlignmentCenter;
        
        nickLabel.textColor = [UIColor whiteColor];
        
        nickLabel.font = [UIFont systemFontOfSize:14];
        
        [tableHeaderView addSubview:nickLabel];
        
        [tableHeaderView addSubview:avatarBackView];
        
        tableView.tableHeaderView = tableHeaderView;
        
        
        [self.mainContentView addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - TableViewDelegate （代理）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_tableView.tableHeaderView viewWithTag:1000].frame = [self calculateFrameWithOffY:_tableView.contentOffset.y];
    
    CGPoint center = [_tableView.tableHeaderView viewWithTag:1000].center;
    center.x = self.view.frame.size.width / 2;
    [_tableView.tableHeaderView viewWithTag:1000].center = center;
}

#pragma mark - Others （其他）
- (CGRect)calculateFrameWithOffY:(CGFloat)offy {
    
    CGFloat upDistance = offy + 64;
    
    //1.navigationBar透明度计算
    CGFloat alphaScale = 0.0;
    
    CGFloat criticalHeight = kTableHeaderViewHeight - kTableViewUpHeight;
    
    if (upDistance <= criticalHeight) {
        alphaScale = (upDistance-20) / criticalHeight;
    } else {
        alphaScale = 1.0;
    }
    
    [_navigationBackgroundView setAlpha:alphaScale];
    

    
    
    //2.缩放比例计算
    CGFloat zoomScale = -offy / self.tableView.frame.size.height + 1;
    
    CGRect rect = [_tableView.tableHeaderView viewWithTag:1000].frame;
    if (offy < 0) {
        rect.size.width = self.view.frame.size.width * zoomScale;
        rect.size.height = kTableHeaderViewHeight * zoomScale;
    }
    
    return rect;
}


/**
 导航栏的各种配置
 */
- (void)navigationConfig {
    
    self.navigationItem.title = @"首页";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我" style:UIBarButtonItemStylePlain target:self action:@selector(showUserCenter)];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addClick)];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    
    //navigationBar设置为透明的
    UIImage *backgroundImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    //navigationBar下面的黑线隐藏掉
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //设置status文字状态为白色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
    
    //添加一个背景颜色view
    UIView *navigationBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    
    _navigationBackgroundView = navigationBackgroundView;
    
    navigationBackgroundView.backgroundColor = [UIColor colorWithRed:33/255.0 green:184/255.0 blue:229/255.0 alpha:1.0];
    
    navigationBackgroundView.alpha = 0.0;
    
    UIView *uiBarBackground = self.navigationController.navigationBar.subviews.firstObject;
    
    [uiBarBackground addSubview:navigationBackgroundView];
    
    
}

- (void)addClick {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)showUserCenter {
    
    
}

@end
