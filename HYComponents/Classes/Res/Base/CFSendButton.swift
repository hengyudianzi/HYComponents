//
//  CFSendButton.swift
//  Smartbus_ChiFeng
//
//  Created by 🐲 on 2022/4/26.
//

import UIKit


public class  CFSendButton : UIButton {

    public var codeTimerCF = DispatchSource.makeTimerSource(queue:DispatchQueue.global())

    //倒计时启动
    public func countDown(count: Int){

        //倒计时开始,禁止点击事件
        isEnabled = false
      
        var remainingCount: Int = count {
            willSet {
                setTitle("\(newValue)秒重发", for: .normal)
                if newValue <= 0 {
                    setTitle("获取验证码", for: .normal)
                }
            }
        }

        if codeTimerCF.isCancelled {
            codeTimerCF = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        }

        // 设定这个时间源是每秒循环一次，立即开始
        codeTimerCF.schedule(deadline: .now(), repeating: .seconds(1))

        // 设定时间源的触发事件
        codeTimerCF.setEventHandler(handler: {

            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async { [self] in

                // 每秒计时一次
                remainingCount -= 1

                // 时间到了取消时间源
                if remainingCount <= 0 {
                    self.isEnabled = true
                    self.codeTimerCF.cancel()
                }
            }
        })

        // 启动时间源
        codeTimerCF.resume()
    }
    
    //取消倒计时
    public  func countDownCancel() {
        
        if !codeTimerCF.isCancelled {
            codeTimerCF.cancel()
        }
        // 返回主线程
        DispatchQueue.main.async {

            self.isEnabled = true
            if self.titleLabel?.text?.count != 0
            {
                self.setTitle("获取验证码", for: .normal)
            }
        }
    }
}
