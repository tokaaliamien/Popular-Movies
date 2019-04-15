//
//  SettingsViewController.m
//  Popular Movies
//
//  Created by Lost Star on 4/12/19.
//  Copyright © 2019 Toka. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController (){
    NSUserDefaults *def;
}
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    def=[NSUserDefaults standardUserDefaults];
    
}
- (IBAction)setTopRated:(id)sender {
    [def setObject:@"top_rated" forKey:@"orderBy"];
}
- (IBAction)setMostPopular:(id)sender {
    [def setObject:@"popular" forKey:@"orderBy"];
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
