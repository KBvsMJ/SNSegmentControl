//
//  MJSegmentViewController.m
//  UISegmentWithViewControllerDemo
//
//  Created by MJ on 15/4/19.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import "SNSegmentViewController.h"

@interface SNSegmentViewController ()

/**
 *  @brief 分段器选中加载对应的viewcontroller
 *
 */
@property(nonatomic,assign) UIViewController *selectedViewController;
/**
 *  @brief  用来标识分段器选中的索引
 *
 */
@property(nonatomic, assign) NSInteger selectedViewCtlWithIndex;

/**
 *  @brief 声明UISegmentedControl 分段器
 */
@property(nonatomic,strong) UISegmentedControl *segmentControl;
@end

@implementation SNSegmentViewController

#pragma mark - lifeCircle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createSegement];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


#pragma mark - private
/**
 *  @brief 创建分段器
 *
 */
- (void)createSegement
{
    if (!_segmentControl)
    {
        _segmentControl = [[UISegmentedControl alloc]init];
      //  _segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
        _segmentControl.layer.masksToBounds = YES ;
        _segmentControl.layer.cornerRadius = 3.0;
        
        _segmentControl.tintColor= [UIColor whiteColor];
        
        [_segmentControl setBackgroundImage:[UIImage imageNamed:@"ticket-54"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
         [_segmentControl setBackgroundImage:[UIImage imageNamed:@"ticket-55"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        self.navigationItem.titleView = _segmentControl;
    }
    else
    {
        [_segmentControl removeAllSegments];
    }
    [_segmentControl addTarget:self
                        action:@selector(selectedSegmentClick:)
                        forControlEvents:UIControlEventValueChanged];

}
- (void)loadSetViewController:(NSArray *)arrViewCtl andSegementTitle:(NSArray *)arrTitle andCompleteHandler:(SelectSementCompleteHandler)selectSegmentHandler
{
    selectMySegmentHandler = selectSegmentHandler;
    if ([_segmentControl numberOfSegments] > 0)
    {
        return;
    }
    for (int i = 0; i < [arrViewCtl count]; i++)
    {
        [self pushViewController:arrViewCtl[i] title:arrTitle[i]];
    }
    _segmentControl.frame = CGRectMake(0, 0, 200, 25);
    [_segmentControl setSelectedSegmentIndex:0];
    self.selectedViewCtlWithIndex = 0;



}
- (void)pushViewController:(UIViewController *)viewController title:(NSString *)title
{
    [_segmentControl insertSegmentWithTitle:title atIndex:_segmentControl.numberOfSegments animated:NO];
    [self addChildViewController:viewController];
    [_segmentControl sizeToFit];
}

- (void)setSelectedViewCtlWithIndex:(NSInteger)index
{
    if (!_selectedViewController)
    {
        _selectedViewController = self.childViewControllers[index];
        if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0f)
        {
            CGFloat fTop = 20.0f;
        if (self.navigationController && !self.navigationController.navigationBar.translucent)
            {
                fTop = self.navigationController.navigationBar.frame.size.height;
            }
            CGRect frame = self.view.frame;
            [_selectedViewController view].frame = CGRectMake(frame.origin.x, frame.origin.y - fTop, frame.size.width, frame.size.height);
           
        }
        else
        {
            [_selectedViewController view].frame = self.view.frame;
        }
        [self.view addSubview:[_selectedViewController view]];
        [_selectedViewController didMoveToParentViewController:self];
    }
    else
    {
        if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0f) {
            [self.childViewControllers[index] view].frame = self.view.frame;
        }
        [self transitionFromViewController:_selectedViewController toViewController:self.childViewControllers[index] duration:0.0f options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished)
         {
            _selectedViewController = self.childViewControllers[index];
            _selectedViewCtlWithIndex = index;
        }];
    }


}

#pragma mark - action
- (void)selectedSegmentClick:(id)sender
{
 self.selectedViewCtlWithIndex = _segmentControl.selectedSegmentIndex;
    if (selectMySegmentHandler)
    {
        selectMySegmentHandler(_segmentControl.selectedSegmentIndex);
    }
}

@end
