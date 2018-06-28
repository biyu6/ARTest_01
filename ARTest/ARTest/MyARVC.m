//
//  MyARVC.m
//  ARTest
//
//  Created by 胡忠诚 on 2018/6/28.
//  Copyright © 2018年 biyu6. All rights reserved.
//

#import "MyARVC.h"
#import <ARKit/ARKit.h>//ARKit框架

@interface MyARVC ()
//AR视图：展示3D界面
@property(nonatomic,strong)ARSCNView *sceneView;
//AR会话：负责管理相机追踪配置及3D相机坐标
@property(nonatomic,strong)ARSession *arSession;
//会话追踪配置：负责追踪相机的运动
@property(nonatomic,strong)ARConfiguration *arConfiguration;

@end
@implementation MyARVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addARSceneView];
    [self addGoBackBtn];
}
- (void)addARSceneView{//添加AR视图
    //将AR视图添加到当前视图
    [self.view addSubview:self.sceneView];
    //开启AR会话（此时相机开始工作）
    [self.arSession runWithConfiguration:self.arConfiguration];
}
- (void)addGoBackBtn{//添加一个返回按钮
    UIButton *goBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 25, 35, 35)];
    [goBackBtn setImage:[UIImage imageNamed:@"AR_Back"] forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(goBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBackBtn];
}
- (void)goBackBtnClick{//返回
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //暂停ARSession会话
    [self.sceneView.session pause];
    NSLog(@"AR场景已暂停");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%@======内存警告",[NSString stringWithUTF8String:object_getClassName(self)]);
}
- (void)dealloc{
    NSLog(@"%@======已释放",[NSString stringWithUTF8String:object_getClassName(self)]);
}

#pragma mark- 点击屏幕添加飞机
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //使用场景加载scn文件（scn格式文件是一个基于3D建模的文件，使用3DMax软件可以创建）
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];//加载该目录下的3D飞机
    //获取飞机节点（一个场景有且只有一个根节点，但会有多个子节点）
    SCNNode *shipNode = scene.rootNode.childNodes[0];
    shipNode.position = SCNVector3Make(0, -1, -1);//调整x、y、z坐标相对于世界原点，也就是相机位置
    //将飞机节点添加到当前屏幕中
    [self.sceneView.scene.rootNode addChildNode:shipNode];
}

#pragma mark- 懒加载搭建AR界面
- (ARSCNView *)sceneView{//创建AR视图
    if (_sceneView == nil) {
        //创建AR视图
        _sceneView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
        //设置视图会话
        _sceneView.session = self.arSession;
        //自动刷新灯光，默认就是YES
        _sceneView.automaticallyUpdatesLighting = YES;
    }
    return _sceneView;
}
- (ARSession *)arSession{//创建AR会话
    if(_arSession == nil){
        _arSession = [[ARSession alloc] init];
    }
    return _arSession;
}
- (ARConfiguration *)arConfiguration{//AR追踪配置
    if (_arConfiguration == nil) {
        //创建追踪会话配置(A9芯片以上)
        ARWorldTrackingConfiguration *configuration = [[ARWorldTrackingConfiguration alloc] init];
        //设置追踪方向（水平、垂直）
        configuration.planeDetection = ARPlaneDetectionHorizontal;
        _arConfiguration = configuration;
        //自适应灯光（相机从暗到强光快速过渡效果会平缓一些）
        _arConfiguration.lightEstimationEnabled = YES;
    }
    return _arConfiguration;
}


@end
