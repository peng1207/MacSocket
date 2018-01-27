//
//  HSPServer.swift
//  MacSockerDemo
//
//  Created by okdeer on 2018/1/26.
//  Copyright © 2018年 okdeer. All rights reserved.
//

import Cocoa

class HSPServer: NSObject {
    var server : TCPServer?
    var serverRuning : Bool  = false
    var clients : [HSPClient] = [HSPClient]()
    /**
        开启服务
     */
    func start(port:Int) -> Bool  {
        
        server = TCPServer(addr: "127.0.0.1", port: port)
        guard let serverClient = server else {
            return false
        }
        let  (success,msg) = serverClient.listen()
        if success {
            print("success")
            serverRuning = true
            getClient(serverClinet: serverClient)
        }else{
            print("failue \(msg)")
            serverRuning = false
        }
        return true
    }
    /**
     获取客户端
     */
    func getClient(serverClinet:TCPServer) {
        DispatchQueue.global(qos: .background).async {
            while self.serverRuning {
                guard let client = serverClinet.accept() else {
                    continue
                }
                DispatchQueue.global(qos: .background).async {
                    self.handClient(client: client)
                }
            }
        }
    }
    /**
     拼接客户端
     */
    func handClient(client:TCPClient)  {
        let c = HSPClient()
        c.client = client
        clients.append(c)
        c.msgRunLoop()
    }
    
    /**
     关闭服务器
     */
    func close () {
        guard let serverClient = server else {
            return
        }
        removeAllClient()
        self.serverRuning = false 
       _ = serverClient.close()
        server = nil
    }
    /**
     移除所有的客户端
     */
    fileprivate func removeAllClient() {
        for client in clients {
            client.close()
        }
        clients.removeAll()
    }
    /**
     是否在连接中
     */
    func isConnect() -> Bool {
        guard let _ = server else {
            return false
        }
        return true
    }
    
}
