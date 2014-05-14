//
//  Deck.h
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "Card.h"

@interface Deck : Card

@property int totalCards;
@property NSMutableArray* deckie;
@property NSMutableArray* suits;
@property NSMutableArray* faces;

-(id)init;
-(void) makeDeck;
-(Card*)showCard:(int) idx;
-(void) shuffleDeck;
@end
