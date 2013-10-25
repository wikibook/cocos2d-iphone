//
//  HelloWorldLayer.m
//  ParticlesEx2
//
//  Created by Lee Jaewhan on 11. 9. 9..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"


@implementation HelloWorldLayer

- (void)dealloc
{
    [super dealloc];
}

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
    
    HelloWorldLayer *layer = [HelloWorldLayer node];
    
    [scene addChild: layer];
    
    return scene;
}

- (id)init
{
    if ( (self=[super init]) ) {
        
        
        // 파티클 시스템 적용
        [self doParticles];

    
    }
    return self;
}

- (void)doParticles
{
    CCParticleSystem *particleTest = [CCParticleFlower node];
    particleTest.texture = [[CCTextureCache sharedTextureCache] addImage: @"stars-grayscale.png"];
    
    [self addChild:particleTest z:1 tag:1];
}


@end
