//
//  TweetCell.m
//  twitter
//
//  Created by Ginger Dudley on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


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
    [self.tweetTextBody sizeToFit];
    self.authorLabel.text = tweet.user.name;
    [self.authorLabel sizeToFit];
    
    self.profileImage.image = nil;
    if(tweet.user.profilePicture != nil){
        [self.profileImage setImageWithURL:tweet.user.profilePicture];
    }
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    
    
}
- (IBAction)didTapFavorite:(id)sender {
    
    //update local tweet model
    if(self.tweet.favorited){
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [self refreshData];
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [self refreshData];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    
}



-(void)refreshData{
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    if(self.tweet.favorited){
        UIImage *favoriteButtonImage = [UIImage imageNamed:@"favor-icon-red"];
        [self.favoriteButton setImage:favoriteButtonImage forState:UIControlStateNormal];
    }
    else{
        UIImage *favoriteButtonImage = [UIImage imageNamed:@"favor-icon"];
        [self.favoriteButton setImage:favoriteButtonImage forState:UIControlStateNormal];
    }
    
}

@end
