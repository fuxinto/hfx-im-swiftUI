//
//  FXMessageACKManager.swift
//  FXRecipes
//
//  Created by hfx on 2021/8/31.
//  Copyright © 2021 黄福鑫. All rights reserved.
//

import Foundation

class HIMMessageAckHandler: HIMBaseHandler<Pb_MessageAck> {
 
    override func bodyClass() -> Pb_MessageAck.Type {
        return Pb_MessageAck.self
    }
    
    override func receive(body:Pb_MessageAck) {
        FXLog("收到消息Ack：\(body.msgID)")
//        guard let timestamp = getTimestamp(msgUid: body.msgUid) else { return  }
//        try? HIMMessage.update(msgId: body.messageID, timestamp: timestamp, msgUid: body.messagedUid)
    }
    
    func getTimestamp(msgUid:String) -> Int64?{
        var str = msgUid
        str.removeLast(5)
        str = str.replacingOccurrences(of: "-", with: "")
        let array = ["2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C",
                     "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P",
                     "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        var strs = 0
        for i in 0..<str.count{
            let x = str[str.index(str.startIndex,offsetBy: i)]
            if let inx = array.firstIndex(of: "\(x)") {
                strs |= inx
                print(inx)
                print(strs)
                if i == 11 {
                    strs >>= 2
//                    let type = strs&0xf
                    strs >>= 16
                   return Int64(str)
                    
//                    print("时间戳：",strs)
//                    print("type：",type)
                }
                strs <<= 5
            }
        }
        FXLog("getData(msgUid:String),error")
        return nil
    }
}
