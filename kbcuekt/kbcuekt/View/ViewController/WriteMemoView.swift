//
//  WriteMemoView.swift
//  메모 작성 클래스
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit

class WriteMemoView : UIViewController {

   private let TAG : String = "WriteMemoView"

   @IBOutlet weak var btModify: UIButton!
   @IBOutlet weak var etContent: UIButton!

   private let Intent_WID : String = "WID"    // appWidgetIds
   private var mWidgetId : Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        KLog.d(tag: TAG, msg: "viewDidLoad");

        // Intent intent = getIntent();
        // Bundle extras = intent.getExtras();

        // if (extras != null && extras.getInt(Intent_WID, 0) != 0)
        //     mWidgetId = extras.getInt(Intent_WID);

        // ((Button) findViewById(R.id.write_meo_modify)).setOnClickListener(this);
        // String memo = (String) SharedPreferenceUtils.read(this, ContextUtils.KEY_USER_MEMO, SharedPreferenceUtils.SHARED_PREF_VALUE_STRING);
        // ((EditText) findViewById(R.id.write_meo_content)).setText(memo);
    }
    

    func onClickModify(message : String) {
        // String memo = ((EditText) findViewById(R.id.write_meo_content)).getText().toString();
        // SharedPreferenceUtils.write(this, ContextUtils.KEY_USER_MEMO, memo);
        // KMemoWidget.updateWidget(this, mWidgetId);
        // finish();

    }
}
