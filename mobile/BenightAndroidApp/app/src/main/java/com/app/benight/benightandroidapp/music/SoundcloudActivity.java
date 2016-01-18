package com.app.benight.benightandroidapp.music;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.webkit.WebView;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Toast;

import com.app.benight.benightandroidapp.R;
import com.app.benight.benightandroidapp.album.activities.GalleryPhotoActivity;
import com.app.benight.benightandroidapp.contact.ContactActivity;
import com.app.benight.benightandroidapp.homepage.HomepageActivity;
import com.app.benight.benightandroidapp.profile.ProfileActivity;

public class SoundcloudActivity extends FragmentActivity {

    private ListView mDrawerList;
    private ArrayAdapter<String> mAdapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_soundcloud);
        WebView myWebView = (WebView) findViewById(R.id.webView);

        mDrawerList = (ListView)findViewById(R.id.navList);
        addDrawerItems();

        String id = "2bXIwoMXcx";
        String authKey = "TheIslandOfMusic";
        String url="http://tickets.benight.cc/soundcloud.php?ObjectId=" + id + "&authKey=" + authKey;
        myWebView.loadUrl(url);
        myWebView.getSettings().setJavaScriptEnabled(true);
        myWebView.getSettings().setAllowFileAccess(true);
        myWebView.getSettings().setBlockNetworkImage(false);
        myWebView.getSettings().setLoadsImagesAutomatically(true);
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
                    Intent takeUserToProfile = new Intent(SoundcloudActivity.this, ProfileActivity.class);
                    startActivity(takeUserToProfile);

                } else if (item.equals("Fil d'actualités")) {
                    Intent takeUserToHomepage = new Intent(SoundcloudActivity.this, HomepageActivity.class);
                    startActivity(takeUserToHomepage);

                } else if (item.equals("Album Photo")) {
                    Intent takeUserToAlbum = new Intent(SoundcloudActivity.this, GalleryPhotoActivity.class);
                    startActivity(takeUserToAlbum);

                } else if (item.equals("Playlist")) {
                    Intent takeUserToPlaylist = new Intent(SoundcloudActivity.this, SoundcloudActivity.class);
                    startActivity(takeUserToPlaylist);

                } else if (item.equals("Contact")) {
                    Intent takeUserToContact = new Intent(SoundcloudActivity.this, ContactActivity.class);
                    startActivity(takeUserToContact);

                } else {
                    Toast.makeText(SoundcloudActivity.this, "You clicked on" + item, Toast.LENGTH_SHORT).show();

                }
            }
        });
    }

}
