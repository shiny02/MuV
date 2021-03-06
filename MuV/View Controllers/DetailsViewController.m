//
//  DetailsViewController.m
//  MuV
//
//  Created by Youngmin Shin on 6/28/18.
//  Copyright © 2018 Youngmin Shin. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *blurbLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL * posterURL = [NSURL URLWithString:fullPosterURLString];
    
    [self.posterView setImageWithURL:posterURL];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL * backdropURL = [NSURL URLWithString:fullBackdropURLString];
    
    [self.backdropView setImageWithURL:backdropURL];
    
    self.titleLabel.text = self.movie[@"title"];
    self.blurbLabel.text = self.movie[@"overview"];
    NSString * rating = [NSString stringWithFormat:@"%@", self.movie[@"vote_average"]];
    self.ratingLabel.text = [@"Rating: " stringByAppendingString: rating];
    
    [self.titleLabel sizeToFit];
    [self.blurbLabel sizeToFit];
    
    
    CGFloat maxHeight = self.blurbLabel.frame.origin.y + self.blurbLabel.frame.size.height + 30;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, maxHeight);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTap:(UITapGestureRecognizer *)sender {
    NSLog(@"didtap");
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 
    
    TrailerViewController * detailsViewController = [segue destinationViewController];
    detailsViewController.movie = self.movie;
}


@end
