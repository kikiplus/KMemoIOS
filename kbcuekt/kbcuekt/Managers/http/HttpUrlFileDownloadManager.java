package momo.kikiplus.com.kbucket.Managers.http;

import android.os.AsyncTask;
import android.os.Environment;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import momo.kikiplus.com.kbucket.Utils.KLog;

/**
 * @author grapegirl
 * @version 1.0
 * @Class Name : HttpFileDownloadManager
 * @Description : 파일 다운로드 매니저
 * @since 2015-07-02.
 */
public class HttpUrlFileDownloadManager extends AsyncTask<Object, Void, Void> {

    /**
     * 응답 리시버 객체
     */
    private IHttpReceive mHttpReceive = null;
    /**
     * action Id
     */
    private int mId;

    /**
     * 접속할 URL
     */
    private String mURl = null;

    /**
     * 생성자
     *
     * @param receive 응답 리시버 객체
     */
    public HttpUrlFileDownloadManager(String url, IHttpReceive receive, int id) {
        mURl = url;
        mHttpReceive = receive;
        mId = id;
    }

    @Override
    protected Void doInBackground(Object... params) {
        int count = 0;
        try {
            URL url = new URL(mURl);
            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.connect();

            int lenghtOfFile = urlConnection.getContentLength();
            InputStream input = urlConnection.getInputStream();

            String saveFile = (String) params[0];
            KLog.d(this.getClass().getSimpleName(), "@@ saveFile : " + saveFile);
            OutputStream output = new FileOutputStream(saveFile);

            byte[] data = new byte[1024];
            long total = 0;
            if (input != null) {
                while ((count = input.read(data)) != -1) {
                    total += count;
                    KLog.d(this.getClass().getSimpleName(), "@@ data loading = " + (int) total);
                    output.write(data, 0, count);
                }
                output.flush();
                output.close();
                input.close();
                mHttpReceive.onHttpReceive(mHttpReceive.HTTP_OK, mId, "HttpResponse Download Ok");
            } else {
                mHttpReceive.onHttpReceive(mHttpReceive.HTTP_FAIL, mId, "HttpResponse InputStream null");
            }
            urlConnection.disconnect();
        } catch (IOException e) {
            e.printStackTrace();
            KLog.d(this.getClass().getSimpleName(), this.getClass() + "IOException ");
        }
        return null;
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }

    @Override
    protected void onPostExecute(Void aVoid) {
        super.onPostExecute(aVoid);
    }
}
