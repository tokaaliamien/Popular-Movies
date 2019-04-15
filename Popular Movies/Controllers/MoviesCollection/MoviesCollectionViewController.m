//
//  MoviesCollectionViewController.m
//  Popular Movies
//
//  Created by Lost Star on 4/6/19.
//  Copyright © 2019 Toka. All rights reserved.
//

#import "MoviesCollectionViewController.h"

@interface MoviesCollectionViewController (){
    NSMutableArray *results;
}

@end

@implementation MoviesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    
    results=[NSMutableArray new];
    
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *filter = [def objectForKey:@"orderBy"];
    if(filter!=nil){
        [self getMovies:filter];
        if([filter isEqual:@"popular"])
            _filterSegmentedControl.selectedSegmentIndex=0;
        else
            _filterSegmentedControl.selectedSegmentIndex=1;
    }
    else
        [self getMovies:@"popular"];
}

- (IBAction)segmentedControlChanged:(id)sender {
    NSString *filter=@"";
    switch(_filterSegmentedControl.selectedSegmentIndex){
        case 0:
            filter=@"popular";
            break;
        case 1:
            filter=@"top_rated";
            break;
    }
    [self getMovies:filter];
}

-(void)getMovies:(NSString *)filter{
    NSString *baseUrl=@"http://api.themoviedb.org/3/movie/";
    baseUrl=[baseUrl stringByAppendingString:filter];
    baseUrl=[baseUrl stringByAppendingString:@"?api_key=1a93ae1cbde08f267f8935e401ae9a52"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:baseUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self->results=responseObject[@"results"];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return results.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell" forIndexPath:indexPath];
    
    if(results[indexPath.row][@"poster_path"]!=nil){
        UIImageView *image;
        NSString *BASE_IMAGE_URL=@"http://image.tmdb.org/t/p/w185";
        NSString *imageUrl=[BASE_IMAGE_URL stringByAppendingString:results[indexPath.row][@"poster_path"]];

        image=(UIImageView*)[cell viewWithTag:1];

        [image setImageWithURL:[NSURL URLWithString:imageUrl]  usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        image.layer.cornerRadius=7.0f;
        image.layer.borderColor=[UIColor clearColor].CGColor;
        image.layer.borderWidth=1.0f;

    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Movie *movie=[Movie new];
    /*[results[indexPath.row] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        [movie setValue:obj forKey:(NSString *)key];
    }];*/

    movie.movieId=[[results[indexPath.row] objectForKey:@"id"] intValue];
    movie.title=[results[indexPath.row] objectForKey:@"title"];
    movie.voteAverage=[[results[indexPath.row] objectForKey:@"vote_average"] floatValue];
    movie.posterPath=[results[indexPath.row] objectForKey:@"poster_path"];
    movie.overview=[results[indexPath.row] objectForKey:@"overview"];
    //movie.backdropPath=[results[indexPath.row] objectForKey:@"backdrop_path"];

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

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
