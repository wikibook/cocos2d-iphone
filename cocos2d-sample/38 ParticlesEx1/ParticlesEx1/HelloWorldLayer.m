//
//  HelloWorldLayer.m
//  ParticlesEx1
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
        
        
        // 기본 Label 생성
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

        CGSize size = [[CCDirector sharedDirector] winSize];
    
        label.position =  ccp( size.width /2 , size.height/2 );
        
        [self addChild: label];
    

        // 파티클 시스템 적용
        [self doParticles];
    }
    return self;
}

- (void)doParticles
{
//    CCParticleSystem *particleTest = [CCParticleExplosion node];
    CCParticleSystem *particleTest = [CCParticleFlower node];

    [self addChild:particleTest z:1 tag:1];
}

@end
