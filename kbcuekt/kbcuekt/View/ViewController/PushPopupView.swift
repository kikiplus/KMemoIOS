//
//  PushPopupView.swift
//  푸쉬 팝업 
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit

class PushPopupView: UIViewController {

    private let TAG : String = "PushPopupView"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        KLog.d(tag: TAG, msg: "viewDidLoad");
    }

    // @Override
    // protected void onCreate(Bundle savedInstanceState) {
    //     super.onCreate(savedInstanceState);

    //     getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
    //     requestWindowFeature(Window.FEATURE_NO_TITLE);

    //     MediaUtils.vibrate(this, 2000);

    //     setUIScale();

    //     Intent intent = getIntent();
    //     String msg = intent.getStringExtra("message");

    //     ((TextView) findViewById(R.id.basic_body_textView)).setText(msg);

    //     findViewById(R.id.popup_close_button).setOnClickListener(this);
    //     findViewById(R.id.popup_ok_button).setOnClickListener(this);
    // }

    // private void setUIScale() {
    //     LayoutInflater inflater = (LayoutInflater) getSystemService(LAYOUT_INFLATER_SERVICE);
    //     View view = inflater.inflate(R.layout.push_activity, null);

    //     DisplayMetrics metrics = new DisplayMetrics();
    //     getWindowManager().getDefaultDisplay().getMetrics(metrics);

    //     addContentView(view, new LinearLayout.LayoutParams(metrics.widthPixels, metrics.heightPixels));
    // }

    // @Override
    // public void onClick(View v) {
    //     switch (v.getId()) {
    //         case R.id.popup_ok_button:
    //         case R.id.popup_close_button:
    //             finish();
    //             break;
    //     }
    // }
}
