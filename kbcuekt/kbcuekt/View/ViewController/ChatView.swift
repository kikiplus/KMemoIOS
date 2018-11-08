//
//  ChatView.swift
//  채팅
//
//  Created by grapegirl on 2017. 9. 01..
//  Copyright © 2017년 kikiplus. All rights reserved.
//

import UIKit


class ChatView: UIViewController {

    private let TAG : String = "ChatView"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        KLog.d(tag: TAG, msg: "viewDidLoad");
    }

    // private final String TAG = this.getClass().getSimpleName();
    // private Handler mHandler = null;
    // private ArrayList<Chat> mList = null;
    // private ArrayList<Chat> mSaveDBList = null;
    // private ChatListAdpater mListAdapter = null;
    // private ListView mListView = null;
    // private int mBucketNo = -1;
    // private String mUserNickname = null;
    // private String mLastSeq = "0";

    // private final int TOAST_MASSEGE = 10;
    // private final int LOAD_CHAT_LIST = 20;
    // private final int SERVER_LOADING_FAIL = 30;
    // private final int SET_CHAT_LIST = 40;

    // private SQLQuery mSqlQuery = null;

    // @Override
    // protected void onCreate(Bundle savedInstanceState) {
    //     super.onCreate(savedInstanceState);
    //     this.overridePendingTransition(R.anim.slide_in_right, R.anim.slide_out_left);
    //     setContentView(R.layout.chat_activity);
    //     setBackgroundColor();
    //     mSqlQuery = new SQLQuery();
    //     mHandler = new Handler(this);
    //     mList = new ArrayList<Chat>();
    //     mSaveDBList = new ArrayList<Chat>();
    //     mUserNickname = (String) SharedPreferenceUtils.read(this, ContextUtils.KEY_USER_NICKNAME, SharedPreferenceUtils.SHARED_PREF_VALUE_STRING);
    //     ((Button) findViewById(R.id.chat_comment_layout_sendBtn)).setOnClickListener(this);
    //     setData();
    //     loadChatDBDat();
    //     AppUtils.sendTrackerScreen(this, "채팅화면");
    // }

    // private void setBackgroundColor() {
    //     int color = (Integer) SharedPreferenceUtils.read(getApplicationContext(), ContextUtils.BACK_MEMO, SharedPreferenceUtils.SHARED_PREF_VALUE_INTEGER);
    //     if (color != -1) {
    //         findViewById(R.id.bucketdetail_back_color).setBackgroundColor(color);
    //     }
    // }

    // @Override
    // public void finish() {
    //     super.finish();
    //     this.overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
    // }

    // @Override
    // protected void onDestroy() {
    //     super.onDestroy();
    // }

    // /**
    //  * 데이타 초기화
    //  */
    // private void setData() {
    //     Typeface typeFace = DataUtils.getHannaFont(getApplicationContext());
    //     ((Button) findViewById(R.id.chat_detail_text)).setTypeface(typeFace);
    //     ((Button) findViewById(R.id.chat_comment_layout_sendBtn)).setTypeface(typeFace);
    //     ((EditText) findViewById(R.id.chat_comment_layout_text)).setTypeface(typeFace);

    // }

    // @Override
    // public void onHttpReceive(int type, int actionId, Object obj) {
    //     KLog.d(this.getClass().getSimpleName(), "@@ onHttpReceive actionId: " + actionId);
    //     KLog.d(this.getClass().getSimpleName(), "@@ onHttpReceive  type: " + type);
    //     KLog.d(this.getClass().getSimpleName(), "@@ onHttpReceive  obj: " + obj);
    //     String mData = (String) obj;
    //     boolean isValid = false;
    //     if (mData != null) {
    //         try {
    //             JSONObject json = new JSONObject(mData);
    //             isValid = json.getBoolean("isValid");
    //         } catch (JSONException e) {
    //             KLog.e(TAG, "@@ jsonException message : " + e.getMessage());
    //         }
    //     }
    //     if (actionId == IHttpReceive.SELECT_CHAT) {
    //         KProgressDialog.setDataLoadingDialog(this, false, null, false);
    //         if (type == IHttpReceive.HTTP_OK && isValid == true) {
    //             try {
    //                 JSONObject json = new JSONObject(mData);
    //                 JSONArray jsonArray = json.getJSONArray("chatVOList");
    //                 int size = jsonArray.length();
    //                 for (int i = 0; i < size; i++) {
    //                     JSONObject jsonObject = (JSONObject) jsonArray.get(i);
    //                     Chat chat = new Chat();
    //                     chat.setNickName(jsonObject.getString("nickname"));
    //                     chat.setContent(jsonObject.getString("content"));
    //                     chat.setDate(jsonObject.getString("date"));
    //                     chat.setSeq(jsonObject.getInt("seq"));

    //                     if (mLastSeq != null) {
    //                         int nLastSeq = Integer.valueOf(mLastSeq);
    //                         if (nLastSeq < jsonObject.getInt("seq")) {
    //                             mLastSeq = String.valueOf(jsonObject.getInt("seq"));
    //                             mList.add(chat);
    //                             mSaveDBList.add(chat);
    //                         }
    //                     }
    //                 }
    //                 mHandler.sendEmptyMessage(SET_CHAT_LIST);
    //             } catch (JSONException e) {
    //                 KLog.e(TAG, "@@ jsonException message : " + e.getMessage());
    //                 mHandler.sendEmptyMessage(SERVER_LOADING_FAIL);
    //             }
    //         } else {
    //             mHandler.sendEmptyMessage(SERVER_LOADING_FAIL);
    //         }
    //     } else if (actionId == INSERT_CHAT) {
    //         KProgressDialog.setDataLoadingDialog(this, false, null, false);
    //         if (type == IHttpReceive.HTTP_OK && isValid == true) {
    //             mHandler.sendMessage(mHandler.obtainMessage(LOAD_CHAT_LIST, mBucketNo));
    //         } else {
    //             mHandler.sendEmptyMessage(SERVER_LOADING_FAIL);
    //         }
    //     }
    // }

    // @Override
    // public void onClick(View v) {
    //     switch (v.getId()) {
    //         case R.id.chat_comment_layout_sendBtn:
    //             String text = ((EditText) findViewById(R.id.chat_comment_layout_text)).getText().toString();
    //             if ("".equals(text.replaceAll(" ", ""))) {
    //                 mHandler.sendMessage(mHandler.obtainMessage(TOAST_MASSEGE, "내용을 입력해주세요~"));
    //                 break;
    //             }
    //             KProgressDialog.setDataLoadingDialog(this, true, this.getString(R.string.loading_string), true);
    //             HttpUrlTaskManager httpUrlTaskManager = new HttpUrlTaskManager(ContextUtils.INSERT_CHAT, true, this, IHttpReceive.INSERT_CHAT);
    //             HashMap<String, Object> map = new HashMap<String, Object>();
    //             map.put("NICKNAME", mUserNickname);
    //             map.put("CONTENT", text);
    //             map.put("CREATE_DT", DateUtils.getDateFormat(DateUtils.KBUCKET_DB_DATE_PATTER, 0));
    //             map.put("idx", DateUtils.getDateFormat(DateUtils.DATE_YYMMDD_PATTER2, 0));
    //             httpUrlTaskManager.execute(StringUtils.getHTTPPostSendData(map));
    //             ((EditText) findViewById(R.id.chat_comment_layout_text)).setText("");
    //             break;
    //     }
    // }

    // @Override
    // public boolean handleMessage(Message msg) {
    //     switch (msg.what) {
    //         case LOAD_CHAT_LIST:
    //             KProgressDialog.setDataLoadingDialog(this, true, this.getString(R.string.loading_string), true);
    //             HttpUrlTaskManager httpUrlTaskManager = new HttpUrlTaskManager(ContextUtils.SELECT_CHAT, true, this, IHttpReceive.SELECT_CHAT);
    //             HashMap<String, Object> map = new HashMap<String, Object>();
    //             map.put("idx", DateUtils.getDateFormat(DateUtils.DATE_YYMMDD_PATTER2, 0));
    //             map.put("NICKNAME", mUserNickname);
    //             if (mLastSeq != null) {
    //                 map.put("seq", mLastSeq);
    //             }
    //             KLog.d(TAG, "@@ loadchat  : " + StringUtils.getHTTPPostSendData(map));
    //             httpUrlTaskManager.execute(StringUtils.getHTTPPostSendData(map));
    //             break;
    //         case SET_CHAT_LIST:
    //             mListView = (ListView) findViewById(R.id.chat_listview);
    //             mListAdapter = new ChatListAdpater(this, R.layout.chat_list_line, mList);
    //             mListView.setAdapter(mListAdapter);
    //             mListView.setDivider(null);
    //             mListView.setSelection(mList.size());
    //             addChatDBData();
    //             break;
    //         case TOAST_MASSEGE:
    //             Toast.makeText(getApplicationContext(), (String) msg.obj, Toast.LENGTH_LONG).show();
    //             break;
    //         case SERVER_LOADING_FAIL:
    //             KLog.d(TAG, "@@ SERVER_LOADING_FAIL");
    //             String message = getString(R.string.server_fail_string);
    //             mHandler.sendMessage(mHandler.obtainMessage(TOAST_MASSEGE, message));
    //             finish();
    //             break;
    //     }
    //     return false;
    // }

    // /**
    //  * Chat DB 데이타 동기화하기(추가)
    //  */
    // private void addChatDBData() {
    //     String chatIdx = DateUtils.getDateFormat(DateUtils.DATE_YYMMDD_PATTER2, 0);
    //     KLog.d(TAG, "@@ addChatDBData  mSaveDBList.size(): " + mSaveDBList.size());
    //     for (int i = 0; i < mSaveDBList.size(); i++) {
    //         String contents = mSaveDBList.get(i).getContent();
    //         String date = mSaveDBList.get(i).getDate();
    //         String nickname = mSaveDBList.get(i).getNickName();
    //         String seq = String.valueOf(mSaveDBList.get(i).getSeq());
    //         String imagePath = mSaveDBList.get(i).getImageUrl();
    //         try {
    //             mSqlQuery.insertChatting(getApplicationContext(), contents, date, nickname, imagePath, seq, chatIdx);
    //         } catch (Exception e) {
    //             KLog.d(TAG, "@@ addChatDBData exception : " + e.getMessage());
    //         }
    //     }
    //     mSaveDBList.clear();
    // }

    // private void loadChatDBDat() {
    //     String chatIdx = DateUtils.getDateFormat(DateUtils.DATE_YYMMDD_PATTER2, 0);
    //     LinkedList<LinkedHashMap<String, String>> map = mSqlQuery.selectChatTable(getApplicationContext(), chatIdx);
    //     if (map == null) {
    //         mHandler.sendEmptyMessage(LOAD_CHAT_LIST);
    //         return;
    //     }
    //     for (int i = 0; i < map.size(); i++) {
    //         LinkedHashMap<String, String> chatMap = map.get(i);
    //         Chat chat = new Chat();
    //         chat.setContent(chatMap.get("contents"));
    //         chat.setNickName(chatMap.get("nickname"));
    //         chat.setSeq(Integer.valueOf(chatMap.get("seq")));
    //         chat.setDate(chatMap.get("date"));

    //         mList.add(chat);
    //         mLastSeq = chatMap.get("seq");
    //     }
    //     KLog.d(TAG, "@@ loadChatDBDat mLastSeq : " + mLastSeq);
    //     mHandler.sendEmptyMessage(LOAD_CHAT_LIST);
    // }
}
