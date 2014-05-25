//
//  UserObject.h
//  Lynkr
//
//  Created by Dinh Ho on 5/25/14.
//  Copyright (c) 2014 Derrick J Chie. All rights reserved.
//

#import <Parse/Parse.h>

@interface PFObject (UserObject)


@end

@interface UserObjectDataProvider : NSObject
+(UserObjectDataProvider *)sharedUserDataProvider;

-(void)createUserWithDictionary:(NSDictionary *)dictionary;


@end