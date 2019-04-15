//
//  DetailsViewController.m
//  Popular Movies
//
//  Created by Lost Star on 4/8/19.
//  Copyright © 2019 Toka. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController (){
    NSMutableArray *reviews;
    NSMutableArray *trailers;
    Boolean isFavorite;
}
@property (weak, nonatomic) IBOutlet UIView *ratingBarView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    NSString *query=[@"movieId == " stringByAppendingString:[NSString stringWithFormat:@"%ld",_movie.movieId]];
    
    RLMArray * moviesWithThisId = [Movie objectsWhere:query];
    if(moviesWithThisId.count>0){
        isFavorite=YES;
    }else{
        isFavorite=NO;
    }
    
    [self setFavButtonIcon];
    
    RatingBar *bar = [[RatingBar alloc] initWithFrame:CGRectMake(50, 50, 180, 30)];
    bar.starNumber=3;
    bar.viewColor=[UIColor colorWithRed:0.6 green:0.8 blue:1.0 alpha:1.0];
    //[_ratingBarView addSubview:bar];
    //_imageView.image=[UIImage imageNamed: _movie.posterPath];
    _titleLabel.text=_movie.title;
    _overViewTextView.text=_movie.overview;
    if(_movie.posterPath!=nil){
        NSString *BASE_IMAGE_URL=@"http://image.tmdb.org/t/p/w500";
        NSString *imageUrl=[BASE_IMAGE_URL stringByAppendingString:_movie.posterPath];
        [_imageView setImageWithURL:[NSURL URLWithString:imageUrl]  usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    [self getReviews];
    [self getTrailers];
}


-(void)setFavButtonIcon{
    UIImage *image = [[UIImage imageNamed:@"heart.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_favButton setImage:image forState:UIControlStateNormal];
    
    if(isFavorite)
        _favButton.tintColor = [UIColor redColor];
    else
        _favButton.tintColor = [UIColor grayColor];
    
}


-(void)getReviews{
    NSString *BASE_URL=@"https://api.themoviedb.org/3/movie/";
    NSString *reviewsURL=[BASE_URL stringByAppendingString:[NSString stringWithFormat:@"%ld",_movie.movieId]];
    
    reviewsURL=[reviewsURL stringByAppendingString:@"/reviews?api_key=1a93ae1cbde08f267f8935e401ae9a52"];
    
    [self getResponse:reviewsURL :0];
    
}

-(void)getTrailers{
    NSString *BASE_URL=@"https://api.themoviedb.org/3/movie/";
    NSString *trailersURL=[BASE_URL stringByAppendingString:[NSString stringWithFormat:@"%ld",_movie.movieId]];
    
    trailersURL=[trailersURL stringByAppendingString:@"/videos?api_key=1a93ae1cbde08f267f8935e401ae9a52"];
    
    [self getResponse:trailersURL :1];
    
}

-(void)getResponse:(NSString *)url:(int)type{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        switch(type){
            case 0:
                self->reviews=responseObject[@"results"];
                break;
            case 1:
                self->trailers=responseObject[@"results"];
                break;
        }
        
        [self->_tableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *nameOfSection = @"";
    
    switch (section) {
        case 0:
            nameOfSection = @"Reviews";
            break;
        case 1:
            nameOfSection = @"Trailers";
            break;
    }
    return nameOfSection;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    long count=0;
    switch (section) {
        case 0:
            count=reviews.count;
            break;
        case 1 :
            count=trailers.count;
            break;
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell =nil;
    switch (indexPath.section) {
        case 0:{
            NSString *cellIdentifier = @"reviewCell";
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            UILabel *author=[cell viewWithTag:1];
            UITextView *content=[cell viewWithTag:2];
            CGRect frame = content.frame;
            frame.size.height = content.contentSize.height;
            content.frame = frame;
            
            author.text=reviews[indexPath.row][@"author"];
            content.text=@"alfa;kgja;kgdjaljdh";
            break;
        }
            
        case 1:{
            NSString *cellIdentifier = @"trailerCell";
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            UILabel *title=[cell viewWithTag:3];
            
            title.text=trailers[indexPath.row][@"name"];
            break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        NSString *stringURL = [@"http://www.youtube.com/watch?v=" stringByAppendingString:trailers[indexPath.row][@"key"]];
        
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)addToFav{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:_movie];
    [realm commitWriteTransaction];
}

- (void)removeFromFav{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:_movie];
    [realm commitWriteTransaction];
}

- (IBAction)favButtonClicked:(id)sender {
    if(isFavorite)
        [self removeFromFav];
    else
        [self addToFav];
    
    isFavorite=!isFavorite;
    [self setFavButtonIcon];
}

@end
