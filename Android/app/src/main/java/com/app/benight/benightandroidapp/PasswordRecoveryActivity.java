package com.app.benight.benightandroidapp;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.parse.ParseUser;
import com.parse.RequestPasswordResetCallback;


public class PasswordRecoveryActivity extends ActionBarActivity {

    protected Button mPasswordRecoveryBtn;
    protected EditText mEmail;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_password_recovery);
        // Initialize
        mPasswordRecoveryBtn = (Button)findViewById(R.id.submitPasswordRecovery);
        mEmail = (EditText)findViewById(R.id.emailRecovery);

        mPasswordRecoveryBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ParseUser.requestPasswordResetInBackground(mEmail.getText().toString(), new RequestPasswordResetCallback() {
                    @Override
                    public void done(com.parse.ParseException e) {
                        if (e == null) {
                            // An email was successfully sent with reset instructions.
                            // success
                            Toast.makeText(PasswordRecoveryActivity.this, "Please check your mail to reset your password", Toast.LENGTH_LONG).show();
                        } else {
                            // Something went wrong. Look at the ParseException to see what's up.
                            Toast.makeText(PasswordRecoveryActivity.this, "An error occurred, invalid mail", Toast.LENGTH_LONG).show();
                        }
                    }
                });
                Intent takeUserActivityLogin = new Intent(PasswordRecoveryActivity.this, LoginActivity.class);
                startActivity(takeUserActivityLogin);
            }
        });
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_password_recovery, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
