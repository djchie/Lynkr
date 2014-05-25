//
//  CompanyObject.m
//  Lynkr
//
//  Created by Dinh Ho on 5/24/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import "CompanyObject.h"



@implementation PFObject (CompanyObject)

-(UIImage *)getCompanyImage
{
    NSString *primary_image = [self objectForKey:@"primary_image"];
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
    return [self objectForKey:@"short_description"];
}

-(NSString *)getCompanyLongDescription
{
    return [self objectForKey:@"description"];
}



@end

@implementation CompanyObjectDataProvider
-(id)init
{
    if (self = [super init])
    {
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

-(void)queryCompanyByCity:(NSString *)city andCompletion:(void (^)(NSArray *, NSError *))block
{
    PFQuery *query = [PFQuery queryWithClassName:@"CompanyObject"];
    [query whereKey:@"city" equalTo:city];
    [query findObjectsInBackgroundWithBlock:block];
    
}

-(void)queryCompanyByName:(NSString *)name andCompletion:(void (^)(NSArray *, NSError *))block
{
    PFQuery *query = [PFQuery queryWithClassName:@"CompanyObject"];
    [query whereKey:@"name" equalTo:name];
    [query findObjectsInBackgroundWithBlock:block];
}




@end