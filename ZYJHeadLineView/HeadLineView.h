
#import <UIKit/UIKit.h>
#import "ZYJHeadLineModel.h"

@class HeadLineView;

@protocol ZYJHeadLineViewDelegate <NSObject>

- (void)headLineViewClicked:(ZYJHeadLineModel *)model;

@end

@interface HeadLineView : UIView

@property (nonatomic,copy) void (^clickBlock)(NSInteger index);  //第几个数据被点击
@property (nonatomic, weak) id<ZYJHeadLineViewDelegate>delegate;

//数组内部数据需要是GBTopLineViewModel类型
- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr;

//停止定时器(界面消失前必须要停止定时器否则内存泄漏)
- (void)stopTimer;

@end
