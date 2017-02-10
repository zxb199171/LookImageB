//
//  ImageDetailTableView.h
//  Hairdresser
//
//  Created by chk on 15/5/27.
//  Copyright (c) 2015年 chk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageDetailTableViewDelegate <NSObject>

//跟新图片数量 方法
-(void)updateImageCount:(NSInteger)count;

@end

@interface ImageDetailTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger  indexPathRow;
    
}

@property(nonatomic,assign) id<ImageDetailTableViewDelegate> imageDelegate;

@property(nonatomic,retain)NSMutableArray *dataLists;  //设置一个数组

@end
