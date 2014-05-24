//
//  CompanyObject.h
//  Lynkr
//
//  Created by Dinh Ho on 5/24/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import <Parse/Parse.h>

@interface CompanyObject : NSObject
{
}
-(id)init;
-(UIImage *)getCompanyImage;
-(NSString *)getCompanyShortDescription;
-(NSString *)getCompanyLongDescription;

@property(nonatomic, strong)PFObject *pfObject;

@end

@interface CompanyObjectDataProvider : NSObject
{
    NSMutableArray *currentCompanyList;
    
}
+(CompanyObjectDataProvider *)sharedCompanyDataProvider;
-(id)init;
-(void)queryCompanyByCity:(NSString *)city;
-(NSArray *)getQueryResult;

// variable is used to store the latest query
@end