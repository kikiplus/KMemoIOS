//
//  ConfigurationView.swift
//  환경설정
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit


class ConfigurationView : UIViewController , IHttpReceive {

    private let TAG : String = "ConfigurationView"

    private let START_VERSION : Int                 = 10
    private let SHOW_GOOGLE_VERSION : Int           = 20
    private let FILE_SELECT_CODE : Int              = 30

    private var mMarketVersionName : String         = ""
    private var mCurrentVersionName : String         = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad")
        //initialize()
    }
    
    func initialize(){
        //  mCurrentVersionName = AppUtils.getVersionName(this);
    //     ((TextView) findViewById(R.id.conf_current_version)).setText(mCurrentVersionName);
    //     mHandler.sendEmptyMessage(START_VERSION);

    //     ((Button) findViewById(R.id.conf_password_on_btn)).setOnClickListener(this);
    //     ((Button) findViewById(R.id.conf_update_btn)).setOnClickListener(this);
    //     ((Button) findViewById(R.id.conf_question_btn)).setOnClickListener(this);
    //     ((Button) findViewById(R.id.conf_import_btn)).setOnClickListener(this);
    //     ((Button) findViewById(R.id.conf_export_btn)).setOnClickListener(this);
    //     ((Button) findViewById(R.id.conf_password_off_btn)).setOnClickListener(this);
    //     ((Button) findViewById(R.id.conf_guide_btn)).setOnClickListener(this);
    //     ((Button) findViewById(R.id.conf_userSetting)).setOnClickListener(this);
    //     ((Button) findViewById(R.id.conf_userBackSetting)).setOnClickListener(this);
    }
    
    func finish(){
        KLog.d(tag: TAG, msg: "finish")
       // deleteImageResource()
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: ContextUtils.MAIN_VIEW)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        present(uvc!, animated: true, completion: nil)
    }

    @IBAction func onClick(_ sender: Any) {
           // switch(sender  as! UIButton ){
  //         //암호설정
    //         case R.id.conf_password_on_btn:
    //             Intent intent = new Intent(this, PassWordActivity.class);
    //             intent.putExtra("SET", "SET");
    //             startActivity(intent);
    //             break;
    //         //암호해제
    //         case R.id.conf_password_off_btn:
    //             String message = getString(R.string.password_cancle_string);
    //             Toast.makeText(getApplicationContext(), message, Toast.LENGTH_LONG).show();
    //             SharedPreferenceUtils.write(getApplicationContext(), ContextUtils.KEY_CONF_PASSWORD, "");
    //             break;
    //         //업데이트
    //         case R.id.conf_update_btn:
    //             if (mMarketVersionName == null || mMarketVersionName.equals("-")) {
    //                 message = getString(R.string.version_fail_string);
    //                 Toast.makeText(getApplicationContext(), message, Toast.LENGTH_LONG).show();
    //             } else if (StringUtils.compareVersion(mCurrentVersionName, mMarketVersionName) > 0) {
    //                 message = getString(R.string.version_update_string);
    //                 Toast.makeText(getApplicationContext(), message, Toast.LENGTH_LONG).show();
    //                 AppUtils.locationMarket(this, getPackageName());
    //             } else {
    //                 message = getString(R.string.version_lastest_string);
    //                 Toast.makeText(getApplicationContext(), message, Toast.LENGTH_LONG).show();
    //             }
    //             break;
    //         //문의하기
    //         case R.id.conf_question_btn:
    //             intent = new Intent(this, QuestionActivity.class);
    //             startActivity(intent);
    //             break;
    //         //복원하기
    //         case R.id.conf_import_btn:
    //             showFileChooser();
    //             break;
    //         //백업하기
    //         case R.id.conf_export_btn:
    //             Date date = new Date();
    //             String newDBName = DateUtils.getStringDateFormat(DateUtils.KBUCKET_DB_DATE_PATTER, date);
    //             boolean isResult = DataUtils.exportDB(newDBName);
    //             if (isResult) {
    //                 String mssage = getString(R.string.db_backup_path_string);
    //                 Toast.makeText(getApplicationContext(), mssage + "\n" + ContextUtils.KEY_FILE_FOLDER + "/" + newDBName + ".db", Toast.LENGTH_LONG).show();
    //             } else {
    //                 String mssage = getString(R.string.db_backup_faile_string);
    //                 Toast.makeText(getApplicationContext(), mssage, Toast.LENGTH_LONG).show();
    //             }
    //             break;
    //         //튜토리얼
    //         case R.id.conf_guide_btn:
    //             intent = new Intent(this, TutorialActivity.class);
    //             startActivity(intent);
    //             break;
    //         //별명설정
    //         case R.id.conf_userSetting:
    //             intent = new Intent(this, SetNickNameActivity.class);
    //             startActivity(intent);
    //             break;
    //         //배경 색상 설정
    //         case R.id.conf_userBackSetting:
    //             intent = new Intent(this, SetBackColorActivity.class);
    //             startActivity(intent);
    //             break;
         //   }
    }
 
    func onHttpReceive(type: Int, actionId: Int, data: Data) {
        KLog.d(tag : TAG, msg : "@@ onHttpReceive actionId: " + String(actionId))
        KLog.d(tag : TAG, msg : "@@ onHttpReceive  type: " + String(type))

        if (actionId == ConstHTTP.UPDATE_VERSION) {
            if (type == ConstHTTP.HTTP_OK) {
                do {
                    if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            let versionCode : Int = jsonString["versionCode"] as! Int
                            let versionName : String = jsonString["versionName"] as! String
                    }
                } catch {
                    KLog.d(tag : TAG, msg : "@@ Exception : ")
                    mMarketVersionName = "-"
                }
            } else{
              mMarketVersionName = "-"
            }
            handleMessage(what: SHOW_GOOGLE_VERSION, obj: "")
        }
       
    }

    // /**
    //  * 구글 앱스토어에서 버전 명 변환하는 메소드
    //  *
    //  * @param data 구글 앱스토어 정보
    //  * @return 버전명
    //  */
    // @Deprecated
    // private String getAppVersionData(String data) {
    //     String mVer;
    //     String startToken = "softwareVersion\">";
    //     String endToken = "<";
    //     int index = data.indexOf(startToken);
    //     if (index == -1) {
    //         mVer = null;
    //     } else {
    //         mVer = data.substring(index + startToken.length(), index
    //                 + startToken.length() + 100);
    //         mVer = mVer.substring(0, mVer.indexOf(endToken)).trim();
    //     }
    //     return mVer;
    // }

    func handleMessage(what : Int, obj : String) {
//            switch (what) {
//                case TOAST_MASSEGE:
//                    Toast.showToast(message: obj)
//                    break;
//            case SHOW_GOOGLE_VERSION:
//    //             ((TextView) findViewById(R.id.conf_lastest_version)).setText(mMarketVersionName);
//                break;
//            case START_VERSION:
//                let url  = ContextUtils.KBUCKET_VERSION_UPDATE_URL
//                let  httpUrlTaskManager : HttpUrlTaskManager =  HttpUrlTaskManager(url : url, post : false, receive : self, id : ConstHTTP.UPDATE_VERSION);
//                httpUrlTaskManager.actionTask()
//                break;
//        }
        
    }

    // /**
    //  * 파일 선택
    //  */
    // private void showFileChooser() {
    //     Intent intent = new Intent();
    //     intent.setAction(Intent.ACTION_GET_CONTENT);
    //     intent.setType("application/zip");
    //     intent.addCategory(Intent.CATEGORY_OPENABLE);

    //     try {
    //         startActivityForResult(
    //                 Intent.createChooser(intent, "Select a File"),
    //                 FILE_SELECT_CODE);
    //     } catch (android.content.ActivityNotFoundException ex) {
    //         Toast.makeText(this, "파일 선택 오류 발생",
    //                 Toast.LENGTH_SHORT).show();
    //     }
    // }

    // @Override
    // protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    //     switch (requestCode) {
    //         case FILE_SELECT_CODE:
    //             if (resultCode == RESULT_OK) {
    //                 Uri uri = data.getData();
    //                 KLog.d(TAG, "select path : " + uri.getPath());
    //                 boolean isResult = DataUtils.importDB(uri.getPath());
    //                 if (isResult) {
    //                     String msaage = getString(R.string.db_import_success_string);
    //                     Toast.makeText(getApplicationContext(), msaage, Toast.LENGTH_LONG).show();
    //                 } else {
    //                     String msaage = getString(R.string.db_import_fail_string);
    //                     Toast.makeText(getApplicationContext(), "", Toast.LENGTH_LONG).show();
    //                 }
    //             }
    //             break;
    //     }
    //     super.onActivityResult(requestCode, resultCode, data);
    // }

}
