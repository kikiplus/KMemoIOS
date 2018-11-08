package momo.kikiplus.com.kbucket.Managers.asynctask;

import android.content.Context;
import android.os.AsyncTask;
import android.os.Message;
import android.util.Log;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

import io.realm.RealmResults;
import momo.kikiplus.com.kbucket.Managers.http.HttpUrlTaskManager;
import momo.kikiplus.com.kbucket.Managers.http.IHttpReceive;
import momo.kikiplus.com.kbucket.Managers.realm.realmMgr;
import momo.kikiplus.com.kbucket.R;
import momo.kikiplus.com.kbucket.Utils.AppUtils;
import momo.kikiplus.com.kbucket.Utils.ContextUtils;
import momo.kikiplus.com.kbucket.Utils.ErrorLogUtils;
import momo.kikiplus.com.kbucket.Utils.KLog;
import momo.kikiplus.com.kbucket.Utils.StringUtils;
import momo.kikiplus.com.kbucket.view.Bean.Version;
import momo.kikiplus.com.kbucket.view.popup.BasicPopup;
import momo.kikiplus.com.kbucket.view.popup.ConfirmPopup;
import momo.kikiplus.com.kbucket.view.popup.OnPopupEventListener;

/**
 * @author grape gril
 * @version 1.0
 * @Class Name : AppUpdateTask
 * @Description : App 업데이트 Task
 * @since 2016-01-28
 */
public class AppUpdateTask extends AsyncTask<Void, Void, Void> implements IHttpReceive, android.os.Handler.Callback, OnPopupEventListener {

    private final String TAG = this.getClass().getSimpleName();
    private Context mContext;
    private Version mVersion;
    private android.os.Handler mHandler;

    private final int START_VERSION = 10;
    private final int CHECK_VERSION = 20;
    private final int FAIL_VERSION = 30;
    private final int TOAST_MESSAGE = 40;

    private BasicPopup mBasicPopup;
    private ConfirmPopup mConfirmPopup;

    public AppUpdateTask(Context context) {
        mContext = context;
        mHandler = new android.os.Handler(this);
    }

    @Override
    protected void onPreExecute() {
    }

    @Override
    protected Void doInBackground(Void... params) {
        mHandler.sendEmptyMessage(START_VERSION);
        return null;
    }

    @Override
    protected void onPostExecute(Void aVoid) {
        super.onPostExecute(aVoid);
    }

    @Override
    public void onHttpReceive(int type, int actionId, Object obj) {
        KLog.d(this.getClass().getSimpleName(), " @@ onHttpReceive type:" + type + ", object: " + obj);
        if (actionId == IHttpReceive.UPDATE_VERSION) {
            if (type == IHttpReceive.HTTP_OK) {
                String mData = (String) obj;
                try {
                    JSONObject json = new JSONObject(mData);
                    int versionCode = json.getInt("versionCode");
                    String versionName = json.getString("versionName");
                    String forceYN = json.getString("forceYN");

                    mVersion = new Version();
                    mVersion.setForceYN(forceYN);
                    mVersion.setVersionCode(versionCode);
                    mVersion.setVersionName(versionName);

                    if(mVersion != null){
                        realmMgr realmMgr = new realmMgr();
                        realmMgr.updateVersion(mVersion);
                    }

                    mHandler.sendEmptyMessage(CHECK_VERSION);

                } catch (JSONException e) {
                    KLog.e(TAG, "@@ jsonException message : " + e.getMessage());
                    mHandler.sendEmptyMessage(FAIL_VERSION);
                }
            } else {
                mHandler.sendEmptyMessage(FAIL_VERSION);
            }
        }
    }

    @Override
    public boolean handleMessage(Message msg) {

        switch (msg.what) {
            case START_VERSION:
                HttpUrlTaskManager urlTaskManager = new HttpUrlTaskManager(ContextUtils.KBUCKET_VERSION_UPDATE_URL, true, this, IHttpReceive.UPDATE_VERSION);
                KLog.d(TAG, "@@ URL : " + ContextUtils.KBUCKET_VERSION_UPDATE_URL);
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("version", AppUtils.getVersionName(mContext));
                KLog.d(TAG, "@@ StringUtils.getHTTPPostSendData(map) : " + StringUtils.getHTTPPostSendData(map));
                urlTaskManager.execute(StringUtils.getHTTPPostSendData(map));
                break;
            case CHECK_VERSION:
                String currentVersionName = AppUtils.getVersionName(mContext);
                String serverVersionName = mVersion.getVersionName();
                Log.d(TAG, "@@ currentVersion : " + currentVersionName);
                Log.d(TAG, "@@ serverVersionName : " + serverVersionName);
                if (serverVersionName != null && !serverVersionName.equals("null")) {
                    if (StringUtils.compareVersion(currentVersionName, serverVersionName) > 0) {
                        if (mVersion.getForceYN().equals("Y")) {
                            String title = mContext.getString(R.string.update_popup_title);
                            String content = mContext.getString(R.string.update_popup_content_y);
                            mBasicPopup = new BasicPopup(mContext, title, content, R.layout.popup_basic, this, OnPopupEventListener.POPUP_UPDATE_FORCE);
                            mBasicPopup.showDialog();
                        } else {
                            String title = mContext.getString(R.string.update_popup_title);
                            String content = mContext.getString(R.string.update_popup_content_n);
                            mConfirmPopup = new ConfirmPopup(mContext, title, content, R.layout.popup_confirm, this, OnPopupEventListener.POPUP_UPDATE_SELECT);
                            mConfirmPopup.showDialog();
                        }
                    } else {
                        mHandler.sendEmptyMessage(TOAST_MESSAGE);
                    }
                }
                break;
            case FAIL_VERSION:
                KLog.d(TAG, "@@ Fail Version Check");
                realmMgr realmMgr = new realmMgr();
                RealmResults<Version> versionInfo = realmMgr.selectVersion();
                if (versionInfo != null) {
                    if (versionInfo.size() > 0) {
                        mVersion = versionInfo.get(0);
                        if (mVersion != null) {
                            mHandler.sendEmptyMessage(CHECK_VERSION);
                        }
                    }
                }
                break;
            case TOAST_MESSAGE:
                String message = mContext.getString(R.string.check_version_lasted);
                Toast.makeText(mContext, message, Toast.LENGTH_LONG).show();
                break;
        }
        return false;
    }

    @Override
    public void onPopupAction(int popId, int what, Object obj) {
        switch (popId) {
            case POPUP_UPDATE_FORCE:
                if (what == POPUP_BTN_OK) {
                    String message = mContext.getString(R.string.version_update_string);
                    Toast.makeText(mContext, message, Toast.LENGTH_SHORT).show();
                    AppUtils.locationMarket(mContext, mContext.getPackageName());
                }
                mBasicPopup.closeDialog();
                break;
            case POPUP_UPDATE_SELECT:
                if (what == POPUP_BTN_OK) {
                    String message = mContext.getString(R.string.version_update_string);
                    Toast.makeText(mContext, message, Toast.LENGTH_SHORT).show();
                    AppUtils.locationMarket(mContext, mContext.getPackageName());
                }
                mConfirmPopup.closeDialog();
                break;
        }
    }
}
