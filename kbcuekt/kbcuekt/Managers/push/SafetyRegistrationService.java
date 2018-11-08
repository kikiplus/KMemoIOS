package momo.kikiplus.com.kbucket.Managers.push;

import android.app.IntentService;
import android.app.backup.SharedPreferencesBackupHelper;
import android.content.Intent;

import com.google.android.gms.gcm.GoogleCloudMessaging;
import com.google.android.gms.iid.InstanceID;

import momo.kikiplus.com.kbucket.Utils.ContextUtils;
import momo.kikiplus.com.kbucket.Utils.KLog;
import momo.kikiplus.com.kbucket.Utils.SharedPreferenceUtils;

/***
 * @author grape girl
 * @version 1.0
 * @Class Name : SafetyRegistrationService
 * @Description :GCM 서버로부터 토큰 요청 서비스
 * @since 2015. 6. 8.
 */
public class SafetyRegistrationService extends IntentService {

    private String mProjectId = null;
    private static final String TAG = SafetyRegistrationService.class.getSimpleName();
    private static final int UPDATE_USER_VERSION = 1301; //사용자 버전 정보 업데이트

    public SafetyRegistrationService() {
        super(TAG);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        return super.onStartCommand(intent, flags, startId);
    }


    @Override
    protected void onHandleIntent(Intent intent) {
        try {
            synchronized (TAG) {
                InstanceID instanceID = InstanceID.getInstance(this);
                String token = instanceID.getToken(ContextUtils.KEY_GCM_PROJECT_ID, GoogleCloudMessaging.INSTANCE_ID_SCOPE, null);
                KLog.d(this.getClass().getSimpleName(), "@@ SafetyRegistrationService token : " + token);
                SharedPreferenceUtils.write(this, ContextUtils.KEY_USER_GCM, token);
            }
        } catch (Exception e) {
            KLog.d(this.getClass().getSimpleName(), "SafetyRegistrationService 발급 Exception : " + e.toString());
        }
    }

    @Override
    public void onDestroy() {
        KLog.d(this.getClass().getSimpleName(), "SafetyRegistrationService onDestroy");
    }
}
