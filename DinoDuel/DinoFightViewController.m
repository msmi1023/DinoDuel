//
//  DinoFightViewController.m
//  DinoDuel
//
//  Created by tstone10 on 6/7/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "DinoFightViewController.h"

@interface DinoFightViewController ()

@end

@implementation DinoFightViewController

UIView *dino1View, *dino2View;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.navigationItem setHidesBackButton:YES];
	
	self.view.backgroundColor = [UIColor blackColor];
	
	dino1View = [[UIView alloc] initWithFrame:CGRectMake(0-(self.view.bounds.size.width/2),
																 0,
																 self.view.bounds.size.width/2,
																 self.view.bounds.size.height)];
	dino1View.backgroundColor = [UIColor blueColor];
	dino1View.clipsToBounds = YES;
	
	double eighthDinoViewHeight = dino1View.bounds.size.height/8;
	
	UIImageView *dino1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(dino1View.bounds.origin.x,
																				dino1View.bounds.origin.y + eighthDinoViewHeight,
																				dino1View.bounds.size.width,
																				dino1View.bounds.size.height-(eighthDinoViewHeight))];
	dino1ImageView.image = _dino1.image;
	dino1ImageView.contentMode = UIViewContentModeScaleAspectFill;
	[dino1View addSubview:dino1ImageView];
	[self.view addSubview:dino1View];
	
	dino2View = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width+(self.view.bounds.size.width/2),
																 0,
																 self.view.bounds.size.width/2,
																 self.view.bounds.size.height)];
	dino2View.backgroundColor = [UIColor redColor];
	dino2View.clipsToBounds = YES;
	
	UIImageView *dino2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(dino2View.bounds.origin.x,
																				dino2View.bounds.origin.y + eighthDinoViewHeight,
																				dino2View.bounds.size.width,
																				dino2View.bounds.size.height-(eighthDinoViewHeight))];
	dino2ImageView.image = _dino2.image;
	dino2ImageView.contentMode = UIViewContentModeScaleAspectFill;
	[dino2View addSubview:dino2ImageView];
	[self.view addSubview:dino2View];
	
	CGRect newDino1Frame = dino1View.frame;
	newDino1Frame.origin.x += self.view.bounds.size.width/2;
	
	CGRect newDino2Frame = dino2View.frame;
	newDino2Frame.origin.x -= self.view.bounds.size.width;
	
	
	[UIView animateWithDuration:1.0
						  delay:1.0
						options:UIViewAnimationOptionTransitionCrossDissolve
					 animations:^{
						 dino1View.frame = newDino1Frame;
						 dino2View.frame = newDino2Frame;
					 } completion:^(BOOL finished){
						 [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showWinner) userInfo:nil repeats:NO];
					 }];
	
    // Do any additional setup after loading the view.
}

- (void)showWinner {
	self.view.backgroundColor = [UIColor whiteColor];
	
	[dino1View removeFromSuperview];
	[dino2View removeFromSuperview];
	
	UILabel *winnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 20)];
	
	[winnerLabel setBackgroundColor:[UIColor yellowColor]];
	
	int result = [self determineWinner];
	
	if(result == 1) {
		_winner = _dino1;
		_loser = _dino2;
		winnerLabel.text = [NSString stringWithFormat:@"%@ wins!", _dino1.name];
	}
	else if(result == 2) {
		_winner = _dino2;
		_loser = _dino1;
		winnerLabel.text = [NSString stringWithFormat:@"%@ wins!", _dino2.name];
	}
	else {
		_winner = nil;
		_loser = nil;
		winnerLabel.text = [NSString stringWithFormat:@"Nobody wins"];
	}
	
	[self.view addSubview:winnerLabel];
	
	UIButton *fightAgain = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 300, 20)];
	
	[fightAgain setBackgroundColor:[UIColor redColor]];
	
	[fightAgain addTarget:self
				   action:@selector(finishedPressed)
		 forControlEvents:UIControlEventTouchUpInside];
	[fightAgain setTitle:@"Fight again!" forState:UIControlStateNormal];
	
	[self.view addSubview:fightAgain];
}

- (void)finishedPressed {
	[self performSegueWithIdentifier:@"unwindSegue" sender:self];
};

- (int)determineWinner {
	int counter = 1;
	
	while(1) {
		int dino1LeftHp, dino2LeftHp;
		
		dino1LeftHp = _dino1.hp - ((_dino2.attack - _dino1.armor) * counter);
		dino2LeftHp = _dino2.hp - ((_dino1.attack - _dino2.armor) * counter);
		
		if(dino1LeftHp < 1 && dino2LeftHp < 1) {
			return 0;
		}
		else if (dino2LeftHp < 1){
			return 1;
		}
		else if (dino1LeftHp < 1){
			return 2;
		}
		
		counter++;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation



@end
