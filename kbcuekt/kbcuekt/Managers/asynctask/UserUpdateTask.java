package momo.kikiplus.com.kbucket.Managers.asynctask;

import android.content.Context;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Message;
import android.widget.Toast;

import java.util.HashMap;
import java.util.logging.Handler;

import momo.kikiplus.com.kbucket.Managers.http.HttpUrlTaskManager;
import momo.kikiplus.com.kbucket.Managers.http.IHttpReceive;
import momo.kikiplus.com.kbucket.Utils.ContextUtils;
import momo.kikiplus.com.kbucket.Utils.ErrorLogUtils;
import momo.kikiplus.com.kbucket.Utils.KLog;
import momo.kikiplus.com.kbucket.Utils.StringUtils;
import momo.kikiplus.com.kbucket.view.Bean.MobileUser;

/**
 * @author grape gril
 * @version 1.0
 * @Class Name : UserUpdateTask
 * @Description : 사용자 버전 업데이트 Task
 * @since 2015-10-08
 */
public class UserUpdateTask extends AsyncTask<Void, Void, Void> implements IHttpReceive, android.os.Handler.Callback {

    private final String TAG = this.getClass().getSimpleName();
    /**
     * 컨텍스트
     */
    private Context mContext;
    /**
     * 사용자 정보
     */
    private MobileUser mUser;

    private android.os.Handler mHandler;

    public UserUpdateTask(Context context, MobileUser user) {
        mContext = context;
        mUser = user;
        mHandler = new android.os.Handler(this);
    }

    @Override
    protected void onPreExecute() {
    }

    @Override
    protected Void doInBackground(Void... params) {
        mHandler.sendEmptyMessage(0);
        return null;
    }

    @Override
    protected void onPostExecute(Void aVoid) {
        super.onPostExecute(aVoid);
    }

    @Override
    public void onHttpReceive(int type, int actionId, Object obj) {
        if (actionId == IHttpReceive.UPDATE_USER) {
            if (type == IHttpReceive.HTTP_OK) {
                KLog.d(TAG, "@@ Update User Success !");
            }
        }
    }

    @Override
    public boolean handleMessage(Message msg) {
        //서버에 내 정보 업데이트
        HttpUrlTaskManager mHttpUrlTaskManager = new HttpUrlTaskManager(ContextUtils.KBUCKET_UPDATE_USER, true, this, IHttpReceive.UPDATE_USER);
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("OS", mUser.getOS());
        map.put("NICKNAME", mUser.getUserNickName());
        map.put("PHONE", mUser.getPhone());
        map.put("VERSION_NAME", mUser.getVersionName());
        map.put("MARKET", mUser.getMarket());
        map.put("LANG", mUser.getLanuage());
        map.put("COUNTY", mUser.getCountry());
        map.put("GCM_TOKEN", mUser.getGcmToken());
        map.put("OS_VERSION", Build.VERSION.RELEASE);
        map.put("TEL_GBN", Build.MODEL);
        mHttpUrlTaskManager.execute(StringUtils.getHTTPPostSendData(map));
        return false;
    }
}
