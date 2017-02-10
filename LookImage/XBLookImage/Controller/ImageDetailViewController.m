//
//  ImageDetailViewController.m
//  Hairdresser
//
//  Created by chk on 15/5/27.
//  Copyright (c) 2015年 chk. All rights reserved.
//

#import "ImageDetailViewController.h"

#import "ImageDetailTableView.h"

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height

@interface ImageDetailViewController ()<ImageDetailTableViewDelegate>
{
    UILabel *titleLabel;
    
    UIView *navigationView;
    
    NSInteger indexRow;
    
    NSInteger firstIndexRow;
    
    NSMutableArray *imageDataArry;
    
    
}



@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageDataArry=[NSMutableArray array];
    imageDataArry=[self.dataList mutableCopy];
    
    [self _initViews];

    navigationView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navigationView.backgroundColor=[UIColor colorWithWhite:50/255.0 alpha:0.9];
    
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(navigationView.frame.size.width/2.0-50, navigationView.frame.size.height/2.0-20, 100, 40)];
    titleLabel.text=@"图片";
    titleLabel.font=[UIFont systemFontOfSize:25];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.tintColor=[UIColor whiteColor];
    [navigationView addSubview:titleLabel];
    
    [self.view addSubview:navigationView];
    
    UIButton *backButton;
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 20, 60, 44);
    backButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(returnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backButton];
    
    
    UIButton *deleteBtn = [[UIButton alloc] init];
    deleteBtn.frame = CGRectMake(ScreenWidth-15-50, navigationView.frame.size.height/2.0-15, 60, 50);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:deleteBtn];
    
    
}

//初始化子视图
- (void)_initViews {
    
    _tableView = [[ImageDetailTableView alloc] initWithFrame:CGRectMake(-10, 0, ScreenWidth+20, ScreenHeight ) style:UITableViewStylePlain];
    _tableView.imageDelegate=self;
    _tableView.dataLists = imageDataArry;
    
    //设置背景颜色
    _tableView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_tableView];
    
    //让表视图滑动到指定的位置
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_tableView addGestureRecognizer:tap];
    
    firstIndexRow=self.index;
    
    indexRow=self.index;
    
    
}

//更新图片数量
-(void)updateImageCount:(NSInteger)count;{
    indexRow=count;
}

-(void)deleteBtnClick:(UIButton *)btn{
    
    if (imageDataArry.count<=0) {
        btn.hidden=YES;
        return;
    }else{
        btn.hidden=NO;
    }
    
    if (firstIndexRow==0) {
        
        if (self.imageDelegate) {
            [self.imageDelegate deleteImageWithIndexPathRow:indexRow];
        }
        
        [imageDataArry removeObjectAtIndex:0];
        _tableView.dataLists = imageDataArry;
        
        [_tableView reloadData];
        
    }else{
        
        if (self.imageDelegate) {
            [self.imageDelegate deleteImageWithIndexPathRow:indexRow];
        }
        
        [imageDataArry removeObjectAtIndex:indexRow];
        _tableView.dataLists = imageDataArry;
        
        [_tableView reloadData];
        
    }
    
}


- (void)returnBtnClick
{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}




#pragma mark - tap Action
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    
    navigationView.hidden= !navigationView.hidden;
    
}




@end
