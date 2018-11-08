
/***
 * @author grapegirl
 * @version 1.1
 * @Class Name : MediaUtils.swift
 * @Description : 사운드 및 진동 관련 유틸
 * @since 2017.09.04
 */

class MediaUtils{
    
    init() {
       
    }
    
    /****
     * @param context 컨텍스트
     * @param time    초
     * @Description : 진동 울리기
     */
     public static func vibrate(time : CUnsignedLongLong) -> Void {
    // public static void vibrate(Context context, long time) {
    //     Vibrator vibrator = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);
    //     vibrator.vibrate(time);
    }

    /**
     * PDF 파일 열기
     *
     * @param context    컨텍스트
     * @param strPdfFile pdf 파일 경로
     */
    public static func showPdfFile(strPdfFile : String) -> Void {
    //     try {
    //         Uri apkUri = Uri.fromFile(new File(strPdfFile));
    //         Intent intent = new Intent(Intent.ACTION_VIEW);
    //         intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    //         intent.addCategory(Intent.CATEGORY_DEFAULT);
    //         intent.setDataAndType(apkUri, "application/pdf");
    //         context.startActivity(intent);
    //     } catch (Exception e) {
    //         e.printStackTrace();
    //     }
    }

    /**
     * 오디오 자동 재생 메소드
     *
     * @param context 컨텍스트
     * @param nAudio  오티오
     */
      public static func onAudioPlay(nAudio : Int) -> Void {
    //     try {
    //         RingtoneManager rm = new RingtoneManager(context);
    //         rm.setType(RingtoneManager.TYPE_NOTIFICATION);
    //         rm.getCursor();

    //         Uri notification = rm.getRingtoneUri(nAudio - 1);

    //         MediaPlayer m_pMediaPlayer = MediaPlayer.create(context, notification);
    //         m_pMediaPlayer.setLooping(false);
    //         m_pMediaPlayer.setOnSeekCompleteListener(new MediaPlayer.OnSeekCompleteListener() {
    //             @Override
    //             public void onSeekComplete(MediaPlayer mp) {
    //                 mp.stop();
    //             }
    //         });
    //         m_pMediaPlayer.start();
    //     } catch (Exception e) {
    //         e.printStackTrace();
    //     }
    }
}
