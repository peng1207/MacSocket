//
//  HSPServerVC.swift
//  MacSockerDemo
//
//  Created by okdeer on 2018/1/26.
//  Copyright © 2018年 okdeer. All rights reserved.
//

import Cocoa

class HSPServerVC: NSViewController {
    fileprivate var startBtn : NSButton?
    fileprivate var server : HSPServer?
    fileprivate var text : NSText?
    
    override func loadView() {
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupUI()
    }
}

//MARK: UI
extension HSPServerVC {
    /**
     创建UI
     */
    fileprivate func setupUI(){
        startBtn = NSButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        startBtn?.bezelStyle = NSButton.BezelStyle.rounded
        startBtn?.target = self
        startBtn?.title = "asaaa"
        startBtn?.action = #selector(HSPServerVC.startServer)
        self.view.addSubview(startBtn!)
    }
}
//MARK: action
extension HSPServerVC {
    @objc func startServer(){
        guard let server = server else {
            return
        }
        if server.isConnect() {
            server.close()
        }else{
            _ = server.start(port: 8000)
        }
    }
}



