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
@property (weak, nonatomic) IBOutlet UILabel *playerMoney;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *dealerCards;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *playerCards;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
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
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *playerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealerScoreLabel;

@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property (weak, nonatomic) IBOutlet UIButton *stayButton;

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
    [self cleanUp];
    float _bet = [[_betTextField text] floatValue];
    //self.testLabel.text = [self.betTextField text];
    [self.betTextField resignFirstResponder];
    if (_bet >= 1.00)
    {
        NSString* playMon = [[NSString alloc] initWithFormat:@"%f",[_player money]];
        [_playerMoney setText:playMon];
        
        
        float newMon = ([_player money] - _bet);
        //NSLog(@"THIS IS PLAYER MONEY: %2f", newMon);
        [_player setMoney:newMon];
        [_player draw:[_gamey dealCard:_deck]];
        [_player draw:[_gamey dealCard:_deck]];
        [_dealer draw:[_gamey dealCard:_deck]];
        
        [self showCurrentScore:_player withLabel:_playerScoreLabel];
        [self showCurrentScore:_dealer withLabel:_dealerScoreLabel];
        [self showMoney];
        [self showOnScreen:_player usingCollection:_playerCards];
        [self showOnScreen:_dealer usingCollection:_dealerCards];
       
        [self.startButton resignFirstResponder];
    }
    //[self cleanUp];
    [_startButton setEnabled:false];
}
-(void)calcWin
{
    if( _dealer.score > _player.score && _dealer.score < 22)
    {
        playWin = 0;
        self.testLabel.text = @"DEALER WINS. PLAY AGAIN!";
        self.startButton.enabled = YES;
    }
    else if (_player.score > _dealer.score && _player.score < 22)
    {
        playWin = 1;
        self.testLabel.text = @"YOU WIN. PLAY AGAIN!";
        self.startButton.enabled = YES;
        //give winnings
    }
    else if(_dealer.score == _player.score)
    {
        playWin = 0;
        self.testLabel.text = @"DEALER WINS. PLAY AGAIN!";
        self.startButton.enabled = YES;
    }
    else if(_player.score > 21)
    {
        playWin = 0;
        self.testLabel.text = @"BUST. YOU LOSE. PLAY AGAIN!";
        self.startButton.enabled = YES;
    }
    else if(_dealer.score > 21)
    {
        playWin = 1;
        self.testLabel.text = @"DEALER BUST. YOU WIN. PLAY AGAIN!";
        self.startButton.enabled = YES;
    }
}

-(void) showOnScreen:(Player*)p usingCollection:(NSArray*)setOfCards
{
    for(UILabel *cardy in setOfCards)
    {
        if ([cardy tag] < [p handSize])
        {
            //_testLabel.text = @"in showScreen";
            Card *newCard = p.hand[[cardy tag]];
            [cardy setText:[self displayCard: newCard]];
        }
    }
}
-(void) showMoney
{
    NSString* money = [[NSString alloc] initWithFormat:@"%f",[_player money]];
    NSLog(@"THIS IS MY MONEY: %@",money);
    [_playerMoney setText:money];
    
}
-(void)showCurrentScore: (Player*)p withLabel: (UILabel*) lab
{
    
    NSString* score = [[NSString alloc] initWithFormat:@"%i",[p calcScore]];
   
    [lab setText: score];
}

- (IBAction)hit:(id)sender
{
    [_player draw:[_gamey dealCard:_deck]];
    [self showOnScreen:_player usingCollection:_playerCards];
    if( [_player calcScore] > 21)
    {
        playWin = 0;
    }
    [self showCurrentScore:_player withLabel:_playerScoreLabel];
}


- (IBAction)stay:(id)sender
{
    //self.testLabel.text = @"in STAY";
    [self dealAction];
    [self showCurrentScore:_dealer withLabel:_dealerScoreLabel];
    [self.stayButton resignFirstResponder];
    [self calcWin];
}
-(void) dealAction
{
    //self.testLabel.text = @"in DEALER ACTION";
    while ([_dealer calcScore] < 17)
    {
        [_dealer draw:[_gamey dealCard:_deck]];
        [self showOnScreen:_dealer usingCollection: _dealerCards];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)cleanUp
{
    _gamey.gameNumber +=1;
    for(UILabel *cardy in _dealerCards)
    {
        [cardy setText: @""];
    }
    for(UILabel *cardy in _playerCards)
    {
        [cardy setText: @""];
    }
     NSLog(@"PLAYER HAND PRE: %i",_player.handSize);
    [_player discard];
    [_dealer discard];
    NSLog(@"PLAYER HAND POST: %i",_player.handSize);
    self.dealerScoreLabel.text = @"";
    self.playerScoreLabel.text = @"";
    self.testLabel.text = @"";
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _gamey = [[Game alloc] init];
    _dealer = [[Player alloc] init];
    _player = [[Player alloc]init];
    _deck = [_gamey start];

    
	// Do any additional setup after loading the view, typically from a nib.
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
