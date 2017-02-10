//
//  PhotoScrollView.m
//  Hairdresser
//
//  Created by chk on 15/5/27.
//  Copyright (c) 2015年 chk. All rights reserved.
//

#import "PhotoScrollView.h"

#import "ImageDetailTableView.h"

@implementation PhotoScrollView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建图片视图
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        //设置图片的填充样式
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        //设置代理
        self.delegate = self;
        
        //设置放大/缩小的倍数
        self.maximumZoomScale = 3.0;
        self.minimumZoomScale = 1.0;
        
        //创建双击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        //设置点击的数量
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
        
        
    }
    
    return self;
}


- (void)setImageName:(UIImage *)imageName {
    if (_imageName != imageName) {
        _imageName = [imageName copy];
        
        //填充数据
        //[_imageView sd_setImageWithURL:[NSURL URLWithString:_imageName]];
        
        _imageView.image=_imageName;
    }
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    if (self.zoomScale > 1) {
        [self setZoomScale:1 animated:YES];
    } else {
        [self setZoomScale:3 animated:YES];
    }
    
    
}

//指定对哪一个视图进行缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    float contentOffSet_x = self.contentSize.width - self.frame.size.width;
    NSLog(@"contentOffSet_x = %f",contentOffSet_x);
    NSLog(@"scrollView.contentOffset.x = %f",scrollView.contentOffset.x);
    
    float content_x = scrollView.contentOffset.x - contentOffSet_x;
    
    //拿到当前的行
    int currentRow = self.row;
    
    if (content_x > 30) {
        //向右滑动到下一单元格
        currentRow ++;
        
    } else if (scrollView.contentOffset.x < -30) {
        
        //向左滑动到上一个单元格
        currentRow --;  }
    
    if ((currentRow >=0 && currentRow < self.dataList.count) && (self.row !=currentRow)) {
        
        //滑动到指定的单元格
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentRow inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        //缩小当前的滑动视图
        [scrollView setZoomScale:1 animated:YES];
        
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}



@end
