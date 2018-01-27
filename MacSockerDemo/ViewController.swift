//
//  ViewController.swift
//  MacSockerDemo
//
//  Created by okdeer on 2018/1/25.
//  Copyright © 2018年 okdeer. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var client : HSPClient = HSPClient()
    var server : HSPServer = HSPServer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//     _ =  client.connect(address: "127.0.0.1", port: 8080)
        // Do any additional setup after loading the view.
      _ = server.start(port: 8000)
        
    }
    
    @IBAction func clickServerAction(_ sender: Any) {
        let serverVC = HSPServerVC()
        serverVC.view.frame = CGRect(x: 0, y: 0, width: 480, height: 270)
        self.view.addSubview(serverVC.view)
//        let window =  NSWindow(contentViewController: serverVC)
//        let currentWindow  = NSWindow(contentViewController: self)
//        window.makeKeyAndOrderFront(self)
//        currentWindow.orderOut(nil)
    }
    
    @IBAction func clickClientAction(_ sender: Any) {
        let clientVC = HSPClientVC()
        let window =  NSWindow(contentViewController: clientVC)
        let currentWindow  = NSWindow(contentViewController: self)
        currentWindow.orderOut(nil)
        window.makeKeyAndOrderFront(nil)
    }
    deinit {
        client.close()
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

