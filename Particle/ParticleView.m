//
//  ParticleView.m
//  Particle
//
//  Created by masatani hideki on 2013/05/22.
//  Copyright (c) 2013年 masatani hideki. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "ParticleView.h"
#import "ParticleLayer.h"

@implementation ParticleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [(UITouch*)[touches anyObject] locationInView:self];
    ParticleLayer* particle = [ParticleLayer layer];
    [particle setpos:pos];
    [self.layer addSublayer:particle];
    [particle performSelector:@selector(bang) withObject:nil afterDelay:0];
}

@end

