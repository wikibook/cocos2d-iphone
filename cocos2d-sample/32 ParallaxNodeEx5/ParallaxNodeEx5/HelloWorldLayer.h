//
//  HelloWorldLayer.h
//  ParallaxNodeEx5
//
//  Created by Lee Jaewhan on 11. 9. 3..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "cocos2d.h"

@interface HelloWorldLayer : CCLayer
{
    CGSize winSize;
    
    // 방향 전환에 쓰일 버튼
    // 눌리기 전과 눌렸을 때에 쓸 수 있도록 각 방향별로 두개씩 만든다.
    CCSprite  *rightSprite;
    CCSprite  *rightPressedSprite;
    CCSprite  *leftSprite;
    CCSprite  *leftPressedSprite;
    CCSprite  *dragon;
    
    BOOL isLeftPressed;
    BOOL isRightPressed;
    
}

@property (nonatomic, retain) CCSprite  *rightSprite;
@property (nonatomic, retain) CCSprite  *rightPressedSprite;
@property (nonatomic, retain) CCSprite  *leftSprite;
@property (nonatomic, retain) CCSprite  *leftPressedSprite;
@property (nonatomic, retain) CCSprite  *dragon;


+ (CCScene *)scene;
- (void)createBackgroundParallax;
- (void)createArrowButtons;
- (void)createDragon;
- (BOOL)isTouchInside:(CCSprite*)sprite withTouch:(UITouch*)touch;
- (void)startMovingBackground;
- (void)stopMovingBackground;
- (void)moveBackground;

@end
