//
//  GroupViewController.m
//  CoreAnimation
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()
{
    UIView * _playView;
}
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动画组";
    _playView =[[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    _playView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_playView];
    [self addAnimation];
}

-(void)addAnimation
{
    //1.创建动画组
    CAAnimationGroup * aniGroup = [CAAnimationGroup animation];
    //2.设置组中的动画
    CABasicAnimation * basicAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAni.fromValue = [NSNumber numberWithFloat:0];
    basicAni.toValue = [NSNumber numberWithFloat:M_PI*4];
    
    CAKeyframeAnimation * kfAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _playView.center.x, _playView.center.y);//移动到起始点
    CGPathAddCurveToPoint(path, NULL, 125, 300, 300, 300, 200, 200);
    kfAni.path = path;
    CGPathRelease(path);
    
    aniGroup.animations = @[basicAni,kfAni];
    aniGroup.delegate = self;
    //设置动画时间，如果动画组中动画已经设置过动画属性，则不再生效
    aniGroup.duration = 4.0f;
    aniGroup.beginTime = CACurrentMediaTime()+1;//延时一秒
    //3.把动画组添加到layer层
    [_playView.layer addAnimation:aniGroup forKey:@"group"];
}

@end
