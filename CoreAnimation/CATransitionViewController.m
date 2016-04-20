//
//  CATransitionViewController.m
//  CoreAnimation
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "CATransitionViewController.h"

@interface CATransitionViewController ()
{
    UIImageView * _imageView;
    NSInteger _index;
}
@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 2;
    self.title = @"转场动画";
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imageView.image = [UIImage imageNamed:@"2"];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    [self addTap];
}
//添加手势
-(void)addTap
{
    UISwipeGestureRecognizer * rightTGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightslide:)];
    rightTGR.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:rightTGR];
    UISwipeGestureRecognizer * leftSGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftslide:)];
    leftSGR.direction = UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:leftSGR];
}
//右滑
-(void)rightslide:(id)sender
{
    if (_index>2) {
        _index--;
        [self addCATransitionWithIndex:_index AndType:kCATransitionFromLeft];
    }
    
}
//左滑
-(void)leftslide:(id)sender
{
    if (_index<8) {
        _index++;
        [self addCATransitionWithIndex:_index AndType:kCATransitionFromRight];
    }
    
}
//转场动画
-(void)addCATransitionWithIndex:(NSInteger)index AndType:(NSString *)type
{
    //1.创建转场动画对象
    CATransition * transtion = [CATransition animation];
    //2.设置转场类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    /*
     //公开
     fade : 淡出效果
     movein : 新视图移动到旧视图上
     push : 新视图推出旧视图
     reveal : 移开就视图,显示新视图
     
     //私有
     cube : 立方体翻转效果
     oglFlip : 翻转效果
     suckEffect : 收缩效果
     rippleEffect : 水滴波纹效果
     pageCurl : 向上翻页效果
     pageUnCurl : 向下翻页效果
     cameraIrisHollowOpen : 摄像头打开效果
     cameraIrisHollowClose : 摄像头关闭效果
     */
    transtion.type = @"cameraIrisHollowOpen";
    //设置动画时常
    transtion.duration = 1.0f;
    //设置转场方向类型
    /*
     kCATransitionFromRight 从右侧转场
     kCATransitionFromLeft 从左侧转场
     kCATransitionFromTop 从顶部转场
     kCATransitionFromBottom 从底部转场
     */
    transtion.subtype = type;
     _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",index]];
    [_imageView.layer addAnimation:transtion forKey:nil];
   
    
    
}


@end
