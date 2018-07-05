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

@interface TweetDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetBodyLabel;

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
    self.usernameLabel.text = self.tweet.user.screenName;
    [self.usernameLabel sizeToFit];
    
    self.tweetBodyLabel.text = self.tweet.text;
    [self.tweetBodyLabel sizeToFit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
