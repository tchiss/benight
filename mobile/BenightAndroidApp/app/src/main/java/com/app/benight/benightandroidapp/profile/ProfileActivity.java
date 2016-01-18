package com.app.benight.benightandroidapp.profile;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Toast;

import com.app.benight.benightandroidapp.R;
import com.app.benight.benightandroidapp.album.activities.GalleryPhotoActivity;
import com.app.benight.benightandroidapp.homepage.HomepageActivity;
import com.app.benight.benightandroidapp.music.SoundcloudActivity;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;


public class ProfileActivity extends FragmentActivity {


    protected EditText  firstname;
    protected EditText  lastname;
    protected Button    saveButton;
    private ListView mDrawerList;
    private ArrayAdapter<String> mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);
        mDrawerList = (ListView)findViewById(R.id.navList);
        addDrawerItems();

        firstname = (EditText)findViewById(R.id.firstNameEditText);
        saveButton = (Button)findViewById(R.id.saveButton);

        ParseQuery<ParseObject> query = ParseQuery.getQuery("User");

        saveButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (firstname.getText().toString() == "Firstname") {
                    return;
                } else {
                    ParseObject user = new ParseUser();
                    user.put("name", firstname.getText().toString());
                    user.put("lastname", firstname.getText().toString());
//                    user.pinInBackground();
                }
            }
        });
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_profile, menu);
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
                    Intent takeUserToProfile = new Intent(ProfileActivity.this, ProfileActivity.class);
                    startActivity(takeUserToProfile);

                } else if (item.equals("Fil d'actualités")) {
                    Intent takeUserToHomepage = new Intent(ProfileActivity.this, HomepageActivity.class);
                    startActivity(takeUserToHomepage);

                } else if (item.equals("Album Photo")) {
                    Intent takeUserToAlbum = new Intent(ProfileActivity.this, GalleryPhotoActivity.class);
                    startActivity(takeUserToAlbum);

                } else if (item.equals("Playlist")) {
                    Intent takeUserToPlaylist = new Intent(ProfileActivity.this, SoundcloudActivity.class);
                    startActivity(takeUserToPlaylist);

                } else {
                    Toast.makeText(ProfileActivity.this, "You clicked on" + item, Toast.LENGTH_SHORT).show();

                }
            }
        });
    }
}
