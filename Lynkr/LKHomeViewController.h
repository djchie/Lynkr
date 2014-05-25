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

@interface LKHomeViewController : LKUIViewController

@property(nonatomic, strong) NSMutableArray *companyArray;
@property(nonatomic, weak) PFObject *currentCompany;
@property(nonatomic, weak) GGView *ggView;
@property(nonatomic, weak) GGDraggableView *draggableView;

@end
