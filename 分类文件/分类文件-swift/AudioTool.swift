//
//  AudioTool.swift
//  
//  此分类是通过AudioToolbox框架中方法播放本地音乐文件的分类，可以在播放完毕后执行回调


import AVFoundation

class AudioTool: NSObject {
    
    class func playSound(audioName: String, isAlert: Bool , playFinish: (()->())?) {
        
        // 一. 获取 SystemSoundID
        //   参数1: 文件路径
        //   参数2: SystemSoundID, 指针
        guard let url = NSBundle.mainBundle().URLForResource(audioName, withExtension: nil) else {
            print("没有找到音频路径")
            return
        }
        let urlCF = url as CFURLRef
        
        var systemSoundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(urlCF, &systemSoundID)
//        print(systemSoundID)
        // 二. 开始播放
        // 判断是否振动
        if isAlert {
            // 1. 带振动播放, 可以监听播放完成(模拟器不行)
            AudioServicesPlayAlertSoundWithCompletion(systemSoundID)
            {
                print("播放完成")
                // 三. 释放资源
                AudioServicesDisposeSystemSoundID(systemSoundID)
//                print(systemSoundID)
                // 四. 执行回调
                if playFinish != nil { playFinish!()} 
            }
        }else {
            // 2. 不带振动播放, 可以监听播放完成
            AudioServicesPlaySystemSoundWithCompletion(systemSoundID) {
                
                print("播放完成")
                // 三. 释放资源
                AudioServicesDisposeSystemSoundID(systemSoundID)
                
                // 四. 执行回调
                if playFinish != nil { playFinish!()} 
            }
        }
    }
}
