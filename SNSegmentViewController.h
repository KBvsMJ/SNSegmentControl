//
//  MJSegmentViewController.h
//  UISegmentWithViewControllerDemo
//
//  Created by MJ on 15/4/19.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 @brief  判断选择哪个分段器
 
 @param selectSegmentIndex 索引
 
 @since
 */
typedef void(^SelectSementCompleteHandler)(NSInteger selectSegmentIndex);
/**
 *  @brief   设置切换不同viewcontroller
 *
 *  @param arrViewCtl 保存viewController对象
 *  @param arrTitle   分段器的标题
 */

@interface SNSegmentViewController : UIViewController
{
    SelectSementCompleteHandler selectMySegmentHandler;
}
- (void)loadSetViewController :(NSArray *)arrViewCtl andSegementTitle :(NSArray *)arrTitle andCompleteHandler:(SelectSementCompleteHandler)selectSegmentHandler;


@end
