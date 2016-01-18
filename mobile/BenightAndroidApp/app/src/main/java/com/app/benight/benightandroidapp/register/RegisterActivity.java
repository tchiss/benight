package com.app.benight.benightandroidapp.register;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.app.benight.benightandroidapp.R;
import com.app.benight.benightandroidapp.homepage.HomepageActivity;
import com.parse.ParseACL;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseUser;
import com.parse.SignUpCallback;


public class RegisterActivity extends Activity {

    protected EditText  mUsername;
    protected EditText  mUserEmail;
    protected EditText  mUserPassword;
    protected Button    mRegisterButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        ParseObject.registerSubclass(ParseUser.class);
//        Parse.initialize(this, "KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT", "qayqlys4VkNJDQ06PUUa0aUp8i7g871mjFDmlyCb");
        ParseUser.enableAutomaticUser();
        ParseACL defaultACL = new ParseACL();
        defaultACL.setPublicReadAccess(true);
        ParseACL.setDefaultACL(defaultACL, true);

        // Initialize text fields
        mUsername = (EditText)findViewById(R.id.usernameRegisterEditText);
        mUserEmail = (EditText)findViewById(R.id.emailRegisterEditText);
        mUserPassword = (EditText)findViewById(R.id.passwordRegisterEditText);
        mRegisterButton = (Button)findViewById(R.id.registerButton);

        // Listen to register button click
        mRegisterButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                // Get username, password and email and convert to string
                String username = mUsername.getText().toString().trim();
                String password = mUserPassword.getText().toString().trim();
                String email = mUserEmail.getText().toString().trim();

                // Store user in parse
                ParseUser user = new ParseUser();
                user.setUsername(username);
                user.setPassword(password);
                user.setEmail(email);
                user.signUpInBackground(new SignUpCallback() {
                    @Override
                    public void done(ParseException e) {
                        if (e == null) {
                            // user signed up successfully
                            Toast.makeText(RegisterActivity.this, "Success", Toast.LENGTH_LONG).show();
                            Intent takeUserHome = new Intent(RegisterActivity.this, HomepageActivity.class);
                            startActivity(takeUserHome);
                        } else {
                            // there was an error
                            Toast.makeText(RegisterActivity.this, "Error Signing in", Toast.LENGTH_LONG).show();
                        }
                    }
                });
            }
        });
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_register, menu);
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
