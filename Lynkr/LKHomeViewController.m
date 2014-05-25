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
    GGView *ggView = (GGView *)self.view;
    _draggableView = ggView.draggableView;
    [_draggableView setBackgroundColor:[UIColor clearColor]];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    void (^completionBlock)(NSArray *obj, NSError *err) = ^(NSArray *obj, NSError *err)
    {
        if (!err && obj.count > 0)
        {
            _companyArray = obj;
            NSLog(@"successfully queried");
            
            //_currentCompany = [_companyArray objectAtIndex:0];
            [self setLogoImageForIndex:1];

        }
        else{
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:err.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [av show];
        }
        
    };
  //  [[CompanyObjectDataProvider sharedCompanyDataProvider] queryCompanyByCity:@"Irvine" andCompletion:completionBlock];
    [[CompanyObjectDataProvider sharedCompanyDataProvider] queryCompanyByCity:@"Palo Alto" andCompletion:completionBlock];
}

-(void)setLogoImageForIndex:(int)index
{
    _currentCompany = [_companyArray objectAtIndex:index];
    UIImage *image = [_currentCompany getCompanyImage];
    if (image)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:_draggableView.frame];
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_draggableView addSubview:imageView];
        imageView.frame = CGRectMake(_draggableView.center.x - 150, _draggableView.center.y - 250, _draggableView.frame.size.width, _draggableView.frame.size.height);
        [_draggableView bringSubviewToFront:imageView];

    }
    else
    {
        // here we should put no image available
        NSLog(@"no image available for %@", _currentCompany[@"name"]);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
