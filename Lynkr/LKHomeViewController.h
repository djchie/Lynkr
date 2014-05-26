//
//  LKHomeViewController.h
//  Lynkr
//
//  Created by Derrick J Chie on 5/24/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import <Parse/Parse.h>
#import "LKUIViewController.h"
#import "GGView.h"
#import "CompanyObject.h"
#import "GGDraggableView.h"
#import "LKMoreInfoTableViewController.h"

@interface LKHomeViewController : LKUIViewController <GGDraggableViewDelegate>

@property(nonatomic, strong) NSMutableArray *companyArray;
@property(nonatomic, weak) PFObject *currentCompany;
@property(nonatomic, weak) GGView *ggView;
@property(nonatomic, weak) GGDraggableView *topDraggableView;
@property(nonatomic, weak) GGDraggableView *nextDraggableView;
@property(nonatomic, weak) UIButton *moreInfoButton;

@end
