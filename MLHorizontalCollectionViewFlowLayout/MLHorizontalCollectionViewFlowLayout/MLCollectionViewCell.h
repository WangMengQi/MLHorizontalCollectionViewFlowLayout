//
//  MLCollectionViewCell.h
//  MLHorizontalCollectionViewFlowLayout
//
//  Created by Wang Mengqi on 17/2/20.
//  Copyright © 2017年 Wang Mengqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLCollectionViewCell : UICollectionViewCell

- (void)setText:(NSString *)text;

+ (CGSize)size:(NSString *)text;

@end
