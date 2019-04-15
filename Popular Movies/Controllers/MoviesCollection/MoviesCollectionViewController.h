//
//  MoviesCollectionViewController.h
//  Popular Movies
//
//  Created by Lost Star on 4/6/19.
//  Copyright © 2019 Toka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "DetailsViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "AFNetworking.h"

@interface MoviesCollectionViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *filterSegmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
