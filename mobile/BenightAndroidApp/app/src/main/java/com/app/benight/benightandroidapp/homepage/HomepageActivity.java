package com.app.benight.benightandroidapp.homepage;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Toast;

import com.app.benight.benightandroidapp.R;
import com.app.benight.benightandroidapp.contact.ContactActivity;
import com.app.benight.benightandroidapp.login.LoginActivity;
import com.app.benight.benightandroidapp.music.SoundcloudActivity;
import com.app.benight.benightandroidapp.profile.ProfileActivity;
import com.app.benight.benightandroidapp.album.activities.GalleryPhotoActivity;
import com.parse.FindCallback;
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

//        StartParse new startParse(this);
//        Parse.initialize(this, "KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT", "qayqlys4VkNJDQ06PUUa0aUp8i7g871mjFDmlyCb");
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
        String[] modules = { "Profil", "Fil d'actualités", "Album Photo", "Calendrier", "Tickets", "Playlist", "Partenaires", "Aide", "Contact" };
        int[] icon = {R.drawable.icon_profile, R.drawable.icon_feeds, R.drawable.icon_album, R.drawable.icon_calendar, R.drawable.icon_qrcode, R.drawable.icon_soundcloud, R.drawable.icon_partner, R.drawable.icon_settings, R.drawable.icon_help, R.drawable.icon_contact};
        ImageView icone = (ImageView) findViewById(R.id.icon);
        //mAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, modules);
        mAdapter = new ArrayAdapter<String>(this, R.layout.custom_list_item, R.id.label, modules);
        mDrawerList.setAdapter(mAdapter);
        mDrawerList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                String item = parent.getItemAtPosition(position).toString();
                if (item.equals("Profil")) {
                    Intent takeUserToProfile = new Intent(HomepageActivity.this, ProfileActivity.class);
                    startActivity(takeUserToProfile);

                } else if (item.equals("Fil d'actualités")) {
                    Intent takeUserToHomepage = new Intent(HomepageActivity.this, HomepageActivity.class);
                    startActivity(takeUserToHomepage);

                } else if (item.equals("Album Photo")) {
                    Intent takeUserToAlbum = new Intent(HomepageActivity.this, GalleryPhotoActivity.class);
                    startActivity(takeUserToAlbum);

                } else if (item.equals("Playlist")) {
                    Intent takeUserToPlaylist = new Intent(HomepageActivity.this, SoundcloudActivity.class);
                    startActivity(takeUserToPlaylist);

                } else if (item.equals("Contact")) {
                    Intent takeUserToContact = new Intent(HomepageActivity.this, ContactActivity.class);
                    startActivity(takeUserToContact);

                } else {
                    Toast.makeText(HomepageActivity.this, "You clicked on" + item, Toast.LENGTH_SHORT).show();

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
