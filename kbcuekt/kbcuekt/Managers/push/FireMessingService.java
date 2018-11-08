package momo.kikiplus.com.kbucket.Managers.push;

import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.media.RingtoneManager;
import android.net.Uri;
import android.support.v7.app.NotificationCompat;
import android.widget.Toast;

import com.google.firebase.messaging.RemoteMessage;

import momo.kikiplus.com.kbucket.R;
import momo.kikiplus.com.kbucket.Utils.KLog;
import momo.kikiplus.com.kbucket.view.Activity.MainActivity;
import momo.kikiplus.com.kbucket.view.Activity.PushPopupActivity;

/***
 * @author grape girl
 * @version 1.0
 * @Class Name : FireMessingService
 * @Description : FCM 메시지 수신 서비스
 * @since 2017. 3. 11.
 */
public class FireMessingService extends com.google.firebase.messaging.FirebaseMessagingService {

    private static final String TAG = "FireMessingService";

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        KLog.d(TAG, "@@ message Message2: " + remoteMessage.getData().toString());
        sendNotification(remoteMessage.getData().get("message"));

    }

    private void sendNotification(String messageBody) {
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intent,
                PendingIntent.FLAG_ONE_SHOT);

        Uri defaultSoundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        NotificationCompat.Builder notificationBuilder = (NotificationCompat.Builder) new NotificationCompat.Builder(this)
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentTitle("메모가지 알림")
                .setContentText(messageBody)
                .setAutoCancel(true)
                .setSound(defaultSoundUri)
                .setContentIntent(pendingIntent);

        NotificationManager notificationManager =
                (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.notify(0, notificationBuilder.build());
    }
}
