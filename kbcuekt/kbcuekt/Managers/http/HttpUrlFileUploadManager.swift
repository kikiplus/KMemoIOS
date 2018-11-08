//
//  HttpUrlFileTaskManager.swift
//  kbucket
//
//  Created by 김미혜 on 2017. 12. 16..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import Foundation

class HttpUrlFileUploadManager {
    
    private let TAG : String = "HttpUrlFileUploadManager"
    
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
     * action Id
     */
    private var mId : Int
    
    /**
     * 데이터 경계선 문자열
     */
    private var BOUNDARY_STRING : String = "== DATA END ==="
    
    
    /**
     * 생성자
     */
    public init(url : String, post : Bool,  receive : IHttpReceive, id : Int) {
        mURl = url;
        isPost = post;
        mIHttpReceive = receive;
        mId = id;
    }
    
    
    func actionTask(filePath : String, setValue : String, reqValue : String, fileName : String , image : Data){
        let url = URL(string: mURl)
        KLog.d(tag: TAG, msg: "@@ url : " + mURl )
        let lineEnd = "\r\n"
        let twoHyphens = "--"
        let boundary = "*****"
        let mimetype = "image/jpg"
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(setValue, forHTTPHeaderField: reqValue)
        request.setValue(fileName, forHTTPHeaderField: fileName)
        var postString = twoHyphens + boundary + lineEnd
        postString += "Content-Disposition: form-data; name=\"uploadFile\";filename=\"" + fileName + "\"" + lineEnd
        postString += "Content-Type: \(mimetype)\r\n\r\n" + lineEnd
        KLog.d(tag: TAG, msg: "@@ url1 postString : " + postString )
        
        let encodedImageData = image.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        postString += encodedImageData
        postString += lineEnd
        KLog.d(tag: TAG, msg: "@@ url2 postString : " + postString )
        request.httpBody = postString.data(using: .utf8)
        
        KLog.d(tag: TAG, msg: "@@ url3 : " + postString )
        
        let task = URLSession.shared.dataTask(with: request, completionHandler : {
            (data : Data?, response : URLResponse?, error : Error?) -> Void in
            
             KLog.d(tag: "ttt", msg: "@@ url4 : "  )
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                 self.mIHttpReceive.onHttpReceive(type: ConstHTTP.HTTP_FAIL, actionId: self.mId, data: data! )
                return
            }
           self.mIHttpReceive.onHttpReceive(type: ConstHTTP.HTTP_OK, actionId: self.mId, data: data! )
        })
        task.resume()
    }
    
    /**
     * Map 형식으로 Key와 Value를 셋팅한다.
     *
     * @param key   : 서버에서 사용할 변수명
     * @param value : 변수명에 해당하는 실제 값
     * @return
     */
    func setParams(key : String , value : String) -> String {
        return "Content-Disposition: form-data; name=\"" + key + "\"\r\n\r\n" + value
    }
    
    /**
     * 업로드할 파일에 대한 메타 데이터를 설정한다.
     *
     * @param key      : 서버에서 사용할 파일 변수명
     * @param fileName : 서버에서 저장될 파일명
     * @return
     */
    func setFile(key : String, fileName : String) -> String {
        return "Content-Disposition: form-data; name=\"" + key + "\";filename=\"" + fileName + "\"\r\n"
    }
    
}


