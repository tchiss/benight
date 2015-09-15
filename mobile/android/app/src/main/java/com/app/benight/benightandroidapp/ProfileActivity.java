package com.app.benight.benightandroidapp;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;


public class ProfileActivity extends ActionBarActivity {


    private ListView mDrawerList;
    private ArrayAdapter<String> mAdapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);
        mDrawerList = (ListView)findViewById(R.id.navList);
        addDrawerItems();
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
        String[] modules = { "Profile", "Feed", "Album", "Calendar", "Tickets", "Playlist", "Partners", "Settings", "Help", "About" };
        mAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, modules);
        mDrawerList.setAdapter(mAdapter);
        mDrawerList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                String item = parent.getItemAtPosition(position).toString();
                switch(item){
                    case "Profile":
                        Intent takeUserToProfile = new Intent(ProfileActivity.this, ProfileActivity.class);
                        startActivity(takeUserToProfile);
                        break;
                    case "Feed":
                        Intent takeUserToHomepage = new Intent(ProfileActivity.this, HomepageActivity.class);
                        startActivity(takeUserToHomepage);
                        break;
                    case "Album":
                        Intent takeUserToAlbum = new Intent(ProfileActivity.this, ProfileActivity.class);
                        startActivity(takeUserToAlbum);
                        break;
                    default:
                        Toast.makeText(ProfileActivity.this, "You clicked on" + item, Toast.LENGTH_SHORT).show();
                        break;
                }
            }
        });
    }
}
