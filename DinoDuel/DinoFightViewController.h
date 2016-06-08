//
//  DinoFightViewController.h
//  DinoDuel
//
//  Created by tstone10 on 6/7/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dinosaur.h"

@interface DinoFightViewController : UIViewController

@property (strong, nonatomic) Dinosaur *dino1;
@property (strong, nonatomic) Dinosaur *dino2;
@property (strong, nonatomic) Dinosaur *winner;
@property (strong, nonatomic) Dinosaur *loser;

@end
