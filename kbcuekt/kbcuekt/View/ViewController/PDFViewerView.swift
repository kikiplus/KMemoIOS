//
//  PDFViewerView.swift
//  kbucket
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit


class PDFViewerView : UIViewController {

     private let TAG : String = "PDFViewerView"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        KLog.d(tag: TAG, msg: "viewDidLoad");
    }


//     private PDFView pdfView;
//     private static int mPage = 0;

//     @Override
//     protected void onCreate(Bundle savedInstanceState) {
//         super.onCreate(savedInstanceState);
//         setContentView(R.layout.activity_pdfviewer);
//        // loadPDF();
//     }

//     private void loadPDF(String fileName) {
//         String path = Environment.getExternalStorageDirectory().getAbsolutePath() + "/kr.co.wowtv.StockTalk/tab/AccessTerms11.pdf";
//         File file = new File(path);
//         pdfView = (PDFView) findViewById(R.id.pdfView);
//         Log.d(TAG, "@@ loadPDF mPage : " + mPage);
//         int daulatPage = mPage;
//         pdfView.fromFile(file)
//                 //     .pages(0, 2, 1, 3, 3, 3) // all pages are displayed by default
//                 .enableSwipe(true) // allows to block changing pages using swipe
//                 .swipeHorizontal(false)
//                 .enableDoubletap(true)
//                 .defaultPage(daulatPage)
//                 // allows to draw something on the current page, usually visible in the middle of the screen
//                 .onDraw(onDrawListener)
//                 // allows to draw something on all pages, separately for every page. Called only for visible pages
// //                    .onDrawAll(onDrawListener)
// //                    .onLoad(onLoadCompleteListener) // called after document is loaded and starts to be rendered
// //                    .onPageChange(onPageChangeListener)
// //                    .onPageScroll(onPageScrollListener)
// //                    .onError(onErrorListener)
//                     .onRender(onRenderListener) // called after document is rendered for the first time
//                 .enableAnnotationRendering(false) // render annotations (such as comments, colors or forms)
//                 .password(null)
//                 .scrollHandle(null)
//                 .enableAntialiasing(true) // improve rendering a little bit on low-res screens
//                 // spacing between pages in dp. To define spacing color, set view background
//                 //.spacing(0)
//                 .load();


//     }

//     // 페이징 표시하기
//     private OnDrawListener onDrawListener = new OnDrawListener() {
//         @Override
//         public void onLayerDrawn(Canvas canvas, float pageWidth, float pageHeight, int displayedPage) {
//             mPage = displayedPage;
//             Log.d("mh", "@@ onLayerDrawn displayedPage : " + displayedPage);
//             Log.d("mh", "@@ onLayerDrawn mPage : " + mPage);
//             Paint paint = new Paint();
//             paint.setColor(Color.RED);
//             canvas.drawText("- " + displayedPage + " - ", 1000, 1000, paint);

//         }
//     };

//     // 화면 사이즈에 맞춰 표시됨
//     private OnRenderListener onRenderListener = new OnRenderListener() {
//         @Override
//         public void onInitiallyRendered(int nbPages, float pageWidth, float pageHeight) {
//             pdfView.fitToWidth(); // optionally pass page number
//         }
//     };

}
