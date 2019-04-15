//
//  Movie.h
//  Popular Movies
//
//  Created by Lost Star on 4/8/19.
//  Copyright © 2019 Toka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>


@interface Movie : RLMObject
@property(nonatomic)long movieId;
@property(nonatomic)float voteAverage;
@property(nonatomic)NSString * title;
@property(nonatomic)NSString * posterPath;
//@property(nonatomic)NSString * backdropPath;
@property(nonatomic)NSString * overview;


@end

