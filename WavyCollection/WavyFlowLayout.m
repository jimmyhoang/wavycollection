//
//  WavyFlowLayout.m
//  WavyCollection
//
//  Created by Jimmy Hoang on 2017-06-15.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

#import "WavyFlowLayout.h"
@interface WavyFlowLayout()

@property (nonatomic, strong)NSArray* layoutAttributes;

@end

@implementation WavyFlowLayout


-(void)prepareLayout {
    long numberOfCells = [self.collectionView numberOfItemsInSection:0];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(100, 50);
    
    // Set minimum interitem spacing to be huge to force all items to be on their own line
    self.minimumInteritemSpacing = CGFLOAT_MAX;
    
    NSMutableArray* layoutAttributes = [[NSMutableArray alloc] init];
    
    for (int i = 0;i < numberOfCells;i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGFloat randomY = arc4random_uniform([UIScreen mainScreen].bounds.size.height - 100);
        CGFloat x = (100 + 10) * (i % 10);
        CGFloat height = self.itemSize.height + (randomY * .5);
        
        attributes.frame = CGRectMake(x, randomY, 100, height);
        
        [layoutAttributes addObject:attributes];
    }
    self.layoutAttributes = layoutAttributes;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes*>* newAttrs = [[NSMutableArray alloc] init];
    
    for (UICollectionViewLayoutAttributes* attribute in self.layoutAttributes) {
        if (CGRectIntersectsRect(attribute.frame, rect) == YES) {
            [newAttrs addObject:attribute];
        }
    }

    return newAttrs;
}

@end
