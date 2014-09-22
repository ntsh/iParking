//
//  WFViewController.m
//  Express
//
//  Created by NG on 20/09/14.
//  Copyright (c) 2014 Neetesh Gupta. All rights reserved.
//

#import "WFViewController.h"

@interface WFViewController ()

@end

@implementation WFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View Did Load");
        //self.webView = [[UIWebView alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadWebPage:@"index"];
}

- (void)loadWebPage:(NSString*)page
{
    NSLog(@"Loading %@", page);
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:page ofType:@"html" inDirectory:@"codiqa 7"]];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    NSLog(@"Webview loaded");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(id)sender {
    NSLog(@"Show Alert");
    [self.webView stringByEvaluatingJavaScriptFromString:@"showAlert()"];
}
@end
