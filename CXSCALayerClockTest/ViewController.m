//
//  ViewController.m
//  CXSCALayerClockTest
//
//  Created by 陈新爽 on 2022/7/4.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *backgroundHand;
@property (nonatomic, strong) UIImageView *hourHand;
@property (nonatomic, strong) UIImageView *minuteHand;
@property (nonatomic, strong) UIImageView *secondHand;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDefaultInfo];
    [self addAllUISubviews];
    [self layoutAllUI];
}

- (void)initDefaultInfo {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
//        [self tick];
}

- (void)addAllUISubviews {
    [self.view addSubview:self.backgroundHand];
    [self.view addSubview:self.hourHand];
    [self.view addSubview:self.minuteHand];
    [self.view addSubview:self.secondHand];
}

- (void)layoutAllUI {
    //布局不好布置
    self.backgroundHand.frame = CGRectMake(0, 50, 414, 414);
    self.hourHand.frame = CGRectMake(192, 157, 30, 100);
    self.minuteHand.frame = CGRectMake(192, 157, 30, 100);
    self.secondHand.frame = CGRectMake(192, 157, 30, 100);
}


- (void)tick
{
    //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //获取时间
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    //计算角度
    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
    //calculate hour hand angle //calculate minute hand angle
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    //calculate second hand angle
    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
    
    //旋转角度实现
    self.hourHand.transform = CGAffineTransformMakeRotation(hoursAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minsAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secsAngle);
}

#pragma mark - setter & getter
- (UIImageView *)backgroundHand {
    if(!_backgroundHand){
        _backgroundHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock"]];
    }
    return _backgroundHand;
}

- (UIImageView *)hourHand {
    if(!_hourHand){
        _hourHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hours"]];
        //设置锚点
        _hourHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    }
    return _hourHand;
}

- (UIImageView *)minuteHand {
    if(!_minuteHand){
        _minuteHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minutes"]];
        //设置锚点
        _minuteHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    }
    return _minuteHand;
}

- (UIImageView *)secondHand {
    if(!_secondHand){
        _secondHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconds"]];
        //设置锚点
        _secondHand.layer.anchorPoint = CGPointMake(0.5f, 0.9f);
    }
    return _secondHand;
}

@end
