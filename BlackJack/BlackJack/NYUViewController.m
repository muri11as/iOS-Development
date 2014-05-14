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
@property (weak, nonatomic) IBOutlet UIButton *dblButton;
@property (weak, nonatomic) IBOutlet UIButton *surrButton;

@property (weak, nonatomic) IBOutlet UIButton *betButton;
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

#pragma Display Functions

//How to display a card
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
//Displays cards on-screen
-(void) showOnScreen:(Player*)p usingCollection:(NSArray*)setOfCards
{
    for(UILabel *cardy in setOfCards)
    {
        if ([cardy tag] < [p handSize])
        {
            Card *newCard = p.hand[[cardy tag]];
            [cardy setText:[self displayCard: newCard]];
        }
    }
}
//Display Function for Money
-(void) showMoney
{
    NSString* money = [[NSString alloc] initWithFormat:@"%f",[_player money]];
    NSLog(@"THIS IS MY MONEY: %@",money);
    [_playerMoney setText:money];
    
}
//Display Function for score
-(void)showCurrentScore: (Player*)p withLabel: (UILabel*) lab
{
    
    NSString* score = [[NSString alloc] initWithFormat:@"%i",[p calcScore]];
    
    [lab setText: score];
}
#pragma Game Logic

//Game initialized when start is pressed.
- (IBAction)start:(id)sender

{
    [self cleanUp];
    NSLog(@"game: %i", _gamey.gameNumber);
    
    //Shuffle if number of Games is > 5
    if(_gamey.gameNumber > 5)
    {
        [_deck.deckie addObjectsFromArray:_gamey.usedUp];
        [_gamey.usedUp removeAllObjects];
        [_deck shuffleDeck];
    }
    float _bet = [[_betTextField text] floatValue];
    [self.betTextField resignFirstResponder];
    NSLog(@"_bet is: %1.2f", _bet);
    if (_bet >= 1.00)
    {
        [self changeButtons:1];
        _gamey.totalBet += _bet;
        NSLog(@"MONEY BET initial: %1.2f",_gamey.totalBet);
        NSString* playMon = [[NSString alloc] initWithFormat:@"%f",[_player money]];
        [_playerMoney setText:playMon];
        float newMon = ([_player money] - _bet);
        [_player setMoney:newMon];
        [_player draw:[_gamey dealCard:_deck]];
        [_player draw:[_gamey dealCard:_deck]];
        [_dealer draw:[_gamey dealCard:_deck]];
        
        [self showCurrentScore:_player withLabel:_playerScoreLabel];
        [self showCurrentScore:_dealer withLabel:_dealerScoreLabel];
        [self showMoney];
        [self showOnScreen:_player usingCollection:_playerCards];
        [self showOnScreen:_dealer usingCollection:_dealerCards];
        self.betTextField.text = @"";
        [self.startButton resignFirstResponder];
        self.startButton.enabled = NO;
    }
    //Improper Bet. Ask again
    else
    {
        self.betTextField.text = @"";
        self.betTextField.placeholder = @"Enter valid $ amount.";
        self.startButton.enabled = YES;
    }
}

//See who the winner is. Pay out.
//Blackjack wins 3-2, anything else wins Even
//Check for Blackjack Tie with card amount
-(void)calcWin
{
    [self changeButtons:0];
    if( _dealer.score > _player.score && _dealer.score < 22)
    {
        playWin = 0;
        //NSMutableString *s = [NSMutableString alloc] initWith
        NSString *lb = [[NSString alloc] initWithFormat:@"DEALER WINS.PLAY AGAIN! Lost: %1.2f",_gamey.totalBet];
        self.testLabel.text = lb;
        self.startButton.enabled = YES;
        [self showMoney];
    }
    else if (_player.score > _dealer.score && _player.score < 22)
    {
        if(_player.score == 21)
        {
            NSString *lb = [[NSString alloc] initWithFormat:@"BLACKJACK! YOU WIN.PLAY AGAIN! WON: %1.2f",1.5*(_gamey.totalBet)];
            self.testLabel.text = lb;
            float win =  (_player.money + (1.5* _gamey.totalBet));
            [_player setMoney:win];
        }
        else
        {
            NSString *lb = [[NSString alloc] initWithFormat:@"YOU WIN.PLAY AGAIN! WON: %1.2f",_gamey.totalBet];
            self.testLabel.text = lb;
            float win =  _player.money + _gamey.totalBet;
            [_player setMoney:win];
        }
        playWin = 1;
        self.startButton.enabled = YES;
        [self showMoney];
    }
    else if(_dealer.score == _player.score)
    {
        if(_dealer.score == 21 && ([_dealerCards count] > [_playerCards count]))
        {
            playWin = 1;
            NSString *lb = [[NSString alloc] initWithFormat:@"BLACKJACK! YOU WIN.PLAY AGAIN! WON: %1.2f",1.5*(_gamey.totalBet)];
            self.testLabel.text = lb;
            float win =  _player.money + (1.5*_gamey.totalBet);
            [_player setMoney:win];
        }
        else
        {
            playWin = 0;
            NSString *lb = [[NSString alloc] initWithFormat:@"DEALER WINS.PLAY AGAIN! Lost: %1.2f",_gamey.totalBet];
            self.testLabel.text = lb;
        }
        self.startButton.enabled = YES;
        [self showMoney];
    }
    else if(_player.score > 21)
    {
        playWin = 0;
        NSString *lb = [[NSString alloc] initWithFormat:@"BUST.PLAY AGAIN! Lost: %1.2f",_gamey.totalBet];
        self.testLabel.text = lb;
        self.startButton.enabled = YES;
        [self showMoney];
    }
    else if(_dealer.score > 21)
    {
        playWin = 1;
        NSString *lb = [[NSString alloc] initWithFormat:@"DEALER BUST.YOU WIN.PLAY AGAIN! Won: %1.2f",_gamey.totalBet];
        self.testLabel.text = lb;
        self.startButton.enabled = YES;
        float win =  _player.money + _gamey.totalBet;
        [_player setMoney:win];
        [self showMoney];
    }
}
//Adds another card to Player's Hand
- (IBAction)hit:(id)sender
{
    self.surrButton.enabled = NO;
    [_player draw:[_gamey dealCard:_deck]];
    [self showOnScreen:_player usingCollection:_playerCards];
    if( [_player calcScore] > 21)
    {
        [self calcWin];
    }
    [self showCurrentScore:_player withLabel:_playerScoreLabel];
}
//Allows player to Bet more money whenever, except initial bet.
- (IBAction)betMoney:(id)sender
{
    NSLog(@"bet");
    float _bet = [[_betTextField text] floatValue];
    [self.betTextField resignFirstResponder];
    if (_bet >= 1.00)
    {
        _gamey.totalBet += _bet;
        float newMon = ([_player money] - _bet);
        [_player setMoney:newMon];
        [self showMoney];
    }
    self.betTextField.text = @"";
}
//Only allowed after initial deal. Disabled otherwise. Returns 1/2 of bet.
- (IBAction)surrender:(id)sender
{
    NSLog(@"MONEY BET surrender: %1.2f",_gamey.totalBet);
    float newMon = ([_player money] + (_gamey.totalBet/2.00));
    [_player setMoney:newMon];
    [self showMoney];
    NSString *lb = [[NSString alloc] initWithFormat:@"You Surrendered Lost: %1.2f",(_gamey.totalBet/2.00)];
    self.testLabel.text = lb;
    self.startButton.enabled = YES;
    [self changeButtons:0];
}
//Doubles Bet amount in textBox, gets one more card, checks for win.
- (IBAction)doubleBet:(id)sender
{
    self.hitButton.enabled = NO;
    float _bet = [[_betTextField text] floatValue];
    [self.betTextField resignFirstResponder];
    if (_bet >= 1.00)
    {
        _gamey.totalBet += (_bet*2);
        float newMon = ([_player money] - (_bet*2));
        [_player setMoney:newMon];
        [self showMoney];
        [_player draw:[_gamey dealCard:_deck]];
        [self showOnScreen:_player usingCollection: _playerCards];
        [self dealAction];
        [self calcWin];
    }
    else
    {
        self.betTextField.text = @"";
        self.betTextField.placeholder = @"Provide Bet";
    }
}
//What to do when stay is pressed
- (IBAction)stay:(id)sender
{
    self.surrButton.enabled = NO;
    [self dealAction];
    [self showCurrentScore:_dealer withLabel:_dealerScoreLabel];
    [self.stayButton resignFirstResponder];
    self.hitButton.enabled = NO;
    [self calcWin];
    self.betTextField.enabled = NO;
}
//Dealer logic
-(void) dealAction
{
    while ([_dealer calcScore] < 17)
    {
        [_dealer draw:[_gamey dealCard:_deck]];
        [self showOnScreen:_dealer usingCollection: _dealerCards];
    }
}


#pragma Miscellaneous Functions

//Ease of use function. Code re-use
-(void)changeButtons:(int)position
{
    if( position == 1)
    {
        self.surrButton.enabled = YES;
        self.stayButton.enabled = YES;
        self.betButton.enabled = YES;
        self.dblButton.enabled = YES;
        self.hitButton.enabled = YES;
    }
    else
    {
        self.surrButton.enabled = NO;
        self.stayButton.enabled = NO;
        self.betButton.enabled = NO;
        self.dblButton.enabled = NO;
        self.hitButton.enabled = NO;
        
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//Get Next Game ready.
-(void)cleanUp
{
    _gamey.gameNumber +=1;
    _gamey.totalBet = 0.00;
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
    [self changeButtons:0];
    self.betTextField.enabled = YES;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _gamey = [[Game alloc] init];
    _dealer = [[Player alloc] init];
    _player = [[Player alloc]init];
    _deck = [_gamey start];
    [_deck shuffleDeck];
    [self changeButtons:0];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
