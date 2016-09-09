//
//  TopScrollView.m
//  无限轮播
//
//  Created by 刘浩浩 on 16/6/12.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "TopScrollView.h"
#import "DataModel.h"
#import "UIImageView+WebCache.h"


@implementation TopScrollView
{
    UIScrollView *_mainScrollView;
    UILabel *contentLabel;
    UIImageView *currentImageView;
    NSInteger _currentIndex;
    NSMutableArray *_dataArray;
    UIView *pageSubView;
}
/*
 *初始化部件，添加点击手势和定时器
 */
-(instancetype)initWithDataArray:(NSMutableArray *)dataArray
{
    if (self=[super initWithFrame:CGRectMake(0, 64, WIDTH, 170)]) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 0, WIDTH, 170);
        _mainScrollView.contentSize = CGSizeMake(WIDTH*3, 170);
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.userInteractionEnabled=YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator=NO;
        _mainScrollView.bounces = NO;
        [_mainScrollView setContentOffset:CGPointMake(WIDTH, 0)];
        [self addSubview:_mainScrollView];
        _currentIndex = 0;
        _dataArray=[NSMutableArray arrayWithArray:dataArray];
      
        [self setUpWithDataArray:_dataArray];
        [self cretPageControlAndTitle];
        // 手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];

    }
    return self;
}
/*
 *创建标题和pageControl，此处pageCOntrol为自定义的，如需要可修改为系统的，或更换图片即可
 */
-(void)cretPageControlAndTitle
{
    contentLabel = [[UILabel alloc] init];
    contentLabel.frame = CGRectMake(0, self.frame.size.height-30, WIDTH, 30);
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.font=[UIFont systemFontOfSize:12];
    contentLabel.text = ((DataModel *)[_dataArray firstObject]).title;
    contentLabel.backgroundColor = [UIColor blackColor];
    contentLabel.textColor=[UIColor whiteColor];
    contentLabel.alpha=0.6;
    [self addSubview:contentLabel];
    
    pageSubView=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-30, WIDTH, 30)];
    pageSubView.backgroundColor=[UIColor clearColor];
    [self addSubview:pageSubView];

    for(int i=0;i<_dataArray.count;i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"News_Pic_Number02@2x.png"]];
        imageView.frame = CGRectMake(WIDTH-(_dataArray.count*12)-10+i*12, 11, 7, 7);
        if(i == 0)
        {
            imageView.image = [UIImage imageNamed:@"News_Pic_Number01@2x.png"];
        }
        [pageSubView addSubview:imageView];
        
    }

}
/*
 *定时器方法，使banner页无限轮播
 */
-(void)timerAction
{
    UIImageView *imageView = [pageSubView.subviews objectAtIndex:_currentIndex];
    imageView.image = [UIImage imageNamed:@"News_Pic_Number02@2x.png"];
    
    if (_currentIndex+1<_dataArray.count) {
        _currentIndex++;
    }
    else
    {
        _currentIndex=0;
    }
    [UIView animateWithDuration:1 animations:^{
        [_mainScrollView setContentOffset:CGPointMake(WIDTH*2, 0)];
    } completion:^(BOOL finished) {
        [_mainScrollView setContentOffset:CGPointMake(WIDTH, 0)];
        [self setUpWithDataArray:_dataArray];
    }];
    
    contentLabel.text = ((DataModel *)[_dataArray objectAtIndex:_currentIndex]).title;
    
    UIImageView *imageView1 = [pageSubView.subviews objectAtIndex:_currentIndex];
    imageView1.image = [UIImage imageNamed:@"News_Pic_Number01@2x.png"];
}

/*
 *此处为scrollView的复用，比目前网上大部分的同类型控件油画效果好，只需要三张图片依次替换即可实现轮播，不需要有几张图就使scrollView的contentSize为图片数＊宽度
 */
-(void)setUpWithDataArray:(NSArray *)dataArray
{
    for(UIView *view in _mainScrollView.subviews)
    {
        if([view isKindOfClass:[UIImageView class]])
            [view removeFromSuperview];
    }
    
    
    // 中间图
    currentImageView = [[UIImageView alloc] init];
    [currentImageView sd_setImageWithURL:[NSURL URLWithString:((DataModel *)[dataArray objectAtIndex:_currentIndex]).imgURL]];
    currentImageView.userInteractionEnabled=YES;
    currentImageView.frame = CGRectMake(WIDTH, 0, WIDTH, 170);
    [_mainScrollView addSubview:currentImageView];
    // 左侧图
    UIImageView *preImageView = [[UIImageView alloc] init];
    NSString *imageStr = _currentIndex-1>=0?((DataModel *)[dataArray objectAtIndex:_currentIndex-1]).imgURL:((DataModel *)[dataArray lastObject]).imgURL;
    preImageView.userInteractionEnabled=YES;
    [preImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    preImageView.frame = CGRectMake(0, 0, WIDTH, 170);
    [_mainScrollView addSubview:preImageView];
    // 右侧
    UIImageView *nextImageView = [[UIImageView alloc] init];
    nextImageView.userInteractionEnabled=YES;
    NSString *imageStr1 = _currentIndex+1<dataArray.count?((DataModel *)[dataArray objectAtIndex:_currentIndex+1]).imgURL:((DataModel *)[dataArray firstObject]).imgURL;
    [nextImageView sd_setImageWithURL:[NSURL URLWithString:imageStr1]];
    nextImageView.frame = CGRectMake(WIDTH*2, 0, WIDTH, 170);
    [_mainScrollView addSubview:nextImageView];
}
/*
 *图片的点击响应方法
 */
-(void)tapClick
{
    if ([self.delegate respondsToSelector:@selector(didClickScrollViewWithIndex:)]) {
        [self.delegate didClickScrollViewWithIndex:_currentIndex];
    }

}
/*
 *UIScrollViewDelegate  协议方法，拖动图片的处理方法
 */
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == _mainScrollView)
    {
        UIImageView *imageView = [pageSubView.subviews objectAtIndex:_currentIndex];
        imageView.image = [UIImage imageNamed:@"News_Pic_Number02@2x.png"];
        
        int index = scrollView.contentOffset.x/WIDTH;
        if(index>1)
        {
            _currentIndex = _currentIndex+1<_dataArray.count?_currentIndex+1:0;
            [UIView animateWithDuration:1 animations:^{
                [_mainScrollView setContentOffset:CGPointMake(WIDTH*2, 0)];
            } completion:^(BOOL finished) {
                [_mainScrollView setContentOffset:CGPointMake(WIDTH, 0)];
                [self setUpWithDataArray:_dataArray];
            }];        }
        else if(index<1)
        {
            _currentIndex = _currentIndex-1>=0?_currentIndex-1:_dataArray.count-1;
            [UIView animateWithDuration:1 animations:^{
                [_mainScrollView setContentOffset:CGPointMake(0, 0)];
            } completion:^(BOOL finished) {
                [_mainScrollView setContentOffset:CGPointMake(WIDTH, 0)];
                [self setUpWithDataArray:_dataArray];
            }];
        }
        else
            NSLog(@"没滚动不做任何操作");
        
        contentLabel.text = ((DataModel *)[_dataArray objectAtIndex:_currentIndex]).title;
        
        UIImageView *imageView1 = [pageSubView.subviews objectAtIndex:_currentIndex];
        imageView1.image = [UIImage imageNamed:@"News_Pic_Number01@2x.png"];
    }
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
