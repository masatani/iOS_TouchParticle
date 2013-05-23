//
//  ParticleLayer.m
//  Particle
//
//  Created by masatani hideki on 2013/05/23.
//  Copyright (c) 2013年 masatani hideki. All rights reserved.
//

#import "ParticleLayer.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation ParticleLayer

//浮動小数点のランダム
float randFloat(float a, float b)
{
    return ((b-a)*((float)arc4random()/ARC4RANDOM_MAX))+a;
}

//円に表示するラジアン計算
-(float)indexToRadian:(int)index
{
    return ((float)index / (float)PARTICLE_COUNT) * 2.0 * 3.14;
}

//色を七色に変える
-(CGColorRef)indexToColor:(int)index alpha:(float)alpha
{
    return [UIColor colorWithHue:(float)index / (float)PARTICLE_COUNT
                      saturation:1
                      brightness:1
                           alpha:alpha].CGColor;
}

//タッチされた場所にセット
-(void)setpos:(CGPoint)pos
{
    
    CGRect frame = self.frame;
    frame.origin = pos;
    self.frame = frame;
    
    for (int i = 0; i < PARTICLE_COUNT; i++) {
        CALayer* layer = [CALayer layer];
        //回転するアニメーション
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D transform = CATransform3DMakeRotation(0.5 * M_PI * randFloat(0.0, 2.0), 0.0, 0.0, 1.0);
        animation.toValue = [NSNumber valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.repeatCount = MAXFLOAT;
        animation.cumulative = YES;
        [layer addAnimation:animation forKey:@"ImageViewRotation"];
        
        //場所を指定
        layer.frame = CGRectMake(0, 0, randFloat(0.0, 20.0), randFloat(0.0, 30.0));
        float angle = [self indexToRadian:i];
        layer.position = CGPointMake(cos(angle), sin(angle));
        //色を七色に
        layer.backgroundColor = [self indexToColor:i alpha:0.5];
        [self addSublayer:layer];
        //レイヤーはCALayer型の配列に格納
        layerlist[i] = layer;
    }
}

//拡散させる
-(void)bang
{
    float radius = (rand() % 5 + 1) * 50;
    float duration = radius / 50.0;
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    [CATransaction setCompletionBlock:^(void){
        [self removeFromSuperlayer];
    }];
    for (int i = 0; i < PARTICLE_COUNT; i++) {
        float angle = [self indexToRadian:i];
        layerlist[i].position = CGPointMake(cos(angle) * radius,sin(angle) * radius);
        layerlist[i].backgroundColor = [self indexToColor:i alpha:0];
    }
    [CATransaction commit];
    
}

@end
