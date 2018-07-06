//
//  ComposeViewController.m
//  twitter
//
//  Created by Ginger Dudley on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"

@interface ComposeViewController ()


@property (weak, nonatomic) IBOutlet UITextView *TweetBody;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //changing the character count for the tweet
    self.TweetBody.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeTweetAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetAction:(id)sender {
    [[APIManager shared] postStatusWithText:self.TweetBody.text completion:^(Tweet *tweet, NSError * error) {
        [self dismissViewControllerAnimated:true completion:nil];
        
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    int characterLimit = 140;

    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.TweetBody.text stringByReplacingCharactersInRange:range withString:text];

    // TODO: Update Character Count Label
    //int characterCount = characterLimit - newText.length;
    self.characterCountLabel.text = [NSString stringWithFormat:@"%d", 140 - self.TweetBody.text.length];

    // The new text should be allowed? True/False
    return newText.length < characterLimit;

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
