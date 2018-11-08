package momo.kikiplus.com.kbucket.Managers.push;

import android.content.Intent;

import com.google.android.gms.iid.InstanceIDListenerService;

/***
 * @Class Name : SafetyInstanceIDListenerService
 * @Description : GCM RegiD 등록 및 갱신
 * @since 2015. 6. 8.
 * @version 1.0
 * @author grape girl
 */
public class SafetyInstanceIDListenerService extends InstanceIDListenerService {

	@Override
	public void onTokenRefresh() {
		Intent intent = new Intent( this, SafetyRegistrationService.class );
		startService( intent );
	}

}
