//
//  KeyframeViewController.m
//  CoreAnimation
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "KeyframeViewController.h"

@interface KeyframeViewController ()
{
    UIView * _playView;
}
@end

@implementation KeyframeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关键帧动画";
    _playView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    _playView.backgroundColor =[UIColor blueColor];
    [self.view addSubview:_playView];
}

#pragma mark - 关键帧动画第一种形式
- (IBAction)firstBtnDidClicked:(id)sender {
    _playView.center = CGPointMake(125, 125);
    [_playView.layer removeAllAnimations];
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation * kfAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //2.设置关键帧,这里有四个关键帧，对于关键帧动画初始值不能省略
    NSValue *key1 = [NSValue valueWithCGPoint:_playView.center];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(125, 300)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(125, 300)];
    NSArray *values = @[key1,key2,key3,key4];
    kfAni.values = values;
    //3.设置其他属性
    kfAni.duration = 8.0f;
    kfAni.delegate = self;
    kfAni.beginTime = CACurrentMediaTime() +1;//设置延时1秒执行
    //4.把动画添加到layer层
    [_playView.layer addAnimation:kfAni forKey:@"first"];
}

#pragma mark - 关键帧动画第二种形式
- (IBAction)secondBtnDidClicked:(id)sender {
    _playView.center = CGPointMake(125, 125);
    [_playView.layer removeAllAnimations];
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation * kfAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //2.设置路径
    //绘制贝塞尔曲线
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _playView.center.x, _playView.center.y);//移动到起始点
    CGPathAddCurveToPoint(path, NULL, 125, 300, 300, 300, 200, 200);
    kfAni.path = path;
    CGPathRelease(path);
    //3.设置其他属性
    kfAni.duration = 5.0f;
    kfAni.delegate = self;
    kfAni.beginTime = CACurrentMediaTime()+1;
    //4.把动画加到layer层
    [_playView.layer addAnimation:kfAni forKey:@"second"];
    
}
#pragma mark - 动画代理方法


/**
 *  动画开始
 *
 *  @param anim <#anim description#>
 */
-(void)animationDidStart:(CAAnimation *)anim
{
    
}


/**
 *  动画结束
 *
 *  @param anim <#anim description#>
 *  @param flag <#flag description#>
 */
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [CATransaction begin];//开启事务
        [CATransaction setDisableActions:YES];//禁止隐式动画
        if ([anim isKindOfClass:[CAKeyframeAnimation class]]) {
            CAKeyframeAnimation * kfAni = (CAKeyframeAnimation *)anim;
            if ([kfAni.keyPath isEqualToString:@"position"]) {
                if (kfAni.path) {
                    _playView.center = CGPointMake(200, 200);
                }else
                {
                    NSValue * lastvalue = [kfAni.values lastObject];
                    _playView.center = [lastvalue CGPointValue];
                }
                
            }
        }
        
        [CATransaction commit];//提交事务
    }
}
@end
