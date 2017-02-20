//
//  MLHorizontalCollectionViewFlowLayout.h
//  MLHorizontalCollectionViewFlowLayout
//
//  Created by Wang Mengqi on 17/2/20.
//  Copyright © 2017年 Wang Mengqi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum MLHorizonalType : NSInteger MLHorizonalType;
enum MLHorizonalType :NSInteger {
    MLHorizonalCenter = 0,
    MLHorizonalLeft = 1,
    MLHorizonalRight = 2,
};

@interface MLHorizontalCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) MLHorizonalType horizonalType;

@end
