//
//  UserObject.m
//  Lynkr
//
//  Created by Dinh Ho on 5/25/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import "UserObject.h"

@implementation PFObject (UserObject)


@end
@implementation UserObjectDataProvider

+(UserObjectDataProvider *)sharedUserDataProvider
{
    static UserObjectDataProvider *dp = nil;
    if (!dp)
    {
        dp = [[UserObjectDataProvider alloc] init];
    }
    return dp;
}

-(void)createUserWithDictionary:(NSDictionary *)dictionary
{
    PFObject *userObject = [[PFObject alloc] initWithClassName:@"User"];
    if (dictionary[@"firstName"])
    {
        userObject[@"first_name"] = dictionary[@"firstName"];
    }
    if (dictionary[@"lastName"])
    {
        userObject[@"last_name"] = dictionary[@"lastName"];
    }
    if (dictionary[@"industry"])
    {
        userObject[@"industry"] = dictionary[@"industry"];
    }
    if (dictionary[@"id"])
    {
        userObject[@"linkedin_id"] = dictionary[@"id"];
    }
    if (dictionary[@"siteStandardProfileRequest"])
    {
        userObject[@"linkedin_url"] = dictionary[@"siteStandardProfileRequest"][@"url"];
    }
    if (dictionary[@"educations"])
    {
        NSArray* test = dictionary[@"educations"][@"values"];
        NSDictionary *education = test[0];
        if (education[@"degree"])
        {
            userObject[@"degree"] = education[@"degree"];
        }
        if (education[@"fieldOfStudy"])
        {
            userObject[@"field_of_study"] = education[@"fieldOfStudy"];
        }
        if (education[@"schoolName"])
        {
            userObject[@"school"] = education[@"schoolName"];
        }
    }
    if (dictionary[@"headline"])
    {
        userObject[@"headline"] = dictionary[@"headline"];
    }
    if (dictionary[@"emailAddress"])
    {
        userObject[@"email"] = dictionary[@"emailAddress"];
    }
    
    NSLog(@"%@", userObject);
    [userObject saveInBackground];
}
-(bool)checkIfUserExist:(NSDictionary *)dictionary
{
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"email" equalTo:dictionary[@"emailAddress"]];
    NSArray *obj = [query findObjects];
    if (obj.count == 0)
    {
        return false;
    }
    else
        return true;
}

@end
