//
//  Card.h
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property NSString* suit;
@property NSString* face;
@property int val;
-(id) initCard: (NSString*) s faceOfCard: (NSString*) f;
-(id) initWithVal: (NSString*) s valueOfCard: (int) v;
-(NSString*) displayFace;

@end
