//
//  NYUViewController.m
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "NYUViewController.h"
#import "Game.h"
#import "Player.h"
#import "Card.h"
#import "Deck.h"

@interface NYUViewController ()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *dealerCards;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *playerCards;
@property (strong, nonatomic) Player* dealer;
@property (strong, nonatomic) Player* player;
@property (strong, nonatomic) Deck* deck;
@property (strong, nonatomic) Game* gamey;
@property (weak, nonatomic) IBOutlet UILabel *dealerScore;
@property (weak, nonatomic) IBOutlet UILabel *playerScore;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *greetingLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *betTextField;
@property (weak, nonatomic) IBOutlet UIButton *stayButton;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property int playWin;
@end

@implementation NYUViewController

int playWin = 0;


-(NSString*)displayCard:(Card*) c
{
    NSMutableString* _first = [[NSMutableString alloc]init];
    
    if ([c.face isEqual: @"K"] || [c.face isEqual: @"Q"] || [c.face isEqual: @"J"] || [c.face isEqual: @"A"] )
    {
        NSString* f = [NSString stringWithFormat:@"%@ ",c.face];
        _first = [[NSMutableString alloc]initWithString:f];
    }
    else
    {
        NSString* f = [NSString stringWithFormat:@"%i ",c.val];
        _first = [[NSMutableString alloc]initWithString:f];
        
    }
    NSString* s = [NSString stringWithFormat:@"%@",c.suit];
    [_first appendString:s];
    return _first;
    
}
- (IBAction)start:(id)sender
{
    float _bet = [[_betTextField text] floatValue];
    self.testLabel.text = [self.betTextField text];
    [self.betTextField resignFirstResponder];
    
    if (_bet >= 1.00)
    {
        _gamey = [[Game alloc] init];
        _dealer = [[Player alloc] init];
        _player = [[Player alloc]init];
        _deck = [_gamey start];
        
        [_player draw:[_gamey dealCard:_deck]];
        [_player draw:[_gamey dealCard:_deck]];
        [_dealer draw:[_gamey dealCard:_deck]];
        
        [self showOnScreen:_player usingCollection:_playerCards];
        [self showOnScreen:_dealer usingCollection:_dealerCards];
        [self.startButton resignFirstResponder];
    }
}

-(void) showOnScreen:(Player*)p usingCollection:(NSArray*)setOfCards
{
    for(UILabel *cardy in setOfCards)
    {
        if ([cardy tag] < [p handSize])
        {
            _testLabel.text = @"in showScreen";
            Card *newCard = p.hand[[cardy tag]];
            [cardy setText:[self displayCard: newCard]];
        }
    }
}

-(int)calcWin
{
    if ([_player calcScore] > [_dealer calcScore])
    {
        playWin = 1;
    }
    else if ([_player calcScore] < [_dealer calcScore] && [_dealer calcScore] < 22)
    {
        playWin = 0;
    }
    else if ([_player calcScore] == [_dealer calcScore])
    {
       playWin = 1;
    }
    else if([_dealer calcScore] > 21)
    {
        playWin = 1;
    }
    return playWin;
}

- (IBAction)stay:(id)sender
{
    self.testLabel.text = @"in STAY";
    [self dealAction];
    [self.stayButton resignFirstResponder];
}
-(void) dealAction
{
    self.testLabel.text = @"in DEALER ACTION";
    while ([_dealer calcScore] < 17)
    {
        [_dealer draw:[_gamey dealCard:_deck]];
        [self showOnScreen:_dealer usingCollection: _dealerCards];
    }
    [self calcWin];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
