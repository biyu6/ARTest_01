
### 纯代码集成AR进项目示例代码
#### 注意：支持AR的苹果设备有： iPhone SE、iPhone 6s、iPhone 6s Plus、iPhone 7、iPhone 7 Plus、iPad Pro (所有型号)、9.7英寸iPad(2017款)。

#### 先在info.plist中添加相机的访问权限，然后需要导入一个目录文件：art.scnassets/ship.scn

```
- (void)addARSceneView{//添加AR视图
    //将AR视图添加到当前视图
    [self.view addSubview:self.sceneView];
    //开启AR会话（此时相机开始工作）
    [self.arSession runWithConfiguration:self.arConfiguration];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //暂停ARSession会话
    [self.sceneView.session pause];
    NSLog(@"AR场景已暂停");
}

```

![image](https://github.com/biyu6/ARTest_01/blob/master/ARShowHow.PNG)
