//
//  TimelineViewController.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

//@interface TimelineViewController : UIViewController
@interface TimelineViewController:UIViewController <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@end
