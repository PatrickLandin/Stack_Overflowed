//
//  MenuTableViewController.h
//  Stack_Overflowed
//
//  Created by Patrick Landin on 2/16/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuPressedDelegate.h"

@interface MenuTableViewController : UITableViewController

@property (weak, nonatomic) id<MenuPressedDelegate> delegate;

@end
