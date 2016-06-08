//
//  Dinosaur.h
//  DinoDuel
//
//  Created by tstone10 on 6/7/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Dinosaur : NSObject

@property (strong, nonatomic) NSString *name;
@property int armor;
@property int attack;
@property int hp;
@property (strong, nonatomic) UIImage *image;

-(Dinosaur *)initWithName:(NSString *)name andArmor:(int)armor andAttack:(int)attack andHp:(int)hp andImageString:(NSString *)imgString;

@end
