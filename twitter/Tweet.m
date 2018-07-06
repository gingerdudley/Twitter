//
//  Tweet.m
//  twitter
//
//  Created by Ginger Dudley on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "NSDate+TimeAgo.h"

@implementation Tweet

-(instancetype)initWithDictionary: (NSDictionary *)dictionary{
    self = [super init];
    if(self){
        
        //testing to see is this a retweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary= dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            //switch tweet back to original
            dictionary = originalTweet;
        }
        
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        //initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        //format and set created at string
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        //configuring info to parse out the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        //changing the string to a date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        
        //changing the timestamp to display .... ago
        NSString *ago = [date timeAgo];
        self.createdAtString = ago;
        
        //output format
        //formatter.dateStyle = NSDateFormatterShortStyle;
        //formatter.timeStyle = NSDateIntervalFormatterNoStyle;
        
        //changing date to a string
        //self.createdAtString = [formatter stringFromDate:date];
        
        //adding an entity object
       // NSDictionary *entities = dictionary[@"entities"];
        //self.entities = [[Entities alloc] initWithDictionary:entities];
        
        
        
    }
    return self;
}

+(NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries){
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
