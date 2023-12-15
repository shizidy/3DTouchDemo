//
//  MenuCollectionCell.h
//  3DTouchDemo
//
//  Created by wdyzmx on 2023/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN API_AVAILABLE(ios(13.0))
@interface MenuCollectionCell : UICollectionViewCell

@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *textLabel;

@end

NS_ASSUME_NONNULL_END
