//
//  LKHomeViewController.m
//  Lynkr
//
//  Created by Derrick J Chie on 5/24/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import "LKHomeViewController.h"
#import "CompanyObject.h"
#import "GGDraggableView.h"

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
    
    self.draggableView = self.ggView.draggableView;

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
    [self fetchCompanyByName:@"Google"];
    
    [self presentCompany:[self.companyArray objectAtIndex:0]];
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

- (void)presentCompany:(PFObject *)company
{
    NSString *nameString = [company objectForKey:@"name"];
    self.draggableView.nameLabel.text = nameString;
    
    UIImage *image = [company getCompanyImage];
    if (image)
    {
        self.draggableView.logoImageView.image = image;
    }
    
    NSString *shortDescriptionString = [company getCompanyShortDescription];
    self.draggableView.pitchTextView.text = shortDescriptionString;
    
    NSString *cityString = [company getCompanyCity];
    NSString *stateString = [company getCompanyState];
    NSString *locationString = [NSString stringWithFormat:@"%@, %@", cityString, stateString];
    self.draggableView.locationLabel.text = locationString;
    
}

// make method call for grabbing company by name and put in above implementation
// put below in viewWillAppear
// call 20 companies
// put it in array of companies
// in view did load, just the first company -- maybe make a method that handles making companies

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
