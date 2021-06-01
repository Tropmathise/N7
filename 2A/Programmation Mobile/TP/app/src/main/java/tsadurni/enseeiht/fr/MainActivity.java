package tsadurni.enseeiht.fr;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "Browser Activity";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button go = (Button) findViewById(R.id.button);
        Log.d(TAG, "Oncreate() called");
        go.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                EditText address =(EditText) findViewById(R.id.n7);
                Intent web = new Intent(Intent.ACTION_VIEW);
                web.setData(Uri.parse(address.getText().toString()));
                startActivity(web);
            }
        });
    }
}