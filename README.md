## QRCodeScanner
使用iOS原生框架AVFoundation实现扫描二维码和生成二维码图片，基于iOS8+

### 使用方法
pod 'QRCodeScanner', :git => "https://github.com/mrarronz/QRCodeScanner.git"


使用时只需要使创建的viewController继承于QRScannerViewController，然后重写几个方法即可

```swift
override func customStyle() -> QRScannerStyle! {
    let style = QRScannerStyle.init()
    style.isNeedShowRectangle = true
    style.angleLineLength = 40
    style.angleColor = UIColor.init(red: 0, green: 0.6, blue: 0.9, alpha: 1.0)
    style.noneRecognizeColor = UIColor.black.withAlphaComponent(0.6)
    style.rectangleBorderColor = UIColor.white
    style.verticalOffset = 0
    style.marginOffset = 300  
    return style
}
    
override func rectOfInterest() -> CGRect {
    return QRScannerHelper.getInterestRect(in: self.view, style: self.customStyle())
}

// MARK: - handle result
override func handleScanResult() {
    // 在这里处理扫描的结果，扫描结果可以通过scanResult获得
}
```

### 获取相机和相册的权限
在iOS10以上，app如果使用相机相册麦克风等权限都需要在info.plist文件中进行隐私配置，设置相应的授权提示文字。这里建议主动获取系统授权，使用requestAccessForMediaType:completionHandler:方法获取相机权限，根据用户的选择做出响应，同样可以使用PHPhotoLibrary中的requestAuthorization:方法获取相册权限。默认情况下我们在初次使用相机或者相册时系统会弹窗提示，我们主动获取权限的好处在于：

1、可以自己控制什么时候需要获取这些隐私权限，给出自定义的弹窗提示，交互更加友好，给用户更好的注重隐私的感觉

2、逻辑判断和操作更加顺畅，不会出现重复弹窗提醒的情况（初次使用系统弹一次，自己的判断代码又弹一次）


### 扫码的识别区域rectOfInterest的计算
假定扫描区域的frame为scanRect，在iPhone上竖屏的时候计算方法：

```objective-c
CGFloat x = CGRectGetMinY(scanRect)/CGRectGetHeight(self.view.bounds);
CGFloat y = CGRectGetMinX(scanRect)/CGRectGetWidth(self.view.bounds);
CGFloat w = CGRectGetHeight(scanRect)/CGRectGetHeight(self.view.bounds);
CGFloat h = CGRectGetWidth(scanRect)/CGRectGetWidth(self.view.bounds);
CGRect interestRect = CGRectMake(x, y, w, h);
```

横屏的时候：

```objective-c
CGFloat x = CGRectGetMinX(scanRect)/CGRectGetWidth(self.view.bounds);
CGFloat y = CGRectGetMinY(scanRect)/CGRectGetHeight(self.view.bounds);
CGFloat w = CGRectGetWidth(scanRect)/CGRectGetWidth(self.view.bounds);
CGFloat h = CGRectGetHeight(scanRect)/CGRectGetHeight(self.view.bounds);
CGRect interestRect = CGRectMake(x, y, w, h);
```





