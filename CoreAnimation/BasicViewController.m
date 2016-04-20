//
//  BasicViewController.m
//  CoreAnimation
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 何万牡. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()
{
    UIView * _playView;
    CGFloat  _from;
    CGFloat _basicScale;
}
@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基础动画";
    _from = 0;
    _basicScale = 1.0;
    _playView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 50, 100)];
    _playView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_playView];
}


/**
 *  移动
 *
 *  @param sender <#sender description#>
 */
- (IBAction)moveBtnDidClicked:(id)sender {
    _playView.center = CGPointMake(125, 250);
    [_playView.layer removeAllAnimations];
    //1.创建动画并指定动画属性
    CABasicAnimation * basicAni = [CABasicAnimation animationWithKeyPath:@"position"];
    //2.设置动画属性初始值和结束值
    basicAni.fromValue = [NSValue valueWithCGPoint:_playView.center];
    basicAni.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 500)];
    //3.设置代理
    basicAni.delegate = self;
    //4.设置动画时间
    basicAni.duration = 3.0f;
    //basicAnimation.repeatCount = HUGE_VALF;//设置重复次数,HUGE_VALF可看做无穷大
    //basicAnimation.removedOnCompletion = NO;//运行一次是否移除动画
    
    //5.添加到Layer层(key自己命名,用于标记动画)
    [_playView.layer addAnimation:basicAni forKey:@"move"];
}


/**
 *  旋转
 *
 *  @param sender <#sender description#>
 */
- (IBAction)rotationBtnDidClicked:(id)sender {
   _playView.center = CGPointMake(125, 250);
    [_playView.layer removeAllAnimations];
    //1.创建动画并指定动画属性
    CABasicAnimation * basicAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //2.设置动画属性初始值和结束值
    basicAni.fromValue = [NSNumber numberWithFloat:_from];
    basicAni.toValue = [NSNumber numberWithFloat:M_PI_2*4/3+_from];
    //3.设置其他属性
    basicAni.duration = 4.0f;
    basicAni.autoreverses = false;
    basicAni.delegate = self;
    //4.把动画添加到layer层
    [_playView.layer addAnimation:basicAni forKey:@"rotation"];
}

/**
 *  放大
 *
 *  @param sender <#sender description#>
 */
- (IBAction)biggerDidClicked:(id)sender {
     _playView.center = CGPointMake(125, 250);
    [_playView.layer removeAllAnimations];
    //1.创建动画并指定动画属性
    CABasicAnimation * basicAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //2.设置动画属性初始值和结束值
    basicAni.fromValue = [NSNumber numberWithFloat:_basicScale];
    basicAni.toValue = [NSNumber numberWithFloat:_basicScale * 1.2];
    //3.设置其他属性
    basicAni.duration = 2.0f;
    basicAni.delegate = self;
    //4.把动画添加到layer层
    [_playView.layer addAnimation:basicAni forKey:@"scale"];
}

- (IBAction)smallerDidClicked:(id)sender {
    _playView.center = CGPointMake(125, 250);
    [_playView.layer removeAllAnimations];
    //1.创建动画并指定动画属性
    CABasicAnimation * basicAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //2.设置动画属性初始值和结束值
    basicAni.fromValue = [NSNumber numberWithFloat:_basicScale];
    basicAni.toValue = [NSNumber numberWithFloat:_basicScale / 1.2];
    //3.设置其他属性
    basicAni.duration = 2.0f;
    basicAni.delegate = self;
    //4.把动画添加到layer层
    [_playView.layer addAnimation:basicAni forKey:@"scale"];
}
#pragma mark - 动画代理方法


/**
 *  动画开始
 *
 *  @param anim <#anim description#>
 */
-(void)animationDidStart:(CAAnimation *)anim
{
    if ([anim isKindOfClass:[CABasicAnimation class]]) {
        CABasicAnimation * basicAni = (CABasicAnimation *)anim;
        [basicAni setValue:basicAni.toValue forKey:@"move"];
    }
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
        if ([anim isKindOfClass:[CABasicAnimation class]]) {
            CABasicAnimation * basicAni = (CABasicAnimation *)anim;
            NSString * str = [basicAni keyPath];
            NSLog(@"keyPath :%@",str);
            if ([basicAni.keyPath isEqualToString:@"position"]) {
                _playView.center = [[anim valueForKey:@"move"] CGPointValue];
            }
            if ([basicAni.keyPath isEqualToString:@"transform.rotation.z"]) {
                NSLog(@"%.0f",[basicAni.toValue floatValue]);
                _from = [basicAni.toValue floatValue];
                _playView.transform = CGAffineTransformMakeRotation([basicAni.toValue floatValue]);
            }
            if ([basicAni.keyPath isEqualToString:@"transform.scale"]) {
                _basicScale = [basicAni.toValue floatValue];
                _playView.transform = CGAffineTransformMakeScale(_basicScale, _basicScale);
            }
        }
        
        [CATransaction commit];//提交事务
    }
}
@end
