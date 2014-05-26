//
//  LKMoreInfoTableViewController.h
//  Lynkr
//
//  Created by Derrick J Chie on 5/25/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#include "RESideMenu.h"
#include "CompanyObject.h"

@interface LKMoreInfoTableViewController : UITableViewController

@property(nonatomic, weak) PFObject *company;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextView *pitchTextView;
@property (weak, nonatomic) IBOutlet UITextView *founderTextView;
@property (weak, nonatomic) IBOutlet UITextView *fundingTextView;
@property (weak, nonatomic) IBOutlet UITextView *locationTextView;

@end
