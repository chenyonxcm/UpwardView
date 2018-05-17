
#import "HeadLineView.h"

@interface HeadLineView() {
    NSTimer *_timer;     //定时器
    int count;
    int flag; //标识当前是哪个view显示(currentView/hidenView)
    NSMutableArray *_dataArr;
}
@property (nonatomic,strong) UIView *currentView;   //当前显示的view
@property (nonatomic,strong) UIView *hidenView;     //底部藏起的view
@property (nonatomic,strong) UILabel *currentLabel;
@property (nonatomic,strong) UILabel *hidenLabel;
@end



@implementation HeadLineView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    count = 0;
    flag = 0;
    
    self.layer.masksToBounds = YES;
    
    //创建定时器
    [self createTimer];
    [self createCurrentView];
    [self createHidenView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealTap:)];
    [self addGestureRecognizer:tap];
}

- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    NSLog(@"dataArr-->%@",dataArr);
    ZYJHeadLineModel *model = _dataArr[count];
    self.currentLabel.text = model.title;
    NSLog(@"crash");
}

- (void)dealTap:(UITapGestureRecognizer *)tap {
    ZYJHeadLineModel *model = _dataArr[count];
    
    if ([self.delegate respondsToSelector:@selector(headLineViewClicked:)]) {
        [self.delegate headLineViewClicked:model];
    }
    
//    if (self.clickBlock) {
//        self.clickBlock(count);
//    }
}

- (void)createTimer
{
    _timer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
}

#pragma mark - 跑马灯操作
-(void)dealTimer
{
    count++;
    if (count == _dataArr.count) {
        count = 0;
    }
    
    if (flag == 1) {
        ZYJHeadLineModel *currentModel = _dataArr[count];
        self.currentLabel.text = currentModel.title;
    }
    
    if (flag == 0) {
        ZYJHeadLineModel *hienModel = _dataArr[count];
        self.hidenLabel.text = hienModel.title;
    }
    
    
    if (flag == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            flag = 1;
            self.currentView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.hidenView.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            flag = 0;
            self.hidenView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.width);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.currentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)createCurrentView
{
    ZYJHeadLineModel *model = _dataArr[count];
    
    self.currentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.currentView];
    
    //内容标题
    self.currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.frame.size.width, 24)];
    self.currentLabel.text = model.title;
    self.currentLabel.textAlignment = NSTextAlignmentLeft;
    self.currentLabel.textColor = [UIColor blackColor];
    self.currentLabel.font = [UIFont systemFontOfSize:12];
    [self.currentView addSubview:self.currentLabel];
}

- (void)createHidenView {
    self.hidenView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.hidenView];

    //内容标题
    self.hidenLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.frame.size.width, 24)];
    self.hidenLabel.text = @"";
    self.hidenLabel.textAlignment = NSTextAlignmentLeft;
    self.hidenLabel.textColor = [UIColor blackColor];
    self.hidenLabel.font = [UIFont systemFontOfSize:12];
    [self.hidenView addSubview:self.hidenLabel];
}

#pragma mark - 停止定时器
- (void)stopTimer {
    //停止定时器
    //在invalidate之前最好先用isValid先判断是否还在线程中：
    if ([_timer isValid] == YES) {
        [_timer invalidate];
        _timer = nil;
    }
}
@end
