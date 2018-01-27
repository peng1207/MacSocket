//
//  HSPClient.swift
//  MacSockerDemo
//
//  Created by okdeer on 2018/1/26.
//  Copyright © 2018年 okdeer. All rights reserved.
//

import Cocoa

//public enum HSP

class HSPClient: NSObject {
    
    var client : TCPClient?
    var msgRuning : Bool = false
    /**
     连接
     */
    func connect  (address:String,port:Int) ->  Bool{
       
        client =  TCPClient(addr: address, port: port)
        guard let c = client else {
            return false
        }
        let  (success,msg) = c.connect(timeout: 5)
        if success {
            msgRunLoop()
            return true
        }else{
            print("failure is \(msg)")
            return false
        }
    }
    
    /**
     读取信息
     */
    func readMsg() -> Any?{
        guard let c = client else {
            return nil
        }
        guard   let byte = c.readAll() else {
            return nil
        }
        if  (byte.count > 0 ) {
            print("byte is \(String(describing: byte))")
            let data =  Data(bytes: byte)
            var reponse = try? JSONSerialization.jsonObject(with: data , options: JSONSerialization.ReadingOptions.allowFragments)
            if reponse != nil {
                print(reponse ?? (Any).self)
            }else {
                reponse = String(data: data, encoding: .utf8)
            }
            return reponse
        }else{
            return nil
        }
    }
    /**
     循环读取信息
     */
    func msgRunLoop() -> Void{
        msgRuning = true
        DispatchQueue.global().async {
            while self.msgRuning {
                if  let reponse = self.readMsg() {
                    print("读取信息 \(reponse)")
                }else{
                    self.msgRuning = false
                    self.close()
                    break
                }
            }
        }
    }
    /**
     发送信息
     */
    func sendMsg(string:String) {
        _ =  self.client?.send(str: string)
    }
    /**
     关闭连接
     */
    func close () {
        self.msgRuning  = false
        guard let c = client else {
            return
        }
        _ = c.close()
        client = nil
    }
    /**
     是否在连接中
     */
    func isConnect () ->  Bool {
        guard let c = client else {
            return false
        }
        if (c.fd != nil) {
            return true
        }
        return false
    }
}
