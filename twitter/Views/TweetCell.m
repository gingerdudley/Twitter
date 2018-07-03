//
//  TweetCell.m
//  twitter
//
//  Created by Ginger Dudley on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTweet:(Tweet *)tweet{
    _tweet = tweet;
    //adding the different proporties for the tweet
    self.tweetTextBody.text = tweet.text;
    self.authorLabel.text = tweet.user.name;
    
    self.profileImage.image = nil;
    if(tweet.user.profilePicture != nil){
        [self.profileImage setImageWithURL:tweet.user.profilePicture];
    }
    
}

@end
