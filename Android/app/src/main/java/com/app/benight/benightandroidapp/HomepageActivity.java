package com.app.benight.benightandroidapp;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import com.parse.FindCallback;
import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.List;


public class HomepageActivity extends ListActivity {

    protected List<ParseObject> mEvent;
    private ListView mDrawerList;
    private ArrayAdapter<String> mAdapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_homepage);
        mDrawerList = (ListView)findViewById(R.id.navList);
        addDrawerItems();

        Parse.initialize(this, "KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT", "qayqlys4VkNJDQ06PUUa0aUp8i7g871mjFDmlyCb");
        ParseUser.enableAutomaticUser();
        ParseACL defaultACL = new ParseACL();
        defaultACL.setPublicReadAccess(true);
        ParseACL.setDefaultACL(defaultACL, true);
        ParseUser currentUser = ParseUser.getCurrentUser();
        if (currentUser != null) {
            // do stuff with the user
            ParseQuery<ParseObject> query = new ParseQuery<ParseObject>("Event");
            query.orderByDescending("createdAt");
            query.findInBackground(new FindCallback<ParseObject>() {
                @Override
                public void done(List<ParseObject> event, ParseException e) {
                    if (e == null) {
                        // Success
                        mEvent = event;
                        StatusAdapter adapter = new StatusAdapter(getListView().getContext(), mEvent);
                        setListAdapter(adapter);
                    } else {
                        // Problem Alert user
                    }
                }
            });
        } else {
            // show the signup or login screen
            Intent takeUserToLoginScreen = new Intent(this, LoginActivity.class);
            startActivity(takeUserToLoginScreen);
        }
    }

    private void addDrawerItems() {
        String[] modules = { "Profile", "Feed", "Album", "Calendar", "Tickets", "Playlist", "Partners", "Settings", "Help", "About" };
        mAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, modules);
        mDrawerList.setAdapter(mAdapter);
        mDrawerList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                String item = parent.getItemAtPosition(position).toString();
                switch(item){
                    case "Profile":
                        Intent takeUserToProfile = new Intent(HomepageActivity.this, ProfileActivity.class);
                        startActivity(takeUserToProfile);
                        break;
                    case "Feed":
                        Intent takeUserToHomepage = new Intent(HomepageActivity.this, HomepageActivity.class);
                        startActivity(takeUserToHomepage);
                        break;
                    case "Album":
                        Intent takeUserToAlbum = new Intent(HomepageActivity.this, PhotoAlbumActivity.class);
                        startActivity(takeUserToAlbum);
                        break;
                    default:
                        Toast.makeText(HomepageActivity.this, "You clicked on" + item, Toast.LENGTH_SHORT).show();
                        break;
                }
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_homepage, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        switch (id) {
            case R.id.reloadFeed:
                //Parse
                break;
            case R.id.logoutUser:
                ParseUser.logOut();
                Intent takeUserToLogin = new Intent(this, LoginActivity.class);
                startActivity(takeUserToLogin);
                break;
        }
        return super.onOptionsItemSelected(item);
    }
}
