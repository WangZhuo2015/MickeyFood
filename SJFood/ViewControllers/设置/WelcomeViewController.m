//
//  WelcomeViewController.m
//  SJFood
//
//  Created by 叶帆 on 14/12/7.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController
@synthesize welcomeScrollView,pageControl;
@synthesize welcomeImageArray;

#pragma mark - Gesture methods
- (void)swipeWithGesture:(UISwipeGestureRecognizer *)gesture
{
    if(self.welcomeScrollView.contentOffset.x >= (self.welcomeImageArray.count-1)*ScreenWidth)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showGuide
{
    [self.view addAnimationWithType:kCATransitionFade subtype:nil];
}

#pragma mark - UIViewController methods
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(IsDevicePhone6P)
    {
        self.welcomeImageArray = [NSArray arrayWithObjects:@"guidepage_1_736h@3x.png", @"guidepage_2_736h@3x.png",@"guidepage_3_736h@3x.png",@"guidepage_4_736h@3x.png", nil];
    }
    else if (IsDevicePhone6)
    {
        self.welcomeImageArray = [NSArray arrayWithObjects:@"guidepage_1_667h@2x.png", @"guidepage_2_667h@2x.png",@"guidepage_3_667h@2x.png",@"guidepage_4_667h@2x.png",nil];
    }
    else if (IsDevicePhone5)
    {
        self.welcomeImageArray = [NSArray arrayWithObjects:@"guidepage_1_568h@2x.png", @"guidepage_2_568h@2x.png",@"guidepage_3_568h@2x.png",@"guidepage_4_568h@2x.png",nil];
    }
    else
    {
        self.welcomeImageArray = [NSArray arrayWithObjects:@"guidepage_1_480h@2x.png", @"guidepage_2_480h@2x.png",@"guidepage_3_480h@2x.png",@"guidepage_4_480h@2x.png",nil];
    }
    
    NSInteger index = 0;
    for(NSString *imgName in self.welcomeImageArray)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(index*ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        imgView.image = [UIImage imageNamed:imgName];
        //imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.welcomeScrollView addSubview:imgView];
        index++;
    }
    [self.welcomeScrollView setContentSize:CGSizeMake(ScreenWidth*self.welcomeImageArray.count, 0)];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeWithGesture:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeGesture.delegate = self;
    [self.view addGestureRecognizer:swipeGesture];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - ScrollView Delegate Methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = floor((scrollView.contentOffset.x - ScreenWidth / 2) / ScreenWidth) + 1;
    self.pageControl.currentPage = page;
}

#pragma mark - Status bar methods
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
