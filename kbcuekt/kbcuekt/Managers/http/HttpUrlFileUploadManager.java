package momo.kikiplus.com.kbucket.Managers.http;

import android.graphics.Bitmap;
import android.os.AsyncTask;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import momo.kikiplus.com.kbucket.Utils.ByteUtils;
import momo.kikiplus.com.kbucket.Utils.KLog;


/**
 * @author grapegirl
 * @version 1.0
 * @Class Name : HttpUrlFileUploadManager
 * @Description : 파일 업로드
 * @since 2015-07-01.
 */
public class HttpUrlFileUploadManager extends AsyncTask<Object, Void, Void> {

    /**
     * 접속할 URL
     */
    private String mURl = null;

    /**
     * HTTP 리시브 콜백 메소드 객체
     */
    private IHttpReceive mIHttpReceive = null;

    /**
     * 데이터 경계선 문자열
     */
    private String BOUNDARY_STRING = "== DATA END ===";
    /**
     * action Id
     */
    private int mId;

    private byte[] mByteArray;

    /**
     * 생성자
     */
    public HttpUrlFileUploadManager(String url, IHttpReceive receive, int id, byte[] bytes) {
        mURl = url;
        mIHttpReceive = receive;
        mId = id;
        mByteArray = bytes;
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }

    @Override
    protected Void doInBackground(Object... params) {
        String filePath = (String) params[0];
        String setValue = (String) params[1];
        String reqValue = (String) params[2];
        String fileName = (String) params[3];

        String lineEnd = "\r\n";
        String twoHyphens = "--";
        String boundary = "*****";

        try {

            ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(mByteArray);
            URL connectUrl = new URL(mURl);

            // open connection
            HttpURLConnection conn = (HttpURLConnection) connectUrl.openConnection();
            conn.setDoInput(true);
            conn.setDoOutput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Connection", "Keep-Alive");
            conn.setRequestProperty("Content-Type", "multipart/form-data;boundary=" + boundary);
            conn.setRequestProperty(setValue, reqValue);
            conn.setRequestProperty("filename", fileName);

            // write data
            DataOutputStream dos = new DataOutputStream(conn.getOutputStream());
            dos.writeBytes(twoHyphens + boundary + lineEnd);
            dos.writeBytes("Content-Disposition: form-data; name=\"uploadFile\";filename=\"" + fileName + "\"" + lineEnd);
            dos.writeBytes(lineEnd);

            int bytesAvailable = byteArrayInputStream.available();
            int maxBufferSize = 1024;
            int bufferSize = Math.min(bytesAvailable, maxBufferSize);

            byte[] buffer = new byte[bufferSize];
            int bytesRead = byteArrayInputStream.read(buffer, 0, bufferSize);

            // read image
            while (bytesRead > 0) {
                dos.write(buffer, 0, bufferSize);
                bytesAvailable = byteArrayInputStream.available();
                bufferSize = Math.min(bytesAvailable, maxBufferSize);
                bytesRead = byteArrayInputStream.read(buffer, 0, bufferSize);
            }

            dos.writeBytes(lineEnd);
            dos.writeBytes(twoHyphens + boundary + twoHyphens + lineEnd);

            // close streams
            byteArrayInputStream.close();
            dos.flush(); // finish upload...

            // get response
            int ch;
            InputStream is = conn.getInputStream();
            StringBuffer b = new StringBuffer();
            while ((ch = is.read()) != -1) {
                b.append((char) ch);
            }
            String s = b.toString();
            KLog.e("Test", "result = " + s);
            dos.close();
            mIHttpReceive.onHttpReceive(mIHttpReceive.HTTP_OK, mId, s);

        } catch (Exception e) {
            KLog.d("Test", "exception " + e.getMessage());
            mIHttpReceive.onHttpReceive(mIHttpReceive.HTTP_FAIL, mId, this.getClass() + " @@ Exception ");
        }

        return null;
    }


    @Override
    protected void onPostExecute(Void aVoid) {
        super.onPostExecute(aVoid);
    }


    /**
     * Map 형식으로 Key와 Value를 셋팅한다.
     *
     * @param key   : 서버에서 사용할 변수명
     * @param value : 변수명에 해당하는 실제 값
     * @return
     */
    public static String setParams(String key, String value) {
        return "Content-Disposition: form-data; name=\"" + key + "\"\r\n\r\n" + value;
    }

    /**
     * 업로드할 파일에 대한 메타 데이터를 설정한다.
     *
     * @param key      : 서버에서 사용할 파일 변수명
     * @param fileName : 서버에서 저장될 파일명
     * @return
     */
    public static String setFile(String key, String fileName) {
        return "Content-Disposition: form-data; name=\"" + key
                + "\";filename=\"" + fileName + "\"\r\n";
    }
}

