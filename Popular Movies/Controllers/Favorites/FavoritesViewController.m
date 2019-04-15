//
//  FavoritesViewController.m
//  Popular Movies
//
//  Created by Lost Star on 4/13/19.
//  Copyright © 2019 Toka. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController (){
    RLMArray *movies;
}

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];

}

- (void)viewWillAppear:(BOOL)animated{
    movies = [Movie allObjects];
    [self.collectionView reloadData];
    NSLog(@"Movies : %@",movies);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell" forIndexPath:indexPath];
    
    Movie *movie=movies[indexPath.row];
    UIImageView *image;
    NSString *BASE_IMAGE_URL=@"http://image.tmdb.org/t/p/w185";
    NSString *imageUrl=[BASE_IMAGE_URL stringByAppendingString:movie.posterPath];
    
    image=(UIImageView*)[cell viewWithTag:1];
    
    [image setImageWithURL:[NSURL URLWithString:imageUrl]  usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    image.layer.cornerRadius=7.0f;
    image.layer.borderColor=[UIColor clearColor].CGColor;
    image.layer.borderWidth=1.0f;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Movie *movie=movies[indexPath.row];
    
    DetailsViewController *detailsVC=[self.storyboard instantiateViewControllerWithIdentifier:@"detailsVC"];
    
    detailsVC.movie=movie;
    // [self presentViewController:detailsVC animated:YES completion:nil];
    [self.navigationController pushViewController:detailsVC animated:YES];
    
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
