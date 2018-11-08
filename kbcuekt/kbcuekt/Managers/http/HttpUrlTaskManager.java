/**
 *
 */


/**
 * @author grapegirl
 * @version 1.0
 * @Class Name : HTTPManager.java
 * @Description : HTTP 통신 매니저 클래스
 * @since 2017-11-04
 */
public class HttpUrlTaskManager extends AsyncTask<String, Void, Void> {

    /**
     * 접속할 URL
     */
    private String mURl = null;

    /**
     * post방식 true, get방식-false
     */
    private boolean isPost = false;

    /**
     * HTTP 리시브 콜백 메소드 객체
     */
    private IHttpReceive mIHttpReceive = null;
    /**
     * action Id
     */
    private int mId;

    /**
     * 생성자
     */
    public HttpUrlTaskManager(String url, boolean post, IHttpReceive receive, int id) {
        mURl = url;
        isPost = post;
        mIHttpReceive = receive;
        mId = id;
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }


    @Override
    protected Void doInBackground(String... params) {
        String data = "";
        try {
            URL url = new URL(mURl);
            URLConnection urlConnection = url.openConnection();
            HttpURLConnection httpURLConnection = (HttpURLConnection) urlConnection;
            httpURLConnection.setConnectTimeout(5000);
            httpURLConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            if (isPost) {
                try {
                    httpURLConnection.setRequestMethod("POST");
                } catch (ProtocolException e) {
                    e.printStackTrace();
                }
                httpURLConnection.setDoOutput(true);
            } else {
                httpURLConnection.setRequestMethod("GET");
            }
            httpURLConnection.setDoInput(true);
            httpURLConnection.setUseCaches(false);
            httpURLConnection.setDefaultUseCaches(false);

            if (isPost) {//Post 방식으로 데이타 전달시
                OutputStream outputStream = httpURLConnection.getOutputStream();
                if (params != null) {
                    String sendData = (String) params[0];
                    //System.out.println("@@ sendData : " + sendData);
                    outputStream.write(sendData.getBytes("UTF-8"));
                    outputStream.flush();
                    outputStream.close();
                }
            }
            if (httpURLConnection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                String buffer = null;
                BufferedReader bufferedReader;
                if (isPost) {
                    bufferedReader = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream(), "UTF-8"));
                } else {
                    bufferedReader = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream(), "UTF-8"));
                }
                while ((buffer = bufferedReader.readLine()) != null) {
                    data += buffer;
                }
                bufferedReader.close();
                httpURLConnection.disconnect();
                mIHttpReceive.onHttpReceive(mIHttpReceive.HTTP_OK, mId,  data);
            }else{
                mIHttpReceive.onHttpReceive(mIHttpReceive.HTTP_FAIL, mId, httpURLConnection.getResponseMessage());
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
            Log.d(this.getClass().getSimpleName(), " @@ MalformedURLException");
            mIHttpReceive.onHttpReceive(mIHttpReceive.HTTP_FAIL, mId,  null);

        } catch (ProtocolException e) {
            e.printStackTrace();
            Log.d(this.getClass().getSimpleName(), " @@ ProtocolException");
            mIHttpReceive.onHttpReceive(mIHttpReceive.HTTP_FAIL, mId, null);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            Log.d(this.getClass().getSimpleName(), " @@ UnsupportedEncodingException");
            mIHttpReceive.onHttpReceive(mIHttpReceive.HTTP_FAIL, mId, null);
        } catch (IOException e) {
            e.printStackTrace();
            Log.d(this.getClass().getSimpleName(), " @@ IOException");
            mIHttpReceive.onHttpReceive(mIHttpReceive.HTTP_FAIL, mId, null);
        }
        return null;
    }

    @Override
    protected void onPostExecute(Void aVoid) {
        super.onPostExecute(aVoid);
    }
}
