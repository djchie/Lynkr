//
//  CompanyObject.h
//  Lynkr
//
//  Created by Dinh Ho on 5/24/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import <Parse/Parse.h>

@interface PFObject (CompanyObject)
{
}
-(UIImage *)getCompanyImage;
-(NSString *)getCompanyShortDescription;
-(NSString *)getCompanyLongDescription;
-(NSString *)getCompanyCity;
-(NSString *)getCompanyState;

//@property(nonatomic, strong)PFObject *pfObject;

@end

@interface CompanyObjectDataProvider : NSObject
{
    NSMutableArray *currentCompanyList;
    
}
+(CompanyObjectDataProvider *)sharedCompanyDataProvider;
-(id)init;
-(void)queryCompanyByCity:(NSString *)city andCompletion:(void (^)(NSArray *, NSError *))block;
-(NSArray *)queryCompanyByCity:(NSString *)city;
-(void)queryCompanyByName:(NSString *)name andCompletion:(void (^)(NSArray *, NSError *))block;
-(NSArray *)queryCompanyByName:(NSString *)name;

// variable is used to store the latest query
@end