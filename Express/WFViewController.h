//
//  WFViewController.h
//  Express
//
//  Created by NG on 20/09/14.
//  Copyright (c) 2014 Neetesh Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)showAlert:(id)sender;
- (void)loadWebPage:(NSString*)page;

@end
