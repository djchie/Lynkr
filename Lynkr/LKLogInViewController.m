//
//  ViewController.m
//  LinkedinTest
//
//  Created by Dinh Ho on 5/25/14.
//  Copyright (c) 2014 Project 2. All rights reserved.
//

#import "LKLogInViewController.h"

#import "AFHTTPRequestOperation.h"
#import "LIALinkedInHttpClient.h"
#import "LIALinkedInApplication.h"
#import "LKHomeViewController.h"
#import "LKRootViewController.h"
#import "UserObject.h"

#define kLinkedAppId @"75e11d705d4fst"
#define kLinkedSecretKey @"CHyhF3pq7rEMzYEh"
#define kLinkedOAuthToken @"0d8cd309-50da-439a-8d55-c14c3e99675b"
#define kLinkedOAuthSecret @"c0d20a46-5184-4d48-933b-17cf2140ea59"

@interface LKLogInViewController ()

@end

@implementation LKLogInViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    client = [self client];
}


- (IBAction)didTapConnectWithLinkedIn:(id)sender {
    [self.client getAuthorizationCode:^(NSString *code) {
        [self.client getAccessToken:code success:^(NSDictionary *accessTokenData)
         {
             NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
             NSLog(@"access token %@", accessToken);
             [self requestMeWithToken:accessToken];
         }                   failure:^(NSError *error)
         {
             NSLog(@"Quering accessToken failed %@", error);
         }];
    }                      cancel:^{
        NSLog(@"Authorization was cancelled by user");
    }                     failure:^(NSError *error) {
        NSLog(@"Authorization failed %@", error);
    }];
}


- (void)requestMeWithToken:(NSString *)accessToken
{
    [self.client GET:[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(id,first-name,last-name,industry,email-address,interests,main-address,headline,phone-numbers,site-standard-profile-request,educations,skills)?oauth2_access_token=%@&format=json", accessToken] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result)
     {
         NSLog(@"current user %@", result);
         [[UserObjectDataProvider sharedUserDataProvider] createUserWithDictionary:result];
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         LKRootViewController *rootvc = [storyboard instantiateViewControllerWithIdentifier:@"rootViewController"];
         [self presentViewController:rootvc animated:true completion:nil];
         
     }        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"failed to fetch current user %@", error);
     }];
}

- (LIALinkedInHttpClient *)client {
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"http://www.yahoo.com"
                                                                                    clientId:kLinkedAppId
                                                                                clientSecret:kLinkedSecretKey    state:@"DCEEFWF45453sdffef424"
                                                                               grantedAccess:@[@"r_fullprofile", @"r_network", @"r_emailaddress"]];
    
    return [LIALinkedInHttpClient clientForApplication:application presentingViewController:nil];
}
@end
