//
//  SelectionViewController.m
//  DinoDuel
//
//  Created by tstone10 on 6/7/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "DinoSelectionViewController.h"
#import "DinoFightViewController.h"

@interface DinoSelectionViewController ()
@property (weak, nonatomic) IBOutlet UIView *fighter1View;
@property (weak, nonatomic) IBOutlet UIView *fighter2View;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end

@implementation DinoSelectionViewController

NSMutableArray *dinoDuelers;

Dinosaur *dino1 = nil, *dino2 =nil;

- (void)viewDidLoad {
	dinoDuelers = [[NSMutableArray alloc] initWithObjects:
					[[Dinosaur alloc] initWithName:@"T-Wreckz" andArmor:1 andAttack:10 andHp:9 andImageString:@"trex"],
					[[Dinosaur alloc] initWithName:@"Sly Steggo" andArmor:10 andAttack:5 andHp:15 andImageString:@"stegosaurus"],
					[[Dinosaur alloc] initWithName:@"B.A. Brontus" andArmor:4 andAttack:1 andHp:50  andImageString:@"brontosaurus"],
					[[Dinosaur alloc] initWithName:@"Barney" andArmor:0 andAttack:0 andHp:1  andImageString:@"barney"], nil];
	
	self.navigationItem.prompt = @"Select your first fighter!";
	
	//add in tap gestures for the fighter views
	UITapGestureRecognizer *fighter1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fighter1Tapped)];
	[_fighter1View addGestureRecognizer:fighter1Tap];
	
	UITapGestureRecognizer *fighter2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fighter2Tapped)];
	[_fighter2View addGestureRecognizer:fighter2Tap];
	
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)fighter1Tapped {
	if(dino1 != nil) {
		_fighter1View.alpha = 1;
		
		if(_fighter1View.alpha == 1 && _fighter2View.alpha == 1) {
			[self performSegueWithIdentifier:@"startFightSegue" sender:self];
		}
	}
}

- (void)fighter2Tapped {
	if(dino2 != nil) {
		_fighter2View.alpha = 1;
	}
	
	if(_fighter1View.alpha == 1 && _fighter2View.alpha == 1) {
		[self performSegueWithIdentifier:@"startFightSegue" sender:self];
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	DinoFightViewController *fightCtrl = [segue destinationViewController];
	
	fightCtrl.dino1 = dino1;
	fightCtrl.dino2 = dino2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return dinoDuelers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dinoCell" forIndexPath:indexPath];
	
	Dinosaur *dino = [dinoDuelers objectAtIndex:indexPath.row];
	
	cell.textLabel.text = dino.name;
	
	cell.imageView.image = dino.image;
	
	cell.layoutMargins = UIEdgeInsetsZero;
	cell.separatorInset = UIEdgeInsetsZero;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Dinosaur *selectedDino = [dinoDuelers objectAtIndex:indexPath.row];
	NSIndexPath *path = [tableView indexPathForSelectedRow];
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
	//cell.userInteractionEnabled = NO;
	cell.backgroundView.backgroundColor = [UIColor grayColor];
	
	if(dino1 == nil) {
		dino1 = selectedDino;
		self.navigationItem.prompt = @"Select your second fighter!";
		
		UIImageView *fighter1Image = [_fighter1View viewWithTag:50];
		UILabel *fighter1Label = [_fighter1View viewWithTag:100];
		
		fighter1Image.image = dino1.image;
		fighter1Label.text = dino1.name;
	}
	else if(dino2 == nil) {
		dino2 = selectedDino;
		self.navigationItem.prompt = @"Lock in your fighters!";
		
		tableView.userInteractionEnabled = NO;
		
		UIImageView *fighter2Image = [_fighter2View viewWithTag:50];
		UILabel *fighter2Label = [_fighter2View viewWithTag:100];
		
		fighter2Image.image = dino2.image;
		fighter2Label.text = dino2.name;
	}
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (IBAction)unwindSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	//unwind!
	
	DinoFightViewController *fightCtrl = [segue sourceViewController];
	
	[dinoDuelers removeObject:fightCtrl.loser];
	[_tableView reloadData];
	
	dino1 = nil;
	dino2 = nil;
	
	self.navigationItem.prompt = @"Select your first fighter!";
	_tableView.userInteractionEnabled = YES;
	
	UIImageView *fighter1Image = [_fighter1View viewWithTag:50];
	UILabel *fighter1Label = [_fighter1View viewWithTag:100];
	
	UIImageView *fighter2Image = [_fighter2View viewWithTag:50];
	UILabel *fighter2Label = [_fighter2View viewWithTag:100];
	
	fighter1Image.image = nil;
	fighter2Image.image = nil;
	fighter1Label.text = @"";
	fighter2Label.text = @"";
	
	_fighter1View.alpha = 0.35;
	_fighter2View.alpha = 0.35;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
