//
//  Player.h
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "Game.h"

@interface Player : Game

@property NSString* name;
@property int score;
@property float money;

-(id)init;
-(void)bet: (int) amount;
-(void)printName;

@end
