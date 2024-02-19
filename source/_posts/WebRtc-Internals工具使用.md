---
title: WebRtc Internals工具使用
date: 2024-02-19 13:56:05
tags: 音视频
categories: 前端
---

> 以chrome浏览器来说明，在地址栏输入chrome://webrtc-internals/即可打开调试工具

![image-20220125103700660](WebRtc Internals工具使用/image-20220125103700660.png)

## Create Dump（保存日志）

可以将该页面的log数据进行本地化存储，方便分享和留档。

## Read Stats From（读取状态日志）

WebRTC读取状态日志分为2中：

- Standardized：符合W3C的新标准，基于promise模式
- Legacy Non-Standard：废弃的google定义的旧标准，基于callback模式

![截屏2022-01-25 上午10.49.46](WebRtc Internals工具使用/截屏2022-01-25 上午10.49.46.png)

## GetUserMedia Requests（GetUserMedia调用日志）

getUserMedia是浏览器获取用户本地摄像头和麦克风的接口，具体使用方法：`navigator.mediaDevices.getUserMedia`。GetUserMedia Requests的Tab中可以看到近期调用这个api的记录，每调用一次就会多一条。

![image-20220125110844187](WebRtc Internals工具使用/image-20220125110844187.png)

## RTCPeerConnection（监控信息）

除了GetUserMedia Requests，其他Tab每一个都对应一个PeerConnection对象。

![image-20220125111712303](WebRtc Internals工具使用/image-20220125111712303.png)

![image-20220125111731747](WebRtc Internals工具使用/image-20220125111731747.png)

#### 构造PeerConnection实例的参数

最上面圈起来的那块是构造PeerConnection的参数配置

#### PeerConnection事件

- addTrack（建立音频轨道）

![image-20220125113409121](WebRtc Internals工具使用/image-20220125113409121.png)

- createOffer（生成offer）

  ![image-20220125113538013](WebRtc Internals工具使用/image-20220125113538013.png)

- setLocalDescription（设置local sdp）

  ![image-20220125143155721](WebRtc Internals工具使用/image-20220125143155721.png)

- iceconnectionstatechange（ICE的连接状态发生变化）

  ![image-20220125165024993](WebRtc Internals工具使用/image-20220125165024993.png)

- connectionstatechange（PeerConnection的连接状态发生变化）

  ![image-20220125165043733](WebRtc Internals工具使用/image-20220125165043733.png)

- icecandidate（收集本地的candidate）

  ![image-20220125164803760](WebRtc Internals工具使用/image-20220125164803760.png)

- setRemoteDescription（设置remote sdp）

  ![image-20220125162500220](WebRtc Internals工具使用/image-20220125162500220.png)

- signalingstatechange（信令状态的回调）

  ![image-20220125164612639](WebRtc Internals工具使用/image-20220125164612639.png)

  ![image-20220125164622944](WebRtc Internals工具使用/image-20220125164622944.png)

- addIceCandidate（将对端的candidate添加到PeerConnection中）

  ![image-20220125163342091](WebRtc Internals工具使用/image-20220125163342091.png)

- 如果出现error也可以在Event这块看到：

![image-20220125162859189](WebRtc Internals工具使用/image-20220125162859189.png)

## 流数据（数据格式&图表格式）

流数据主要关注四行就够了（上行数据、下行数据）

- inbound-rtp：下行数据，也就是从远端接收到的数据，可以分为音频和视频

- outbound-rtp：上行数据，代表发送给远端的数据，可以分为音频和视频

  ![image-20220125170026281](WebRtc Internals工具使用/image-20220125170026281.png)

  ![image-20220125170242142](WebRtc Internals工具使用/image-20220125170242142.png)

  #### 展开后可以看到

  - ##### 下行数据（接收到的）

    ![image-20220125171344267](WebRtc Internals工具使用/image-20220125171344267.png)

    ![image-20220125172427718](WebRtc Internals工具使用/image-20220125172427718.png)

    ![image-20220125171812419](WebRtc Internals工具使用/image-20220125171812419.png)

    ![image-20220125172507453](WebRtc Internals工具使用/image-20220125172507453.png)

  - ##### 上行数据（发送的）

    ![image-20220125172252449](WebRtc Internals工具使用/image-20220125172252449.png)

    ![image-20220125172315264](WebRtc Internals工具使用/image-20220125172315264.png)

## 问题排查

- ##### 拉流画面黑屏

  需要查看video的inbound-rtp的下行数据包是否有接收到，或者帧解码是否成功。

- ##### 拉流没有声音

  需要查看audio的inbound-rtp接收到的数据是否存在问题