//
//  Game.m
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "Game.h"
#import "Card.h"

@implementation Game

-(id)init: (NSString*) p
{
    self = [super init];
    if(self)
    {
        _minBet = 1.00;
        _numPlayers = 1;
        _numDecks = 1;
        _gameNumber = 1;
        _playName = p;
        
    }
    return self;
    
}
-(Deck*)start
{
    Deck* dek = [[Deck alloc]init];
    [dek makeDeck];
    return dek;
}
-(Card*)dealCard:(Deck*) d
{
    int card = arc4random_uniform(52);
    NSLog(@"THIS IS RANDOM NUMBER: %i",card);
    return [d showCard:card];
    
}

@end
