//
//  User.m
//  twitter
//
//  Created by Ginger Dudley on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    
    if(self){
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = [NSURL URLWithString:dictionary[@"profile_image_url_https"]] ;
        self.bannerPicture = [NSURL URLWithString:dictionary[@"profile_banner_url"]];
        self.userBio = dictionary[@"description"];
        self.followerCount = dictionary[@"followers_count"];
        self.followingCount = dictionary[@"friends_count"];
        
    }
    return self;
}

@end
