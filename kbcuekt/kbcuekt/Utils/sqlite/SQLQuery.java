package momo.kikiplus.com.kbucket.Utils.sqlite;

import android.content.Context;

import java.util.LinkedHashMap;
import java.util.LinkedList;

import momo.kikiplus.com.kbucket.Utils.KLog;

public class SQLQuery {
    private final String TAG = this.getClass().getSimpleName();

    SQLiteAdapter mDBAdapter = null;

    private String sql = "";

    public void SQLQuery() {

        KLog.d(TAG, "@@ create Table 생성자");
    }

    private final String TABLE_MEMO = "KMEMO";
    private final String TABLE_USER = "KUSER";
    private final String TABLE_CHAT = "KCHAT";

    /**
     * 테이블생성
     */
    public void createTable(Context context) {
        KLog.d(TAG, "@@ create Table 생성");
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "CREATE TABLE IF NOT EXISTS " + TABLE_MEMO + "(" +
                    "CONTENTS TEXT, " +
                    "DATE TEXT, " +
                    "COMPLETE_YN TEXT, " +
                    "COMPLETE_DATE TEXT," +
                    "IMAGE_PATH TEXT)";

            mDBAdapter.update(sql, null);

            sql = "ALTER TABLE " + TABLE_MEMO +
                    " ADD COLUMN DEADLINE TEXT";

            mDBAdapter.update(sql, null);

            sql = "CREATE TABLE IF NOT EXISTS " + TABLE_USER + "(" +
                    "NICKNAME TEXT, " +
                    "PHONE TEXT, " +
                    "AGE TEXT, " +
                    "GENDER TEXT, " +
                    "JOB TEXT, " +
                    "COUNTRY TEXT)";

            mDBAdapter.update(sql, null);
            mDBAdapter.close();
            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ createTable 테이블 생성 실패" + e.toString());
        }
    }

    public LinkedList<LinkedHashMap<String, String>> selectKbucket(Context context) {
        LinkedList<LinkedHashMap<String, String>> userInfoRow = null;
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "SELECT * FROM " + TABLE_MEMO;

            userInfoRow = mDBAdapter.query(sql, null);

            mDBAdapter.close();
            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 메모 정보 가져오기 복수건 오류");
        }

        return userInfoRow;
    }

    public LinkedHashMap<String, String> selectKbucket(Context context, String memoContents) {
        LinkedHashMap<String, String> userInfoRow = null;
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "SELECT * FROM " + TABLE_MEMO + " WHERE CONTENTS = ? ";

            String[] bindArgs = {memoContents};

            userInfoRow = mDBAdapter.queryRow(sql, bindArgs);

            mDBAdapter.close();
            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 메모 정보 가져오기 단건 오류");
        }
        return userInfoRow;
    }

    public boolean containsKbucket(Context context, String memoContents) {
        LinkedHashMap<String, String> userInfoRow = null;
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "SELECT * FROM " + TABLE_MEMO + " WHERE CONTENTS = ? ";

            String[] bindArgs = {memoContents};

            userInfoRow = mDBAdapter.queryRow(sql, bindArgs);

            mDBAdapter.close();
            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 메모 정보 가져오기 단건 오류");
        }

        if (userInfoRow != null && userInfoRow.size() > 0) {
            return true;
        }
        return false;
    }

    /**
     * 사용자 정보 insert 메소드
     *
     * @param context       컨텍스트
     * @param contents      내용
     * @param date          날짜
     * @param completeYN    완료여부
     * @param completedDate 완료된 날짜
     */
    public boolean insertUserSetting(Context context, String contents, String date, String completeYN, String completedDate) {
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "INSERT INTO  " + TABLE_MEMO +
                    "			(CONTENTS, DATE, COMPLETE_DATE, COMPLETE_YN) " +
                    "	 VALUES (?,?,?,?); ";

            Object[] bindArgs = {contents, date, completedDate, completeYN};

            mDBAdapter.update(sql, bindArgs);

            //입력후 결과 보기
            //sql = "SELECT * FROM " + TABLE_MEMO;
            //LinkedList<LinkedHashMap<String, String>> userInfoRowsetCheck = mDBAdapter.query(sql, null);
            //KLog.d(TAG, "@@ result-> " + userInfoRowsetCheck + "");

            mDBAdapter.close();

            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ insertUserInfo 유저정보 입력 실패" + e.toString());
            return false;
        }
        return true;
    }

    /**
     * 메모 내용 업데이트 (수정)
     *
     * @param context     컨텍스트
     * @param contents    내용
     * @param newContents 새로운 내용
     */
    public void updateMemoContent(Context context, String contents, String newContents) {
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "UPDATE  " + TABLE_MEMO +
                    " SET CONTENTS = ? WHERE CONTENTS = ?";

            Object[] bindArgs = {newContents, contents};

            mDBAdapter.update(sql, bindArgs);
            mDBAdapter.close();

            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 사용자 메모 정보 내용으로 업데이트 오류" + e.toString());
        }
    }

    /**
     * 메모 내용 업데이트 (수정)
     *
     * @param context     컨텍스트
     * @param contents    내용
     * @param newContents 새로운 내용
     * @param completeYn  완료여부(Y/N)
     * @param date        완료날짜
     */
    public void updateMemoContent(Context context, String contents, String newContents, String completeYn, String date, String imagePath) {
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "UPDATE  " + TABLE_MEMO +
                    " SET CONTENTS = ? , COMPLETE_YN = ?, DATE = ? , IMAGE_PATH = ? WHERE CONTENTS = ?";

            Object[] bindArgs = {newContents, completeYn, date, imagePath, contents};

            mDBAdapter.update(sql, bindArgs);
            KLog.d(this.getClass().getSimpleName(), "@@사용자 메모 정보 내용으로 업데이트 sql : " + sql);
            mDBAdapter.close();

            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 사용자 메모 정보 내용으로 업데이트 오류" + e.toString());
        }
    }

    /**
     * 메모 내용 업데이트 (수정)
     */
    public void updateMemoContent(Context context, String contents, String newContents, String completeYn, String date, String imagePath, String deadline) {
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "UPDATE  " + TABLE_MEMO +
                    " SET CONTENTS = ? , COMPLETE_YN = ?, DATE = ? , IMAGE_PATH = ?, DEADLINE = ? WHERE CONTENTS = ?";

            Object[] bindArgs = {newContents, completeYn, date, imagePath, deadline, contents};

            mDBAdapter.update(sql, bindArgs);
            KLog.d(this.getClass().getSimpleName(), "@@사용자 메모 정보 내용으로 업데이트 sql : " + sql);
            mDBAdapter.close();

            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 사용자 메모 정보 내용으로 업데이트 오류" + e.toString());
        }
    }

    /**
     * 사용자 닉네임 업데이트 메소드
     *
     * @param context  컨텍스트
     * @param nickanme 업데이트 할 닉네임
     */
    public void updateUserNickName(Context context, String nickanme) {
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "UPDATE  " + TABLE_USER +
                    " SET NICKNAME = ?";

            Object[] bindArgs = {nickanme};

            mDBAdapter.update(sql, bindArgs);
            mDBAdapter.close();

            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 사용자 닉네임 설정 정보 업데이트 오류" + e.toString());
        }
    }

    /**
     * 사용자 정보 테이블 내용 검색하기
     *
     * @param context 컨텍스트
     * @return 사용자 정보 반환
     */
    public LinkedHashMap<String, String> selectUserTable(Context context) {
        LinkedHashMap<String, String> userInfoRow = null;
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "SELECT NICKNAME, PHONE, AGE, GENDER, JOB, COUNTRY FROM " + TABLE_USER + ";";

            userInfoRow = mDBAdapter.queryRow(sql, null);

            mDBAdapter.close();
            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 메모 정보 가져오기 단건 오류" + e.toString());
        }

        return userInfoRow;
    }

    /**
     * 사용자 정보 설정 삭제
     *
     * @param context 컨텍스트
     */
    public void deleteUserBucket(Context context, String contents) {
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "DELETE FROM " + TABLE_MEMO +
                    " WHERE CONTENTS = '" + contents + "';";

            mDBAdapter.queryRow(sql, null);
            mDBAdapter.close();

            mDBAdapter = null;
            //KLog.d(TAG, "@@ 유저 설정 정보 삭제 sql : " + sql);
        } catch (Exception e) {
            KLog.d(TAG, "@@ 유저 설정 정보 삭제 오류" + e.toString());
        }
    }

    public void createChatTable(Context context) {
        KLog.d(TAG, "@@ create Chat Table 생성");
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "CREATE TABLE IF NOT EXISTS " + TABLE_CHAT + "(" + "CONTENTS TEXT, " + "DATE TEXT, "
                    + "NICKNAME TEXT, " + "IMAGE_PATH TEXT, SEQ TEXT, CHAT_IDX TEXT)";

            mDBAdapter.update(sql, null);
            mDBAdapter.close();
            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 테이블 생성 실패" + e.toString());
        }

    }

    /**
     * 채팅 정보 insert 메소드
     *
     * @param context  컨텍스트
     * @param contents 내용
     * @param date     날짜
     */
    public void insertChatting(Context context, String contents, String date, String nickname, String imagePath, String seq, String chatId) {
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "INSERT INTO  " + TABLE_CHAT
                    + "(CONTENTS, DATE, NICKNAME, IMAGE_PATH, SEQ, CHAT_IDX) "
                    + "VALUES (?,?,?,?,?,?); ";

            Object[] bindArgs = {contents, date, nickname, imagePath, seq, chatId};

            mDBAdapter.update(sql, bindArgs);

            // 입력후 결과 보기
            sql = "SELECT * FROM " + TABLE_CHAT;
            LinkedList<LinkedHashMap<String, String>> userInfoRowsetCheck = mDBAdapter.query(sql, null);
            KLog.d(TAG, "@@ userChatInfoRowsetCheck userInfoRowsetCheck : " + userInfoRowsetCheck);
            mDBAdapter.close();
            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 채팅정보 입력 실패" + e.toString());
        }
    }

    /**
     * 채팅 테이블 내용 검색하기
     *
     * @param context 컨텍스트
     * @param chatIdx 채팅방 번호
     * @return 채팅 내용
     */
    public LinkedList<LinkedHashMap<String, String>> selectChatTable(Context context, String chatIdx) {
        LinkedList<LinkedHashMap<String, String>> userInfoRow = null;
        try {
            mDBAdapter = new SQLiteAdapter(context);
            mDBAdapter.open();

            sql = "SELECT NICKNAME, CONTENTS, DATE, IMAGE_PATH, SEQ FROM " + TABLE_CHAT + " WHERE CHAT_IDX = ? ;";

            String[] bindArgs = {chatIdx};

            userInfoRow = mDBAdapter.query(sql, bindArgs);

            mDBAdapter.close();
            mDBAdapter = null;

        } catch (Exception e) {
            KLog.d(TAG, "@@ 채팅 정보 가져오기 단건 오류" + e.toString());
        }

        return userInfoRow;
    }

}