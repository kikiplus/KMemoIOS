package momo.kikiplus.com.kbucket.Managers.push;

import android.app.IntentService;
import android.content.Intent;

import com.google.android.gms.iid.InstanceID;

import momo.kikiplus.com.kbucket.Utils.KLog;

/***
 * @author grape girl
 * @version 1.0
 * @Class Name : SafetyUnRegistrationService
 * @Description : GCM 서버로부터 토큰 해지 요청 서비스
 * @since 2015. 6. 8.
 */
public class SafetyUnRegistrationService extends IntentService {

    private static final String TAG = SafetyUnRegistrationService.class.getSimpleName();


    public SafetyUnRegistrationService() {
        super(TAG);
    }

    @Override
    protected void onHandleIntent(Intent intent) {
        try {
            synchronized (TAG) {
                InstanceID instanceID = InstanceID.getInstance(this);
                instanceID.deleteInstanceID();
                KLog.d(this.getClass().getSimpleName(), "@@ SafetyUnRegistrationService token 해지 ");
            }
        } catch (Exception e) {
            KLog.d(this.getClass().getSimpleName(), "SafetyUnRegistrationService 해지 Exception");
        }
    }

    @Override
    public void onDestroy() {
        KLog.d(this.getClass().getSimpleName(), "SafetyUnRegistrationService onDestroy");
    }


}
