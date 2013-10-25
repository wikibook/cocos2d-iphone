//
//  GameCenterUtil.h
//  GameCenterEx
//
//  Created by Lee Jaewhan on 11. 9. 9..
//  Copyright 2011년 Gikimi-SW. All rights reserved.
//

#import <GameKit/GameKit.h>

#define LeaderboardID @"picturecard_point"

@interface GameCenterUtil : NSObject
{
    
}

// 게임센터가 사용가능한지 알아보는 메서드
+ (BOOL)isGameCenterAPIAvailable;

// 게임센터에 접속 및 인증받는 메서드
+ (void)authenticateLocalPlayer;

// 게임센터서버에 점수 보내는 메서드
+ (void)reportScore:(int64_t)score;

// 게임센터서버에 목표달성 보내는 메서드
+ (void)reportAchievementIdentifier:(NSString*)identifier percentComplete:(float)percent;

// 목표달성도를 리셋하는 메서드
+ (void)resetAchievements;

@end


