//
//  Game.h
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>
#import "Deck.h"
@interface Game : NSObject

@property int minBet;
@property int numPlayers;
@property int numDecks;
@property int gameNumber;

-(id)init;
-(Deck*)start;
-(Card*)dealCard:(Deck*) d;

@end
