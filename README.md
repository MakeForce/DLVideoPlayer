## 说明：
*  该播放器理论上支持6.0及其以上但6.0未测试，请测后再用
*  AVFoundation框架中的AVPlayer，所以需要使用的请在项目中加入AVFoundation框架
*  在全屏状态下在偏好文件中增加 key： View controller-based status bar appearance  value: NO
*  如果有其他的需求的话，请加群(151180718)说明，如果确实需要的人很多的话我在更新


## 资源：
*   在线资源来自**`车载MV`[http://www.mm123m.com](http://www.mm123m.com)**地址有效期很短，倘若无法使用，请自行前往该网站获取资源地址
*   在线资源来自**`盛大音乐`[http://www.sdyinyue.net](http://www.sdyinyue.net)**地址长期有效，跟多资源请自行获取
*   在线资源来自**`酷我音乐`[http://www.kuwo.cn](http://www.kuwo.cn)**地址长期有效，跟多资源请自行获取

## 更新(1.0.1)
***
- <font color="red">bug:</font>

    - 1、在以下设备中(4s、5c、5s、6、6p(其他未测，4s频率较高))发现播放器会导致应用crash，检查发现导致应用闪退的原因是内存不足，debug发现导致内存不足的原因：在设置videoUrl的时候，AVURLAsset被初始化，然后立即开始请求视频资源，当前视图消失后该数据流并未停止加载，也并未释放，再次进入有视频的视图的时候，又开加载在新的数据流，从而导致内存吃紧，当达到一定的程度的时候，应用就被kill了；
    - 2、crash是因为内存未释放引起的，导致内存未释放的原因是block循环引用、以及strong属性引起的；

- <font color="green">解决办法：</font>
    - 1、视频数据的加载移植开始播放事件(<font color="yellow">临时解决方法</font>);
    - 2、crash为题正式干掉

***

## 截图

![Alt Text](https://github.com/yin329039646/DLAVPlayer_Example/blob/master/DLAVPlayer/source/Iphone5C.gif)
