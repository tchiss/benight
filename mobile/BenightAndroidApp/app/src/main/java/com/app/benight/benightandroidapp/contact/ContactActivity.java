package com.app.benight.benightandroidapp.contact;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Toast;

import com.app.benight.benightandroidapp.R;
import com.app.benight.benightandroidapp.album.activities.GalleryPhotoActivity;
import com.app.benight.benightandroidapp.homepage.HomepageActivity;
import com.app.benight.benightandroidapp.music.SoundcloudActivity;
import com.app.benight.benightandroidapp.profile.ProfileActivity;

public class ContactActivity extends ActionBarActivity {
    private ListView mDrawerList;
    private ArrayAdapter<String> mAdapter;
    Intent intent = null, chooser =null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_contact);
        mDrawerList = (ListView)findViewById(R.id.navList);
        addDrawerItems();

        Button mEmail = (Button)findViewById(R.id.mail_button);
        mEmail.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                intent = new Intent(Intent.ACTION_SEND);
                intent.setData(Uri.parse(Intent.ACTION_VIEW));
                String[] to = {"contact@benight.cc"};
                intent.putExtra(Intent.EXTRA_EMAIL, to);
                intent.putExtra(Intent.EXTRA_SUBJECT, "Demande d'utilisateur Benight");
                intent.putExtra(Intent.EXTRA_TEXT, "");
                intent.setType("message/rfc822");
                chooser = Intent.createChooser(intent, "send Email");
                startActivity(chooser);
            }
        });
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
                    Intent takeUserToProfile = new Intent(ContactActivity.this, ProfileActivity.class);
                    startActivity(takeUserToProfile);

                } else if (item.equals("Fil d'actualités")) {
                    Intent takeUserToHomepage = new Intent(ContactActivity.this, HomepageActivity.class);
                    startActivity(takeUserToHomepage);

                } else if (item.equals("Album Photo")) {
                    Intent takeUserToAlbum = new Intent(ContactActivity.this, GalleryPhotoActivity.class);
                    startActivity(takeUserToAlbum);

                } else if (item.equals("Playlist")) {
                    Intent takeUserToPlaylist = new Intent(ContactActivity.this, SoundcloudActivity.class);
                    startActivity(takeUserToPlaylist);

                } else if (item.equals("Contact")) {
                    Intent takeUserToContact = new Intent(ContactActivity.this, ContactActivity.class);
                    startActivity(takeUserToContact);

                } else {
                    Toast.makeText(ContactActivity.this, "" + item, Toast.LENGTH_SHORT).show();

                }
            }
        });
    }
}