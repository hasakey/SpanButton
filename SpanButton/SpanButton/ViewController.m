//
//  ViewController.m
//  SpanButton
//
//  Created by 丁巍巍 on 2019/1/29.
//  Copyright © 2019年 丁巍巍. All rights reserved.
//

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define BUTTON_HEIGHT 66
#define BUTTON_WIDTH  66

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)UIButton *spButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建可拖动、自动贴近边缘的 事件上报按钮
    [self initAddEventBtn];
    
}


-(void)initAddEventBtn{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-71,300,BUTTON_HEIGHT,BUTTON_HEIGHT)];
    btn.backgroundColor = [UIColor redColor];
    btn.tag = 0;
    btn.layer.cornerRadius = 8;
    [self.view addSubview:btn];
    self.spButton = btn;
    [_spButton addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
    //添加手势
    UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [panRcognize setMinimumNumberOfTouches:1];
    [panRcognize setEnabled:YES];
    [panRcognize delaysTouchesEnded];
    [panRcognize cancelsTouchesInView];
    [btn addGestureRecognizer:panRcognize];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    //移动状态
    UIGestureRecognizerState recState =  recognizer.state;
    
    switch (recState) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.navigationController.view];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint stopPoint = CGPointMake(0, SCREEN_HEIGHT / 2.0);
            
            if (recognizer.view.center.x < SCREEN_WIDTH / 2.0) {
                if (recognizer.view.center.y <= SCREEN_HEIGHT/2.0) {
                    //左上
                    //                    if (recognizer.view.center.x  >= recognizer.view.center.y) {
                    //                        stopPoint = CGPointMake(recognizer.view.center.x, self.spButton.frame.size.width/2.0);
                    //                    }else{
                    stopPoint = CGPointMake(self.spButton.frame.size.width/2.0, recognizer.view.center.y);
                    //                    }
                }else{
                    //左下
                    //                    if (recognizer.view.center.x  >= SCREEN_HEIGHT - recognizer.view.center.y) {
                    //                        stopPoint = CGPointMake(recognizer.view.center.x, SCREEN_HEIGHT - self.spButton.frame.size.width/2.0);
                    //                    }else{
                    stopPoint = CGPointMake(self.spButton.frame.size.width/2.0, recognizer.view.center.y);
                    //                    }
                }
            }else{
                if (recognizer.view.center.y <= SCREEN_HEIGHT/2.0) {
                    //右上
                    //                    if (SCREEN_WIDTH - recognizer.view.center.x  >= recognizer.view.center.y) {
                    //                        stopPoint = CGPointMake(recognizer.view.center.x, self.spButton.frame.size.width/2.0);
                    //                    }else{
                    stopPoint = CGPointMake(SCREEN_WIDTH - self.spButton.frame.size.width/2.0, recognizer.view.center.y);
                    //                    }
                }else{
                    //右下
                    //                    if (SCREEN_WIDTH - recognizer.view.center.x  >= SCREEN_HEIGHT - recognizer.view.center.y) {
                    //                        stopPoint = CGPointMake(recognizer.view.center.x, SCREEN_HEIGHT - self.spButton.frame.size.width/2.0);
                    //                    }else{
                    stopPoint = CGPointMake(SCREEN_WIDTH - self.spButton.frame.size.width/2.0,recognizer.view.center.y);
                    //                    }
                }
            }
            
            //如果按钮超出屏幕边缘
            if (stopPoint.y + self.spButton.frame.size.width+40>= SCREEN_HEIGHT) {
                stopPoint = CGPointMake(stopPoint.x, SCREEN_HEIGHT - self.spButton.frame.size.width/2.0-49);
                NSLog(@"超出屏幕下方了！！"); //这里注意iphoneX的适配。。X的SCREEN高度算法有变化。
            }
            if (stopPoint.x - self.spButton.frame.size.width/2.0 <= 0) {
                stopPoint = CGPointMake(self.spButton.frame.size.width/2.0, stopPoint.y);
            }
            if (stopPoint.x + self.spButton.frame.size.width/2.0 >= SCREEN_WIDTH) {
                stopPoint = CGPointMake(SCREEN_WIDTH - self.spButton.frame.size.width/2.0, stopPoint.y);
            }
            if (stopPoint.y - self.spButton.frame.size.width/2.0 <= 0) {
                stopPoint = CGPointMake(stopPoint.x, self.spButton.frame.size.width/2.0);
            }
            
            [UIView animateWithDuration:0.3 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
            break;
            
        default:
            break;
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}


-(void)addEvent:(UIButton *)button{
    
}

@end
