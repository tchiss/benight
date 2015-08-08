package com.app.benight.benightandroidapp;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;


public class BookingActivity extends ActionBarActivity {

    protected TextView mEventName;
    protected Button   mBookButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_booking);

        Parse.initialize(this, "KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT", "qayqlys4VkNJDQ06PUUa0aUp8i7g871mjFDmlyCb");
        ParseUser.enableAutomaticUser();
        ParseACL defaultACL = new ParseACL();
        defaultACL.setPublicReadAccess(true);
        ParseACL.setDefaultACL(defaultACL, true);
        ParseUser currentUser = ParseUser.getCurrentUser();

        mEventName = (TextView)findViewById(R.id.EventName);
        Intent startingIntent = getIntent();
        //final String fName = startingIntent.getStringExtra("clubName");
        final ParseObject mEvent = (ParseObject) startingIntent.getParcelableExtra("eventExtra");
        final TextView mEventName = (TextView) findViewById(R.id.EventName);
        mEventName.setText("EEE");

        mBookButton = (Button)findViewById(R.id.bookingButton);

        if (currentUser != null && mEvent != null) {
            ParseObject reservation = new ParseObject("Reservation");
            reservation.put("Event", mEvent);
            reservation.put("User", currentUser);
            reservation.saveInBackground();
        } else {
            System.out.println("Error during reservation process!");
        }

        mBookButton.setOnClickListener(new View.OnClickListener() {
            ParseUser currentUser = ParseUser.getCurrentUser();

            ParseQuery<ParseObject> query = ParseQuery.getQuery("Event");

            @Override
            public void onClick(View v) {
                onBookClick((ParseObject) mEvent, currentUser);
            }
        });
    }

    private void onBookClick(ParseObject mEventName, ParseUser currentUser) {
        if (currentUser != null && mEventName != null) {
            ParseObject reservation = new ParseObject("Reservation");
            reservation.put("Event", mEventName);
            reservation.put("User", currentUser);
            reservation.saveInBackground();
        } else {
            System.out.println("Error during reservation process!");
        }
    }
}