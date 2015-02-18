//
//  MenuPressedDelegate.h
//  Stack_Overflowed
//
//  Created by Patrick Landin on 2/18/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuPressedDelegate <NSObject>

-(void)menuOptionSelected:(NSInteger)selectedRow;

@end
