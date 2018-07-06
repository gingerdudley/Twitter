//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Ginger Dudley on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface TweetDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetBodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

//adding outlet for entities image
@property (weak, nonatomic) IBOutlet UIImageView *mediaImage;


@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //_tweet = tweet;
    //self.profileImage.image = nil;
    if (self.tweet.user.profilePicture) {
        [self.profileImage setImageWithURL:self.tweet.user.profilePicture];
    }
    self.nameLabel.text = self.tweet.user.name;
    [self.nameLabel sizeToFit];
    NSString *atSign = @"@";
    self.usernameLabel.text = [atSign stringByAppendingString:self.tweet.user.screenName];
    [self.usernameLabel sizeToFit];
    
    self.tweetBodyLabel.text = self.tweet.text;
    [self.tweetBodyLabel sizeToFit];
    
    self.dateLabel.text = self.tweet.createdAtString;
    [self.dateLabel sizeToFit];
    
    self.retweetNumberLabel.text = [[NSString stringWithFormat:@"%d", self.tweet.retweetCount] stringByAppendingString:@" retweets"];
    //[self.retweetNumberLabel sizeToFit];
    self.favoriteNumberLabel.text = [[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] stringByAppendingString:@" favorites"];
    
    //adding image for entity option
    if (self.tweet.mediaTweetImage) {
        [self.mediaImage setImageWithURL:self.tweet.mediaTweetImage];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapReply:(id)sender {
    
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
- (IBAction)didTapFavorite:(id)sender {
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
    self.retweetNumberLabel.text = [[NSString stringWithFormat:@"%d", self.tweet.retweetCount] stringByAppendingString:@" retweets"];
    self.favoriteNumberLabel.text = [[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] stringByAppendingString:@" favorites"];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
