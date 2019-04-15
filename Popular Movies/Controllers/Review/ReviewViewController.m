//
//  ReviewViewController.m
//  Popular Movies
//
//  Created by Lost Star on 4/15/19.
//  Copyright © 2019 Toka. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()
@property (weak, nonatomic) IBOutlet UILabel *autherLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentLabel;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    _autherLabel.text=_auther;
    _contentLabel.text=_content;
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
