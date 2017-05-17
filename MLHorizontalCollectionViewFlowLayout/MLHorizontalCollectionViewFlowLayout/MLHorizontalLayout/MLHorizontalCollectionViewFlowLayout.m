//
//  MLHorizontalCollectionViewFlowLayout.m
//  MLHorizontalCollectionViewFlowLayout
//
//  Created by Wang Mengqi on 17/2/20.
//  Copyright © 2017年 Wang Mengqi. All rights reserved.
//

#import "MLHorizontalCollectionViewFlowLayout.h"

@implementation MLHorizontalCollectionViewFlowLayout

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *superAttribute = [[NSMutableArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    NSMutableDictionary *rowCollections = [NSMutableDictionary new];
    id<UICollectionViewDelegateFlowLayout> flowDelegate = (id<UICollectionViewDelegateFlowLayout>)[self.collectionView delegate];
    BOOL delegateSupportsInteritemSpacing = [flowDelegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)];
    BOOL delegateSupportsSectionInset = [flowDelegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)];
    for (UICollectionViewLayoutAttributes *itemAttributes in superAttribute) {
        CGFloat midYRound = roundf(CGRectGetMidY(itemAttributes.frame));
        CGFloat midYPlus = midYRound + 1;
        CGFloat midYMinus = midYRound - 1;
        NSNumber *key;
        if (rowCollections[@(midYPlus)])
            key = @(midYPlus);
        
        if (rowCollections[@(midYMinus)])
            key = @(midYMinus);
        
        if (!key)
            key = @(midYRound);
        
        if (!rowCollections[key])
            rowCollections[key] = [NSMutableArray new];
        
        [(NSMutableArray *) rowCollections[key] addObject:itemAttributes];
    }
    
    CGFloat collectionViewWidth = [self collectionViewContentWidth];
    [rowCollections enumerateKeysAndObjectsUsingBlock:^(id key, NSArray *itemAttributesCollection, BOOL *stop) {
        NSInteger itemsInRow = [itemAttributesCollection count];
        CGFloat interitemSpacing = [self minimumInteritemSpacing];
        if (delegateSupportsInteritemSpacing && itemsInRow > 0) {
            NSUInteger section = [[itemAttributesCollection[0] indexPath] section];
            interitemSpacing = [flowDelegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
        }
        UIEdgeInsets sectionInsets = [self sectionInset];
        if (delegateSupportsSectionInset) {
            NSUInteger section = [[itemAttributesCollection[0] indexPath] section];
            sectionInsets = [flowDelegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        }
        //计算出总间隔
        CGFloat aggregateInteritemSpacing = interitemSpacing * (itemsInRow - 1);
        //计算每行所有item的宽度
        CGFloat aggregateItemWidths = 0.f;
        for (UICollectionViewLayoutAttributes *itemAttributes in itemAttributesCollection) {
            aggregateItemWidths += CGRectGetWidth(itemAttributes.frame);
        }
        //间隔和item的总宽度
        CGFloat alignmentWidth = aggregateItemWidths + aggregateInteritemSpacing;
        CGFloat alignmentXOffset = 0.0;
        //算出每行第一个item的偏移量
        if (_horizonalType == MLHorizonalLeft) {
            alignmentXOffset = sectionInsets.left;
        }else if (_horizonalType == MLHorizonalCenter){
            alignmentXOffset = (collectionViewWidth - alignmentWidth) / 2.0;
        }else if (_horizonalType == MLHorizonalRight){
            alignmentXOffset = collectionViewWidth - alignmentWidth - sectionInsets.right;
        }
        CGRect previousFrame = CGRectZero;
        for (UICollectionViewLayoutAttributes *itemAttributes in itemAttributesCollection) {
            CGRect itemFrame = itemAttributes.frame;
            if (CGRectEqualToRect(previousFrame, CGRectZero)) {
                itemFrame.origin.x = alignmentXOffset;
            }else{
                itemFrame.origin.x = CGRectGetMaxX(previousFrame) + interitemSpacing;
            }
            itemAttributes.frame = itemFrame;
            previousFrame = itemFrame;
        }
        
    }];
    return superAttribute;
}

- (CGFloat)collectionViewContentWidth
{
    return CGRectGetWidth(self.collectionView.bounds) - self.collectionView.contentInset.left - self.collectionView.contentInset.right;;
}

- (CGSize)collectionViewContentSize
{
    CGSize size = [super collectionViewContentSize];
    return size;
}

@end
