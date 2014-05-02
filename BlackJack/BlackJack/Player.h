//
//  Player.h
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "Game.h"

@interface Player : Game

@property int score;
@property float money;
@property NSMutableArray* hand;
-(id)init;
-(void)bet: (int) amount;
-(void)draw: (Card*) c;
-(void) discard;
-(int)handSize;
-(int)calcScore;
@end
