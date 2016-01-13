//
//  GoogleLoadingViewController.m
//  Animation
//
//  Created by Sailinghj on 16/1/12.
//  Copyright © 2016年 Sailinghj. All rights reserved.
//

#import "GoogleLoadingViewController.h"

@interface GoogleLoadingViewController ()
@property(nonatomic,strong) UIView *loadingView;
@property(nonatomic,strong) UIView *complexLoadingView;
@property(nonatomic,strong) CAShapeLayer *anotherOvalShapeLayer;
@property(nonatomic,strong) UIView *replicatorAnimationView;
@property(nonatomic,strong) UIView *activityIndicatorView;
@property(nonatomic,strong) UIView *gradientView;
@property(nonatomic,strong) UILabel *textLabel;
@end

@implementation GoogleLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    _loadingView = [[UIView alloc] initWithFrame:CGRectMake(20, 80, 280, 100)];
    _loadingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_loadingView];
    
    CAShapeLayer *ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    ovalShapeLayer.fillColor = [[UIColor clearColor] CGColor];
    ovalShapeLayer.lineWidth = 7;
    
    CGFloat ovalRadius = _loadingView.frame.size.height/2 * 0.8;
    ovalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_loadingView.frame.size.width/2 - ovalRadius, _loadingView.frame.size.height/2 - ovalRadius, ovalRadius * 2, ovalRadius * 2)].CGPath;
    ovalShapeLayer.strokeEnd = 0.4;  //笔画结束位置
    ovalShapeLayer.lineCap = kCALineCapRound;
    [_loadingView.layer addSublayer:ovalShapeLayer];
    
    
    _complexLoadingView = [[UIView alloc] initWithFrame:CGRectMake(20, 180, 280, 100)];
    _complexLoadingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_complexLoadingView];
    
    _anotherOvalShapeLayer = [CAShapeLayer layer];
    _anotherOvalShapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    _anotherOvalShapeLayer.fillColor = [[UIColor clearColor] CGColor];
    _anotherOvalShapeLayer.lineWidth = 7;
    
    CGFloat anotherOvalRadius = _complexLoadingView.frame.size.height/2 * 0.8;
    _anotherOvalShapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_complexLoadingView.frame.size.width/2 - anotherOvalRadius, _complexLoadingView.frame.size.height/2 - anotherOvalRadius, anotherOvalRadius * 2, anotherOvalRadius * 2)].CGPath;
    _anotherOvalShapeLayer.lineCap = kCALineCapRound;
    [_complexLoadingView.layer addSublayer:_anotherOvalShapeLayer];
    
    
    _replicatorAnimationView = [[UIView alloc] initWithFrame:CGRectMake(100, 280, 120, 100)];
    _replicatorAnimationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_replicatorAnimationView];
    
    _activityIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(100, 390, 120, 120)];
    _activityIndicatorView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_activityIndicatorView];
    
    _gradientView = [[UIView alloc] initWithFrame:CGRectMake(20, 510, 280, 80)];
    _gradientView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_gradientView];
    
    _textLabel = [[UILabel alloc] initWithFrame:_gradientView.bounds];
    _textLabel.attributedText = [[NSAttributedString alloc] initWithString:@"slide to unlock" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:30]}];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [_gradientView addSubview:_textLabel];
}

-(void)viewWillAppear:(BOOL)animated    {
    [self beginSimpleAnimation];
    [self beginComplexAnimation];
    [self firstReplicatorAnimation];
    [self activityIndicatorAnimation];
    [self gradientAnimation];
}

-(void)beginSimpleAnimation   {
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.duration = 1.5;
    rotate.fromValue = [NSNumber numberWithDouble:0.0];
    rotate.toValue = [NSNumber numberWithDouble:2 * M_PI];
    rotate.repeatCount = HUGE;
    [_loadingView.layer addAnimation:rotate forKey:nil];
}

-(void)beginComplexAnimation    {
    CABasicAnimation *strokeStartAnimate = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimate.fromValue = [NSNumber numberWithDouble:-0.5];
    strokeStartAnimate.toValue = [NSNumber numberWithDouble:1.0];
    
    CABasicAnimation *strokeEndAnimate = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimate.fromValue = [NSNumber numberWithDouble:0.0];
    strokeEndAnimate.toValue = [NSNumber numberWithDouble:1.0];
    
    CAAnimationGroup *strokeAnimateGroup = [[CAAnimationGroup alloc] init];
    strokeAnimateGroup.duration = 1.5;
    strokeAnimateGroup.repeatCount = HUGE;
    strokeAnimateGroup.animations = @[strokeStartAnimate, strokeEndAnimate];
    [_anotherOvalShapeLayer addAnimation:strokeAnimateGroup forKey:nil];
}

-(void)firstReplicatorAnimation {
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer new];
    replicatorLayer.bounds = CGRectMake(_replicatorAnimationView.frame.origin.x, _replicatorAnimationView.frame.origin.y, _replicatorAnimationView.frame.size.width, _replicatorAnimationView.frame.size.height);
    replicatorLayer.anchorPoint = CGPointMake(0, 0);
    replicatorLayer.backgroundColor = [[UIColor clearColor] CGColor];
    [_replicatorAnimationView.layer addSublayer:replicatorLayer];
    
    CALayer *rectangle = [CALayer layer];
    rectangle.bounds = CGRectMake(0, 0, 30, 90);
    rectangle.anchorPoint = CGPointMake(0, 0);
    rectangle.position = CGPointMake(_replicatorAnimationView.frame.origin.x + 10, _replicatorAnimationView.frame.origin.y + 90);
    rectangle.cornerRadius = 2;
    rectangle.backgroundColor = [[UIColor whiteColor] CGColor];
    [replicatorLayer addSublayer:rectangle];
    
    CABasicAnimation *moveRectangle = [CABasicAnimation animationWithKeyPath:@"position.y"];
    moveRectangle.toValue = [NSNumber numberWithDouble:rectangle.position.y - 70];
    moveRectangle.duration = 0.7;
    moveRectangle.autoreverses = YES;
    moveRectangle.repeatCount = HUGE;
    [rectangle addAnimation:moveRectangle forKey:nil];
    
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(35, 0, 0);
    replicatorLayer.instanceDelay = 0.3;
    replicatorLayer.masksToBounds = YES;
}

-(void)activityIndicatorAnimation   {
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, _activityIndicatorView.frame.size.width, _activityIndicatorView.frame.size.height);
    replicatorLayer.position = CGPointMake(_activityIndicatorView.frame.size.width/2, _activityIndicatorView.frame.size.height/2);
    replicatorLayer.backgroundColor = [[UIColor clearColor] CGColor];
    [_activityIndicatorView.layer addSublayer:replicatorLayer];
    
    CALayer *circle = [CALayer layer];
    circle.bounds = CGRectMake(0, 0, 15, 15);
    circle.position = CGPointMake(_activityIndicatorView.frame.size.width/2, _activityIndicatorView.frame.size.height/2 - 47.5);
    circle.cornerRadius = 7.5;
    circle.backgroundColor = [[UIColor whiteColor] CGColor];
    circle.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    [replicatorLayer addSublayer:circle];
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = [NSNumber numberWithInt:1];
    scale.toValue = [NSNumber numberWithDouble:0.1];
    scale.duration = 1;
    scale.repeatCount = HUGE;
    [circle addAnimation:scale forKey:nil];
    
    replicatorLayer.instanceCount = 15;
    CGFloat angle = 2 * M_PI / 15;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    replicatorLayer.instanceDelay = 1 / 15.0;
}

-(void)gradientAnimation    {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = CGRectMake(0, 0, _gradientView.frame.size.width, _gradientView.frame.size.height);
    gradientLayer.position = CGPointMake(_gradientView.frame.size.width/2, _gradientView.frame.size.height/2);
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    gradientLayer.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor whiteColor].CGColor, (id)[UIColor blackColor].CGColor];
    gradientLayer.locations = @[@0.2, @0.5, @0.8];
    [_gradientView.layer addSublayer:gradientLayer];
    
    CABasicAnimation *gradient = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradient.fromValue = @[@0, @0, @0.25];
    gradient.toValue = @[@0.75, @1, @1];
    gradient.duration = 2.5;
    gradient.repeatCount = HUGE;
    [gradientLayer addAnimation:gradient forKey:nil];
    
    gradientLayer.mask = _textLabel.layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
