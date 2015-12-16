## 说明：
*  该播放器理论上支持6.0及其以上但6.0未测试，请测后再用
*  AVFoundation框架中的AVPlayer，所以需要使用的请在项目中加入AVFoundation框架
*  在全屏状态下在偏好文件中增加 key： View controller-based status bar appearance  value: NO

## 资源：
*   在线资源来自**`车载MV`[http://www.mm123m.com](http://www.mm123m.com)**地址有效期很短，倘若无法使用，请自行前往该网站获取资源地址
*   在线资源来自**`盛大音乐`[http://www.sdyinyue.net](http://www.sdyinyue.net)**地址长期有效，跟多资源请自行获取
*   在线资源来自**`酷我音乐`[http://www.kuwo.cn](http://www.kuwo.cn)**地址长期有效，跟多资源请自行获取

## 更新(0.0.1)
***
- <font color="red">bug:</font>

    - 1、crash是因为内存未释放引起的，导致内存未释放的原因是block循环引用、以及strong属性引起的；
    - 2、全屏播放时出现白边；

- <font color="green">解决办法：</font>
    - 1、crash问题已解决；
    - 2、播放背景全屏时设置为黑色；
- <font color="yellow">更新:</font>
	- 1、支持pod,使用方式：pod 'DLVideoPlayer', :git=> 'https://github.com/yin329039646/DLVideoPlayer.git'

***
## 联系作者
- QQ群：<a target="_blank" href="http://shang.qq.com/wpa/qunwpa?idkey=ea3facbb39310325902e7bbdf4de37392e49518476a58c5c0110352309be4887"><img border="0" src="http://pub.idqqimg.com/wpa/images/group.png" alt="IOS开发交流群" title="IOS开发交流群"></a>

## 截图

- ![Alt Text](https://github.com/yin329039646/DLAVPlayer_Example/blob/master/DLAVPlayer/source/Iphone5C.gif)
