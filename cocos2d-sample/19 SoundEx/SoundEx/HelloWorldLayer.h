//
//  HelloWorldLayer.h
//  SoundEx
//
//  Created by Lee Jaewhan on 11. 8. 2..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface HelloWorldLayer : CCLayer
{
    SimpleAudioEngine *sae;
}

+ (CCScene *)scene;

@end
