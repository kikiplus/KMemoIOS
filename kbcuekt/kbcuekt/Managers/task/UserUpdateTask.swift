//
//  UserUpdateTask
//  kbucket
//
//  Created by 김미혜 on 2018. 09. 4..
//  Copyright © 2018년 kikiplus. All rights reserved.
//

import Foundation

class UserUpdateTask {
    
    private let TAG : String = "UserUpdateTask"
    
    /**
     * 접속할 URL
     */
    private var mURl : String
    
    /**
     * post방식 true, get방식-false
     */
    private var isPost  : Bool = false
    
    /**
     * HTTP 리시브 콜백 메소드 객체
     */
    private var mIHttpReceive : IHttpReceive
   
    /**
     * 생성자
     */
    public init(url : String, post : Bool,  receive : IHttpReceive) {
        mURl = url
        isPost = post
        mIHttpReceive = receive
    }
    
    func actionTaskWithData(data : String){
        let url = URL(string: mURl)
        
        if(isPost){
            var request = URLRequest(url: url!)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let postString = data
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request, completionHandler : {
                (data : Data?, response : URLResponse?, error : Error?) -> Void in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                   return
                }
                if data != nil {
                        do {
                            if let jsonString = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                                KLog.d(tag : ContextUtils.TAG, msg : "@@ json : " + jsonString.description)
                            }
                        } catch {
                            KLog.d(tag : ContextUtils.TAG, msg : "@@ Exception ")
                        }
                }})
            task.resume()
        }else{
            let task = URLSession.shared.dataTask(with: url!, completionHandler : {
                (data : Data?, response : URLResponse?, error : Error?) -> Void in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                   return
                }
                if data != nil {
                    do {
                        if let jsonString = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                              KLog.d(tag : ContextUtils.TAG, msg : "@@ json : " + jsonString.description)
                        }
                    } catch {
                        KLog.d(tag : ContextUtils.TAG, msg : "@@ Exception ")
                    }
                }})
            task.resume()
        }
        
    }
    
    /**
     * 서버로 전송할 데이타 만들기
     *
     * @return 전송 데이타
     */
    private func getUserData(user : MobileUser) -> [String:String] {
        let sendUser = MobileUser()
        
        sendUser.mOs = user.mOs
        sendUser.mUserNickName = user.mUserNickName
        sendUser.mPhone = user.mPhone
        sendUser.mVersionName = user.mVersionName
        sendUser.mMarket = user.mMarket
        sendUser.mLanguage = user.mLanguage
        sendUser.mCountry = user.mCountry
        sendUser.mGcmToken = user.mGcmToken
        
        return sendUser.toDictionary()
    }
}
