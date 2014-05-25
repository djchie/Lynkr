//
//  LKHomeViewController.m
//  Lynkr
//
//  Created by Derrick J Chie on 5/24/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import "LKHomeViewController.h"
#import "CompanyObject.h"

@interface LKHomeViewController ()

@end

@implementation LKHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

-(void)viewDidAppear:(BOOL)animated
{
    void (^completionBlock)(NSArray *obj, NSError *err) = ^(NSArray *obj, NSError *err)
    {
        if (!err)
        {
            NSLog(@"query was successful");
            NSLog(@"%i companies found", obj.count);
            NSLog(@"objects %@", obj);
//            PFObject *obje = [obj objectAtIndex:0];
//            UIImage *image = [obje getCompanyImage];
//            if (image)
//            {
//                UIImageView *view = [[UIImageView alloc] initWithFrame:self.backgroundImage.frame];
//                view.image = image;
//                [self.view addSubview:view];
//                
//            }
            
        }
        else
        {
        }
        
    };
    [[CompanyObjectDataProvider sharedCompanyDataProvider] queryCompanyByName:@"SendGrid" andCompletion:completionBlock];
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
