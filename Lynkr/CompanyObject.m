//
//  CompanyObject.m
//  Lynkr
//
//  Created by Dinh Ho on 5/24/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import "CompanyObject.h"



@implementation CompanyObject

-(id)init
{
    if ((self = [super init]))
    {
        // any intialization here
    }
    return self;
}

-(UIImage *)getCompanyImage
{
    NSString *primary_image = [self.pfObject objectForKey:@"primary_image"];
    if (primary_image != nil)
    {
        NSURL *url = [NSURL URLWithString:primary_image];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        return image;
    }
    else
        return nil;
}

-(NSString *)getCompanyShortDescription
{
    return [self.pfObject objectForKey:@"short_description"];
}

-(NSString *)getCompanyLongDescription
{
    return [self.pfObject objectForKey:@"description"];
}



@end

@implementation CompanyObjectDataProvider
-(id)init
{
    if (self = [super init])
    {
        currentCompanyList = [[NSMutableArray alloc] init];
    }
    return self;
}
+(CompanyObjectDataProvider *)sharedCompanyDataProvider
{
    static CompanyObjectDataProvider *dp = nil;
    if (!dp)
    {
        dp = [[CompanyObjectDataProvider alloc] init];
    }
    return dp;
}

-(void)queryCompanyByCity:(NSString *)city
{
    PFQuery *query = [PFQuery queryWithClassName:@"CompanyObject"];
    [query whereKey:@"city" equalTo:city];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        for (PFObject *obj in objects)
        {
            CompanyObject *cObj = [[CompanyObject alloc] init];
            cObj.pfObject = obj;
            [currentCompanyList addObject:cObj];
        }        
    }];
}

-(NSArray *)getQueryResult
{
    NSArray *result = [NSArray arrayWithArray:currentCompanyList];
    return result;
}


@end