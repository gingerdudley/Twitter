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
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    
    //update cell UI
    [self refreshData];
    
    
    //send the POST request 
    
}

-(void)refreshData{
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    if(self.tweet.favorited != NO){
        UIImage *favoriteButtonImage = [UIImage imageNamed:@"favor-icon-red"];
        [self.favoriteButton setImage:favoriteButtonImage forState:UIControlStateNormal];
    }
    
}

@end
