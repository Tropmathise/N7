package fr.enseeiht.tsadurni.player;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.net.URI;

public class PlayerActivity extends AppCompatActivity implements SurfaceHolder.Callback {
    private static final int SELECT_VIDEO = 100;
    private static Uri stringuri;
    private MediaPlayer mediaPlayer = new MediaPlayer();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button getVideo = (Button) findViewById(R.id.button);
        Button playVideo = (Button) findViewById(R.id.button2);
        Button playfromstart = (Button) findViewById(R.id.button3);
        TextView vid = (TextView) findViewById(R.id.textView2);
        SurfaceView surfaceview = (SurfaceView) findViewById(R.id.surfaceView);
        SurfaceHolder surfaceHolder = surfaceview.getHolder();
        surfaceHolder.addCallback(this);
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.HONEYCOMB){
            surfaceHolder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
        }

        getVideo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Video.Media.EXTERNAL_CONTENT_URI);
                intent.setType("video/*");
                startActivityForResult(intent,SELECT_VIDEO);
            }
        });
        playVideo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent PVintent = new Intent(Intent.ACTION_VIEW);
                PVintent.setData(stringuri);
                startActivity(PVintent);
            }
        });
        playfromstart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                
            }
        });
        }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
        super.onActivityResult(resultCode, resultCode, intent);

        if (requestCode == SELECT_VIDEO && resultCode==RESULT_OK){
            TextView uri = (TextView) findViewById(R.id.textView);
            stringuri=intent.getData();
            uri.setText(stringuri.toString());
        }
    }

    @Override
    public void surfaceCreated(@NonNull SurfaceHolder holder) {
        mediaPlayer.setDisplay(holder);
    }

    @Override
    public void surfaceChanged(@NonNull SurfaceHolder holder, int format, int width, int height) {

    }

    @Override
    public void surfaceDestroyed(@NonNull SurfaceHolder holder) {

    }
}