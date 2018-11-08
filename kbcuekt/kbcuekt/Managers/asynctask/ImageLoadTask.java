package momo.kikiplus.com.kbucket.Managers.asynctask;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * @author grape gril
 * @version 1.0
 * @Class Name : ImageLoadTask
 * @Description : 이미지 다운로드 Task
 * @since 2016-02-25
 */
public class ImageLoadTask extends AsyncTask<String, Void, Bitmap> {

        private imageReceiveListener m_imageListener = null;

        public ImageLoadTask() {

        }

        public void setImageReceiveListener(imageReceiveListener imageListener) {
                m_imageListener = imageListener;
        }

        @Override
        protected void onPreExecute() {
                super.onPreExecute();
        }

        @Override
        protected Bitmap doInBackground(String... params) {
                Bitmap imgBitmap = null;
                HttpURLConnection conn = null;
                BufferedInputStream bis = null;

                try {
                        URL url = new URL(params[0]);
                        conn = (HttpURLConnection) url.openConnection();
                        conn.connect();
                        int nSize = conn.getContentLength();
                        bis = new BufferedInputStream(conn.getInputStream(), nSize);
                        imgBitmap = BitmapFactory.decodeStream(bis);
                } catch (Exception e) {
                        e.printStackTrace();
                } finally {
                        if (bis != null) {
                                try {
                                        bis.close();
                                } catch (IOException e) {
                                        e.printStackTrace();
                                }
                        }
                        if (conn != null)
                                conn.disconnect();
                }

                return imgBitmap;
        }

        @Override
        protected void onPostExecute(Bitmap bitmap) {
                super.onPostExecute(bitmap);

                if (bitmap != null) {
                        m_imageListener.onImageReceiveCompleted(bitmap);
                } else {
                        m_imageListener.onImageReceiveCompleted(null);
                }

        }

        /**
         * 이미지 리시브 리스너
         */
        public interface imageReceiveListener {
                public void onImageReceiveCompleted(Bitmap bitmap);
        }
}
