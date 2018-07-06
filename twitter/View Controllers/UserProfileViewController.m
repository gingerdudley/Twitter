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


@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.profileImage setImageWithURL:self.user.profilePicture];
    //self.backdropImage setImageWithURL:self.user.
    
    
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
