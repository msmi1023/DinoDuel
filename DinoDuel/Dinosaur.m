//
//  Dinosaur.m
//  DinoDuel
//
//  Created by tstone10 on 6/7/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import "Dinosaur.h"

@implementation Dinosaur

-(Dinosaur *)initWithName:(NSString *)name andArmor:(int)armor andAttack:(int)attack andHp:(int)hp andImageString:(NSString *)imgString {
	self = [super init];
	if(self) {
		self.name = name;
		self.armor = armor;
		self.attack = attack;
		self.hp = hp;
		self.image = [UIImage imageNamed:imgString];
	}
	return self;
}

@end
