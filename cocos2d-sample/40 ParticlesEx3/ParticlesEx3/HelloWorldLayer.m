//
//  HelloWorldLayer.m
//  ParticlesEx3
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
    CCParticleSystem *particleTest = [CCParticleFire node];
    
    // 파티클의 위치 지정
    particleTest.position = ccp(50, 160);
    
    // 파티클의 크기 조정
    particleTest.scale = 0.2;
    
    // 파티클 지속 시간 조정
    particleTest.duration = 3.0;
    
    [self addChild:particleTest z:1 tag:1];
}



@end
