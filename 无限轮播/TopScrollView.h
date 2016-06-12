//
//  TopScrollView.h
//  无限轮播
//
//  Created by 刘浩浩 on 16/6/12.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopScrollView;
@protocol TopScrollViewDelegate <NSObject>
/*
 *UIScrollViewDelegate  协议方法，把点击的图片的位置传给使用者
 */
-(void)didClickScrollViewWithIndex:(NSInteger)index;

@end

@interface TopScrollView : UIView<UIScrollViewDelegate>

@property (weak,nonatomic) id<TopScrollViewDelegate>delegate;
/*
 *初始化scrollView及其部件
 */
-(instancetype)initWithDataArray:(NSMutableArray *)dataArray;

@end
