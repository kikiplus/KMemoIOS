package momo.kikiplus.com.kbucket.Managers.push;

import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.FirebaseInstanceIdService;

import momo.kikiplus.com.kbucket.Utils.ContextUtils;
import momo.kikiplus.com.kbucket.Utils.KLog;
import momo.kikiplus.com.kbucket.Utils.SharedPreferenceUtils;

/***
 * @author grape girl
 * @version 1.0
 * @Class Name : FireInstanceIDService
 * @Description : FCM 메시지 수신 서비스
 * @since 2017. 3. 11.
 */
public class FireInstanceIDService extends FirebaseInstanceIdService {

    private static final String TAG = "FireInstanceIDService";

    @Override
    public void onTokenRefresh() {
        String token = FirebaseInstanceId.getInstance().getToken();
        KLog.d(this.getClass().getSimpleName(), "@@ FireInstanceIDService token : " + token);
        SharedPreferenceUtils.write(this, ContextUtils.KEY_USER_FCM, token);
    }
}
