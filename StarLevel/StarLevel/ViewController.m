//
//  ViewController.m
//  StarLevel
//
//  Created by xialan on 2018/12/19.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "ViewController.h"
#import "SDStarLevelView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SDStarLevelView *view = [[SDStarLevelView alloc] initWithFrame:CGRectMake(200, 100, 100, 30) starCount:5 currentStar:3 style:SDStarLevelStyleCustom isAnimation:YES complete:^(CGFloat currentCount) {
        
//        NSLog(@"%lf",currentCount);
    }];
    
    view.callback = ^(CGFloat currentCount) {
         NSLog(@"%lf",currentCount);
    };
    
    [self.view addSubview:view];
}


@end
