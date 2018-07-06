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
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImage addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileImage setUserInteractionEnabled:YES];
    
    //[self.delegate tweetCell:self didTap:self.tweet.user];
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
    
    //add in string with format to get the screen name to have an at
    NSString *atSign = @"@";
    self.screenNameLabel.text = [atSign stringByAppendingString:tweet.user.screenName];
    
    
    self.profileImage.image = nil;
    if(tweet.user.profilePicture != nil){
        [self.profileImage setImageWithURL:tweet.user.profilePicture];
    }
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.dateStampLabel.text = tweet.createdAtString;
    [self.dateStampLabel sizeToFit];
    
    
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

- (IBAction)didTapRetweet:(id)sender {
    if(self.tweet.retweeted){
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        [self refreshData];
        [[APIManager shared] unretweeted:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [self refreshData];
        [[APIManager shared] retweeted:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
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
    
    if(self.tweet.retweeted){
        UIImage *retweetButtonImage = [UIImage imageNamed:@"retweet-icon-green"];
        [self.retweetButton setImage:retweetButtonImage forState:UIControlStateNormal];
    }
    else{
        UIImage *retweetButtonImage = [UIImage imageNamed:@"retweet-icon"];
        [self.retweetButton setImage:retweetButtonImage forState:UIControlStateNormal];
    }
    
}

-(void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    //call the method on the delegate
    [self.delegate tweetCell:self didTap:self.tweet.user];
    
    
}



@end
