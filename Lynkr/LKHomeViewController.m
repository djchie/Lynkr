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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.draggableView = self.ggView.draggableView;

    self.navigationItem.title = @"Lynker";
    
    void (^completionBlock)(NSArray *obj, NSError *err) = ^(NSArray *obj, NSError *err)
    {
        if (!err && obj.count > 0)
        {
            self.companyArray = obj;
            self.currentCompany = [self.companyArray objectAtIndex:0];
            
            NSString *nameString = [self.currentCompany objectForKey:@"name"];
            self.draggableView.nameLabel.text = nameString;
            
            UIImage *image = [self.currentCompany getCompanyImage];
            if (image)
            {
                self.draggableView.logoImageView.image = image;
            }
            
            NSString *shortDescriptionString = [self.currentCompany getCompanyShortDescription];
            self.draggableView.pitchTextView.text = shortDescriptionString;
            
            NSString *cityString = [self.currentCompany getCompanyCity];
            NSString *stateString = [self.currentCompany getCompanyState];
            NSString *locationString = [NSString stringWithFormat:@"%@, %@", cityString, stateString];
            self.draggableView.locationLabel.text = locationString;
            
        }
        else{
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:err.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [av show];
        }
        
    };
    //  [[CompanyObjectDataProvider sharedCompanyDataProvider] queryCompanyByCity:@"Irvine" andCompletion:completionBlock];
    [[CompanyObjectDataProvider sharedCompanyDataProvider] queryCompanyByName:@"PeopleSpace" andCompletion:completionBlock];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
