//
//  GameRunner.h
//  DinoDuel
//
//  Created by tstone10 on 6/8/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameRunner <NSObject>

- (void)showWinner;
- (void)finishedPressed;
- (int)determineWinner;

@end
