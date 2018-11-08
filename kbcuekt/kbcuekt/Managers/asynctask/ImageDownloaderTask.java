package momo.kikiplus.com.kbucket.Managers.asynctask;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Environment;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import momo.kikiplus.com.kbucket.Utils.ContextUtils;
import momo.kikiplus.com.kbucket.Utils.DataUtils;

/**
 * 인스타그램 공유 이미지 다운로드
 */
public class ImageDownloaderTask extends AsyncTask<String, Void, Bitmap> {

    private final String TAG = this.getClass().getSimpleName();
    private String mImageAddress;
    private String mFileName = null;
    private Context mContext;
    private Bitmap mBitmap = null;

    public ImageDownloaderTask(Context context) {
        mContext = context;
    }

    @Override
    protected Bitmap doInBackground(String... params) {
        try {
            String idx = (String) params[0];
            String url = ContextUtils.KBUCKET_DOWNLOAD_IAMGE + "?idx" + idx;
            InputStream is = new java.net.URL(url).openStream();
            mBitmap = BitmapFactory.decodeStream(is);
        } catch (IOException e) {
            Log.e(TAG, "Cannot load image from " + mImageAddress);
        }
        return mBitmap;
    }

    @Override
    protected void onPostExecute(Bitmap bitmap) {
        try {
            mFileName = DataUtils.getNewFileName();

            File file = new File(mFileName);
            file.getParentFile().mkdirs();
            FileOutputStream out = new FileOutputStream(file);
            if(mBitmap != null){
                mBitmap.compress(Bitmap.CompressFormat.PNG, 90, out);
            }
            out.close();
            Log.d(TAG, "Completed download image from file path : " + file.getPath());
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public Bitmap getImageBitmap() {
        return mBitmap;
    }
}
