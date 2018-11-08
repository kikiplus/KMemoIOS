//
//  IntroView.swift
//  인트로
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit

class IntroView: UIViewController {

    private let TAG : String = "IntroView"

    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad")
        initialize()
    }

      func initialize(){
    //     Animation anim1 = new AlphaAnimation(0.0f, 1.0f);
    //     anim1.setDuration(500);
    //     Animation anim2 = new AlphaAnimation(0.0f, 1.0f);
    //     anim2.setDuration(1000);
    //     Animation anim3 = new AlphaAnimation(0.0f, 1.0f);
    //     anim3.setDuration(1000);
    //     findViewById(R.id.intro_imageview).setAnimation(anim1);
    //     findViewById(R.id.intro_imageview2).setAnimation(anim2);
    //     findViewById(R.id.intro_imageview3).setAnimation(anim3);

    //     Timer timer;
    //     TimerTask timerTask = new TimerTask() {
    //         @Override
    //         public void run() {
    //             String password = (String) SharedPreferenceUtils.read(getApplicationContext(), ContextUtils.KEY_CONF_PASSWORD, SharedPreferenceUtils.SHARED_PREF_VALUE_STRING);
    //             if (password != null && !password.equals("")) {
    //                 mHandler.sendEmptyMessage(1);
    //             } else {
    //                 //위젯으로부터 화면 전환
    //                 Intent intent = getIntent();
    //                 String startView = intent.getStringExtra("DATA");
    //                 if (startView != null && startView.equals(ContextUtils.WIDGET_WRITE_BUCKET)) {
    //                     mHandler.sendEmptyMessage(2);
    //                 } else if (startView != null && startView.equals(ContextUtils.WIDGET_BUCKET_LIST)) {
    //                     mHandler.sendEmptyMessage(3);
    //                 } else if (startView != null && startView.equals(ContextUtils.WIDGET_OURS_BUCKET)) {
    //                     mHandler.sendEmptyMessage(4);
    //                 } else if (startView != null && startView.equals(ContextUtils.WIDGET_SHARE)) {
    //                     mHandler.sendEmptyMessage(5);
    //                 } else {
    //                     mHandler.sendEmptyMessage(0);
    //                 }
    //             }
    //         }
    //     };
    //     timer = new Timer();
    //     timer.schedule(timerTask, 2000);
    }

    func handleMessage(what : Int, obj : String) {

//            switch (what) {
//            case 0://바로 실행할때
//                changeView(strView : "MainView")
//                finish()
//                break;
//            case 1://비밀번호 맞추기
//    //             intent = new Intent(this, PassWordActivity.class);
//    //             Intent intent2 = getIntent();
//    //             String startView = intent2.getStringExtra("DATA");
//    //             intent.putExtra("SET", "GET");
//    //             intent.putExtra("DATA", startView);
//    //             startActivity(intent);
//    //             finish();
//    //             break;
//                break;
//            case 2://가지 작성 화면
//                changeView(strView : "WriteView")
//                finish()
//                break;
//            case 3://리스트 화면
//                changeView(strView : "BucketListView")
//                finish()
//                break;
//            case 4://모두의 가지화면
//                changeView(strView : "ShareListView")
//                finish()
//                break;
//            case 5:
//                changeView(strView : "MainView")
//                finish()
//                break;
//        }
    }


    @IBAction func onBackPressed(_ sender: Any) {
        KLog.d(tag:TAG, msg: "onBackPressed");
    }

    private func changeView(strView : String){
        KLog.d(tag: TAG, msg: "changeView : " + strView)
        let uvc = self.storyboard?.instantiateViewController(withIdentifier : strView)
        uvc?.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal //페이지 전환시 에니메이션 효과 설정
        present(uvc!, animated: true, completion: nil)
    }
    
    private func finish(){
        KLog.d(tag: TAG, msg: "finish")
    }
}

