
/***
 * @author SQLQuery
 * @version 1.1
 * @Class Name : SQLQuery.swift
 * @Description : SQLQuery 클래스
 * @since 2017.09.08
 */
import Realm
import RealmSwift

class SQLQuery{
    
    private let TAG : String = "SQLQuery"
    private var sql : String = ""
    private let TABLE_MEMO : String = "KMEMO";
    private let TABLE_USER : String = "KUSER";
    private let TABLE_CHAT : String = "KCHAT";

    init() {
        KLog.d(tag: TAG, msg: "create Table 생성자");
    }
    
   
     /**
     * 테이블생성
     */
    public func createTable() -> Void {
      
    }

    public func selectKbucket() -> Results<Bucket>? {
        do{
            let realm = try Realm()
            let bucketList = realm.objects(Bucket.self)
            return bucketList
        }catch _{
            KLog.d(tag: TAG, msg: "selectKbucet db error")
            return nil
        }
    }

    public func selectKbucket(memoContents : String ) -> Results<Bucket>? {
        do{
            let realm = try Realm()
            let bucketList = realm.objects(Bucket.self).filter("mContent = '" + memoContents + "'")
            return bucketList
        }catch _{
            KLog.d(tag: TAG, msg: "selectKbucet db error")
            return nil
        }
    }

    public func containsKbucket(memoContents : String ) -> Bool {
        do{
            let realm = try Realm()
            let bucketList = realm.objects(Bucket.self).filter("mContent = '" + memoContents + "'")
            if(bucketList.count > 0){
                return true
            }
        }catch _{
            KLog.d(tag: TAG, msg: "selectKbucet db error")
        }
        return false
    }

    /**
     * 사용자 정보 insert 메소드
     *
     * @param context       컨텍스트
     * @param contents      내용
     * @param date          날짜
     * @param completeYN    완료여부
     * @param completedDate 완료된 날짜
     */
    public func insertUserSetting( contents : String , date : String , completeYN : String , completedDate : String ) -> Bool {
        KLog.d(tag: TAG, msg: "insertUserInfo mContent : " + contents);
        let bucketObj = Bucket()
        bucketObj.mContent = contents
        bucketObj.mCompleteDate = completedDate
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(bucketObj)
        }

        KLog.d(tag: TAG, msg: "success insertUserInfo mContent : " + contents);
        return true
    }

    /**
     * 메모 내용 업데이트 (수정)
     *
     * @param context     컨텍스트
     * @param contents    내용
     * @param newContents 새로운 내용
     */
    public func updateMemoContent(contents : String , newContents :  String ) -> Void {
        KLog.d(tag: TAG, msg: "updateMemoContent contents : " + contents);
        KLog.d(tag: TAG, msg: "updateMemoContent newContents : " + newContents);

        let realm = try! Realm()

        let bucketObj = realm.objects(Bucket.self).filter("mContent = '" + contents + "'")
        
        //bucketObj.mContent = newContents

        try! realm.write {
            realm.add(bucketObj, update: true)
        }
        KLog.d(tag: TAG, msg: "success updateMemoContent mContent : " + newContents)
    }

    /**
     * 메모 내용 업데이트 (수정)
     *
     * @param context     컨텍스트
     * @param contents    내용
     * @param newContents 새로운 내용
     * @param completeYn  완료여부(Y/N)
     * @param date        완료날짜
     */
    public func updateMemoContent(contents : String , newContents : String ,completeYn :  String ,date :  String ,imagePath:  String ) -> Void {
        
    }

    /**
     * 메모 내용 업데이트 (수정)
     */
    public func updateMemoContent(newBucket : Bucket, cotents : String ) -> Void {
        KLog.d(tag: TAG, msg: "updateMemoContent contents : " + cotents)
        KLog.d(tag: TAG, msg: "updateMemoContent newContents : " + newBucket.mContent)
        
        let realm = try! Realm()
       
        let bucketObj = realm.objects(Bucket.self).filter("mContent = '" + cotents + "'")
        try! realm.write {
            let cnt = bucketObj.count
            if cnt == 1 {
               realm.delete(bucketObj.first!)
            }
            realm.add(newBucket)
        }
        KLog.d(tag: TAG, msg: "success updateMemoContent mContent : " + newBucket.mContent)
    }

    /**
     * 사용자 닉네임 업데이트 메소드
     *
     * @param context  컨텍스트
     * @param nickanme 업데이트 할 닉네임
     */
    public func updateUserNickName(nickanme : String ) -> Void {
       
    }

    /**
     * 사용자 정보 설정 삭제
     *
     * @param context 컨텍스트
     */
    public func deleteUserBucket(contents: String ) -> Bool {
        KLog.d(tag: TAG, msg: "deleteUserBucket contents : " + contents);
        let realm = try! Realm()

        let bucketObj = realm.objects(Bucket.self).filter("mContent = '" + contents + "'")
        print(bucketObj)
        // Delete an object with a transaction
        try! realm.write {
         realm.delete(bucketObj)
        }
        KLog.d(tag: TAG, msg: "success deleteUserBucket contents : " + contents);
        return true
    }

    public func createChatTable() -> Void {
       

    }

    /**
     * 테이블 내용 삭제
     */
    public func DeleteBucketContents() -> Void {
        KLog.d(tag: TAG, msg: "DeleteBucketContents")
        let realm = try! Realm()
        
        try! realm.write {
             realm.delete( realm.objects(Bucket.self))
        }
        KLog.d(tag: TAG, msg: "success DeleteBucketContents")
    }
    
}
