
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define kMidViewWidth   250
#define kMidViewHeight  34

#import "ViewController.h"
#import "ZYJHeadLineModel.h"
#import "HeadLineView.h"

@interface ViewController ()<ZYJHeadLineViewDelegate>
@property(nonatomic,strong)NSMutableArray*dataArr;
@property (nonatomic,strong) HeadLineView *TopLineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    self.view.backgroundColor =[UIColor lightGrayColor];
    [self createTopLineView];
    [self getData];
}

#pragma mark-创建头条视图
-(void)createTopLineView{
    
    _TopLineView = [[HeadLineView alloc]initWithFrame:CGRectMake(0, 0, kMidViewWidth, kMidViewHeight)];
    _TopLineView.delegate = self;
    _TopLineView.backgroundColor = [UIColor grayColor];
    _TopLineView.center = CGPointMake(ScreenWidth/2.0, ScreenHeight/2.0-150);
    [self.view addSubview:_TopLineView];
//    __weak typeof(self) weakSelf = self;
//    _TopLineView.clickBlock = ^(NSInteger index) {
//        ZYJHeadLineModel *model = weakSelf.dataArr[index];
//        NSLog(@"%@",model.title);
//    };
}

#pragma mark-获取数据
- (void)getData
{
    ZYJHeadLineModel *model1 = [[ZYJHeadLineModel alloc] init];
    model1.title = @"大降价了啊";
    [_dataArr addObject:model1];
    ZYJHeadLineModel *model2 = [[ZYJHeadLineModel alloc] init];
    model2.title = @"iPhone7分期";
    [_dataArr addObject:model2];
    ZYJHeadLineModel *model3 = [[ZYJHeadLineModel alloc] init];
    model3.title = @"i这个苹果蛮脆的";
    [_dataArr addObject:model3];

    [_TopLineView setVerticalShowDataArr:_dataArr];
}

#pragma mark - ZYJHeadLineViewDelegate
- (void)headLineViewClicked:(ZYJHeadLineModel *)model {
    NSLog(@"%@",model.title);
}
@end
