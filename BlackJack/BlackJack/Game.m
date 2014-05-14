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

-(id)init
{
    self = [super init];
    if(self)
    {
        _minBet = 1.00;
        _numPlayers = 1;
        _numDecks = 1;
        _gameNumber = 0;
        _totalBet = 0.00;
        
    }
    return self;
    
}
-(Deck*)start
{
    //NSLog(@"HI");
    Deck* dek = [[Deck alloc]init];
    [dek makeDeck];
    _usedUp = [[NSMutableArray alloc] init];
    return dek;
}
-(Card*)dealCard:(Deck*) d
{
    Card* lastCard = [d.deckie lastObject];
    [d.deckie removeLastObject];
    [_usedUp addObject: lastCard];
    return lastCard;
    
    
}

@end
