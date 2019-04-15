//
//  DetailsViewController.h
//  Popular Movies
//
//  Created by Lost Star on 4/8/19.
//  Copyright © 2019 Toka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "HCSStarRatingView.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "AFNetworking.h"
#import "ReviewViewController.h"




NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>
@property Movie *movie;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UITextView *overViewTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
