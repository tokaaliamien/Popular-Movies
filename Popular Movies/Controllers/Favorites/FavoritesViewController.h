//
//  FavoritesViewController.h
//  Popular Movies
//
//  Created by Lost Star on 4/13/19.
//  Copyright © 2019 Toka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "DetailsViewController.h"



NS_ASSUME_NONNULL_BEGIN

@interface FavoritesViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
