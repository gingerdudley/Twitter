//
//  User.h
//  twitter
//
//  Created by Ginger Dudley on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSURL *profilePicture;
@property (strong, nonatomic) NSString *userBio;
@property (strong, nonatomic) NSNumber *followerCount;
@property (strong, nonatomic) NSURL *bannerPicture;
@property (strong, nonatomic) NSNumber *followingCount;


//@property int followingCount;
//@property int followerCount;


-(instancetype)initWithDictionary: (NSDictionary *)dictionary;

@end


