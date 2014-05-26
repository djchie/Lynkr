//
//  LKHomeViewController.m
//  Lynkr
//
//  Created by Derrick J Chie on 5/24/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import "LKHomeViewController.h"

@interface LKHomeViewController ()

@end

@implementation LKHomeViewController

- (void)loadView
{
    self.view = [[GGView alloc] init];
    self.ggView = (GGView *)self.view;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.moreInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.moreInfoButton addTarget:self action:@selector(moreInfoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIImage *buttonImage = [UIImage imageNamed:@"MoreInfoButton"];
    [self.moreInfoButton setImage:buttonImage forState:UIControlStateNormal];
    self.moreInfoButton.frame = CGRectMake(130, 488, 60, 60);
    [self.view addSubview:self.moreInfoButton];
    [self.view sendSubviewToBack:self.moreInfoButton];
    
    self.topDraggableView = self.ggView.topDraggableView;
    self.topDraggableView.delegate = self;
    self.nextDraggableView = self.ggView.nextDraggableView;
    self.nextDraggableView.delegate = self;

    self.navigationItem.title = @"Lynker";

    if (!self.companyArray)
    {
        self.companyArray = [[NSMutableArray alloc] init];
    }

    [self fetchCompanyByName:@"PeopleSpace"];
    [self fetchCompanyByName:@"SendGrid"];
    [self fetchCompanyByName:@"Twilio"];
    [self fetchCompanyByName:@"GitHub"];
    [self fetchCompanyByName:@"Cylance"];
    [self fetchCompanyByName:@"Rdio"];
    [self fetchCompanyByName:@"DropBox"];
    [self fetchCompanyByName:@"Facebook"];
    [self fetchCompanyByName:@"Lob"];
    [self fetchCompanyByName:@"Lyft"];
    [self fetchCompanyByName:@"Uber"];
    [self fetchCompanyByName:@"Originate"];
    [self fetchCompanyByName:@"Upworthy"];
    [self fetchCompanyByName:@"Tinder"];
    [self fetchCompanyByName:@"Leap Motion"];
    [self fetchCompanyByName:@"Duolingo"];
    [self fetchCompanyByName:@"Rap Genius"];
    [self fetchCompanyByName:@"Google"];
    [self fetchCompanyByName:@"SnapChat"];
    
    
    [self prepareTopCompanyCard:[self.companyArray objectAtIndex:0]];
    [self prepareNextCompanyCard:[self.companyArray objectAtIndex:1]];
    
    self.currentCompany = [self.companyArray objectAtIndex:0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchCompanyByName:(NSString *)companyName
{
    NSArray *obj = [[CompanyObjectDataProvider sharedCompanyDataProvider] queryCompanyByName:companyName];
    if (obj && obj.count > 0)
    {
        [self.companyArray addObject:[obj objectAtIndex:0]];
        
    }
    else
    {
        NSLog(@"An error retrieving the company: %@", companyName);
        
    }
    
}

- (void)prepareTopCompanyCard:(PFObject *)company
{
    NSString *nameString = [company objectForKey:@"name"];
    self.topDraggableView.nameLabel.text = nameString;
    
    UIImage *image = [company getCompanyImage];
    if (image)
    {
        self.topDraggableView.logoImageView.image = image;
    }
    
    NSString *shortDescriptionString = [company getCompanyShortDescription];
    self.topDraggableView.pitchTextView.text = shortDescriptionString;
    
    NSString *cityString = [company getCompanyCity];
    NSString *stateString = [company getCompanyState];
    NSString *locationString = [NSString stringWithFormat:@"%@, %@", cityString, stateString];
    self.topDraggableView.locationLabel.text = locationString;
    
}

- (void)prepareNextCompanyCard:(PFObject *)company
{
    NSString *nameString = [company objectForKey:@"name"];
    self.nextDraggableView.nameLabel.text = nameString;
    
    UIImage *image = [company getCompanyImage];
    if (image)
    {
        self.nextDraggableView.logoImageView.image = image;
    }
    
    NSString *shortDescriptionString = [company getCompanyShortDescription];
    self.nextDraggableView.pitchTextView.text = shortDescriptionString;
    
    NSString *cityString = [company getCompanyCity];
    NSString *stateString = [company getCompanyState];
    NSString *locationString = [NSString stringWithFormat:@"%@, %@", cityString, stateString];
    self.nextDraggableView.locationLabel.text = locationString;
    
}

- (void)cardDecided:(bool)choice
{
    if (choice == YES)
    {
        NSLog(@"Hired!");
    }
    else if (choice == NO)
    {
        NSLog(@"Rejected!");
    }
    
    [self.companyArray removeObjectAtIndex:0];
    self.currentCompany = [self.companyArray objectAtIndex:0];
    
    if (self.view.subviews.lastObject == self.topDraggableView)
    {
        [self.view bringSubviewToFront:self.nextDraggableView];
        
        self.topDraggableView.center = self.topDraggableView.originalPoint;
        self.topDraggableView.transform = CGAffineTransformMakeRotation(0);
        
        [self prepareTopCompanyCard:[self.companyArray objectAtIndex:1]];
    }
    else if (self.view.subviews.lastObject == self.nextDraggableView)
    {
        [self.view bringSubviewToFront:self.topDraggableView];
        
        self.nextDraggableView.center = self.nextDraggableView.originalPoint;
        self.nextDraggableView.transform = CGAffineTransformMakeRotation(0);
        
        [self prepareNextCompanyCard:[self.companyArray objectAtIndex:1]];
    }
}

- (void)moreInfoButtonPressed
{
    LKMoreInfoTableViewController *moreInfoTableViewController = [[LKMoreInfoTableViewController alloc] init];
    moreInfoTableViewController.company = self.currentCompany;
    
    [self.navigationController pushViewController:moreInfoTableViewController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
