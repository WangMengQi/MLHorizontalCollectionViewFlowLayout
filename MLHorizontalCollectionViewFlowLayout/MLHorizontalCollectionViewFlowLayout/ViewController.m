//
//  ViewController.m
//  MLHorizontalCollectionViewFlowLayout
//
//  Created by Wang Mengqi on 17/2/20.
//  Copyright © 2017年 Wang Mengqi. All rights reserved.
//

#import "ViewController.h"
#import "MLHorizontalCollectionViewFlowLayout.h"
#import "MLCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSArray *_dataSource;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataSource = @[@"你好", @"设计图", @"新疆维吾尔族自治区", @"美好明天", @"一切都会好起来", @"心情美丽", @"下班", @"上课", @"设计模式", @"重构", @"iOS开发", @"视频下载速度", @"巨人的陨落", @"今天", @"哈哈"];
    
    MLHorizontalCollectionViewFlowLayout *layout = [[MLHorizontalCollectionViewFlowLayout alloc]init];
    layout.horizonalType = MLHorizonalLeft;
    layout.minimumInteritemSpacing = 5.0;
    layout.sectionInset = UIEdgeInsetsMake(20.0, 10.0, 20.0, 10.0);
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[MLCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setText:_dataSource[indexPath.item]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [MLCollectionViewCell size:_dataSource[indexPath.item]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
