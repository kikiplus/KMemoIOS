package momo.kikiplus.com.kbucket.Utils.sqlite;

import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.logging.Logger;

import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import momo.kikiplus.com.kbucket.Utils.AppUtils;
import momo.kikiplus.com.kbucket.Utils.KLog;

public class SQLiteAdapter {
    private static final String TAG = "SQLiteAdapter";
    private static final String DATABASE_NAME = "bucket.db";
    private static final int DATABASE_VERSION = 1;

    Context mCtx;
    private DatabaseHelper mDbHelper;
    private SQLiteDatabase mDb;

    public SQLiteAdapter(Context ctx) {
        mCtx = ctx;
    }

    public SQLiteAdapter open() throws SQLException {
        mDbHelper = new DatabaseHelper(mCtx);
        mDb = mDbHelper.getWritableDatabase();
        return this;
    }

    public void close() {
        mDbHelper.close();
    }

    public void update(String sql, Object[] bindArgs) {
        try {
            if (bindArgs == null) {
                mDb.execSQL(sql);
            } else {
                mDb.execSQL(sql, bindArgs);
            }

        } catch (Exception e) {
            Log.w(TAG, sql + "\n" + e.getMessage());
        }
    }

    public LinkedList<LinkedHashMap<String, String>> query(String sql, String[] selectionArgs) {
        LinkedList<LinkedHashMap<String, String>> rowset = new LinkedList<LinkedHashMap<String, String>>();

        Cursor result = null;

        try {
            result = mDb.rawQuery(sql, selectionArgs);
//			Log.e("SQLiteAdapter",""+result);
            if (result != null && result.moveToFirst()) {
                int columnCount = result.getColumnCount();
//				Log.e("SQLiteAdapter=columnCount  ",""+columnCount);
                do {
                    LinkedHashMap<String, String> row = new LinkedHashMap<String, String>();

                    for (int i = 0; i < columnCount; i++) {
                        result.getString(i);
                        row.put(((String) result.getColumnName(i)).toLowerCase(), AppUtils.checkString(result.getString(i), ""));
//						Log.e("SQLiteAdapter=row",""+row);
//						Log.e("NAME",result.getColumnName(i));
                    }

                    rowset.add(row);
                } while (result.moveToNext());
            }
        } catch (Exception e) {
            Log.w(TAG, sql + "\n" + e.getMessage());
        } finally {
            try {
                result.close();
            } catch (Exception ex) {
            }
        }

        return rowset;
    }

    public LinkedHashMap<String, String> queryRow(String sql, String[] selectionArgs) {
        Cursor result = null;
        LinkedHashMap<String, String> row = new LinkedHashMap<String, String>();
        try {
            result = mDb.rawQuery(sql, selectionArgs);
            if (result != null && result.moveToFirst()) {
                int columnCount = result.getColumnCount();
                for (int i = 0; i < columnCount; i++) {
                    result.getString(i);
                    row.put(((String) result.getColumnName(i)).toLowerCase(), AppUtils.checkString(result.getString(i), ""));
                }
            }
        } catch (Exception e) {
            Log.w(TAG, sql + "\n" + e.getMessage());
        } finally {
            try {
                result.close();
            } catch (Exception ex) {
            }
        }
        return row;
    }

    /**
     * 해당 테이블의 Row 수 반환 메소드
     *
     * @param sql           실행할 질의문
     * @param selectionArgs 값
     * @return 테이블의 Row 수 반환
     */
    public int getRowCount(String sql, String[] selectionArgs) {

        int count = 0;
        Cursor result = null;

        result = mDb.rawQuery(sql, selectionArgs);

        if (result != null && result.moveToFirst()) {
            count++;
        }
        while (result.moveToNext()) ;

        return count;
    }

    //헬퍼 이너클래스
    private class DatabaseHelper extends SQLiteOpenHelper {
        public DatabaseHelper(Context context) {
            super(context, DATABASE_NAME, null, DATABASE_VERSION);
        }

        public void onCreate(SQLiteDatabase db) {
            Log.e("@@ onCreate", "시작");
        }

        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
            Log.e("@@ onUpgrade", "DB 업데이트");
        }
    }
}
