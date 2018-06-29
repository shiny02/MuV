//
//  TrailerViewController.m
//  MuV
//
//  Created by Youngmin Shin on 6/28/18.
//  Copyright © 2018 Youngmin Shin. All rights reserved.
//

#import "TrailerViewController.h"
#import <WebKit/WebKit.h>
@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *trailerView;
@property (weak, nonatomic) IBOutlet UIButton *goBack;
@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    id tID = self.movie[@"id"];
    
    NSString * trailerID = [tID stringValue];
    NSString *baseURLString = @"https://api.themoviedb.org/3/movie/";
    //NSString * trailerID = [NSString stringWithFormat:@"%d", ttID];
    
    NSString *idTrailerURLString = [baseURLString stringByAppendingString:trailerID];
    
    NSString *fullTrailerURLString = [idTrailerURLString stringByAppendingString:@"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"];
    
    NSURL * url = [NSURL URLWithString:fullTrailerURLString];
    
    
    //NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot access movies" message:@"There doesn't seem to be a stable Internet connection." preferredStyle:(UIAlertControllerStyleAlert)];

            [self presentViewController:alert animated:YES completion:^{
            }];
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *trailerDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@", trailerDictionary);
            
            NSDictionary * trailers = trailerDictionary[@"results"][0];
            
            NSString * trailerKey = trailers[@"key"];
            
            NSString * youtubeLink = @"https://www.youtube.com/watch?v=";
            
            NSString *fullYoutubeLink = [youtubeLink stringByAppendingString:trailerKey];
            
            // Convert the url String to a NSURL object.
            NSURL *videoURL = [NSURL URLWithString:fullYoutubeLink];
            
            // Place the URL in a URL Request.
            NSURLRequest *request = [NSURLRequest requestWithURL:videoURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
            // Load Request into WebView.
            [self.trailerView loadRequest:request];
            
            
        }
        
        //[self.refreshControl endRefreshing];
    }];
    [task resume];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onGoBackTap:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){NSLog(@"Goodbye");}];
    
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
