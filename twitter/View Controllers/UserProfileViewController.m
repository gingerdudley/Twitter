//
//  UserProfileViewController.m
//  twitter
//
//  Created by Ginger Dudley on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface UserProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioBodyLabel;



@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.profileImage setImageWithURL:self.user.profilePicture];
    [self.backdropImage setImageWithURL:self.user.bannerPicture];
    self.userLabel.text = self.user.name;
    [self.userLabel sizeToFit];
    NSString *atSign = @"@";
    self.screenNameLabel.text = [atSign stringByAppendingString:self.user.screenName];
    [self.screenNameLabel sizeToFit];
    self.bioBodyLabel.text = self.user.userBio;
    [self.bioBodyLabel sizeToFit];
    
    //NSLog(@"%d", self.user.followingCount);
    self.followerCountLabel.text = [NSString stringWithFormat:@"%d", self.user.followerCount];
    [self.followerCountLabel sizeToFit];
    self.followingCountLabel.text = [NSString stringWithFormat:@"%d", self.user.followingCount];
    [self.followingCountLabel sizeToFit];
    
    
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
