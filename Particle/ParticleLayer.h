//
//  ParticleLayer.h
//  Particle
//
//  Created by masatani hideki on 2013/05/23.
//  Copyright (c) 2013年 masatani hideki. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <math.h>
#define PARTICLE_COUNT 20

@interface ParticleLayer : CALayer {
@private
    CALayer* layerlist[PARTICLE_COUNT];
}
-(void)setpos:(CGPoint)pos;
@end
