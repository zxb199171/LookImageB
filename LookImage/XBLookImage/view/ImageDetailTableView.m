//
//  ImageDetailTableView.m
//  Hairdresser
//
//  Created by chk on 15/5/27.
//  Copyright (c) 2015年 chk. All rights reserved.
//

#import "ImageDetailTableView.h"

#import "PhotoScrollView.h"

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height

@implementation ImageDetailTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        //设置代理
        self.dataSource = self;
        self.delegate = self;
        
        //设置表视图的背景
        self.backgroundColor = [UIColor clearColor];

        //将当前表视图逆时针旋转90度
        self.transform = CGAffineTransformMakeRotation(-M_PI_2);
        
        //重新设置frame
        self.frame = frame;
        
        //设置行高
        self.rowHeight = ScreenWidth + 20;
        
        //取消滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        //开启分页效果
        self.pagingEnabled = YES;
        
    }
    return self;
}


//返回行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataLists.count;
    
}


//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        //将单元格的子视图顺时针旋转90度
        cell.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        cell.backgroundColor = [UIColor whiteColor];
        
        
        //PhotoScrollView  只是为了放大缩小的作用
        PhotoScrollView *photoScrollView = [[PhotoScrollView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth,ScreenHeight)];
        
        photoScrollView.tag = 100;
        photoScrollView.backgroundColor = [UIColor blackColor];
        [cell.contentView addSubview:photoScrollView];
        
        
    }
    
    
    //获取数据
    UIImage *imageName = self.dataLists[indexPath.row];
    
    //获取到子视图
    PhotoScrollView *photoScrollView =  (PhotoScrollView *)[cell.contentView viewWithTag:100];
    //将图片名称传递给滑动视图
    photoScrollView.imageName = imageName;
    
    //传递当前的行
    photoScrollView.row = (int)indexPath.row;
    //传递当前的表视图
    photoScrollView.tableView = self;
    
    indexPathRow=indexPath.row;
    
//    NSString *indexPathRowStr=[[NSString alloc]initWithFormat:@"%ld",(long)indexPathRow];
    
    if (self.imageDelegate)
        [self.imageDelegate updateImageCount:indexPathRow];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"editImage" object:self userInfo:@{@"name":indexPathRowStr}];
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}




@end
