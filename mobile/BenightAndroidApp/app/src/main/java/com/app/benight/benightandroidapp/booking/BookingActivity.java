package com.app.benight.benightandroidapp.booking;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.os.Environment;
import android.support.v4.app.FragmentActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.app.benight.benightandroidapp.R;
import com.app.benight.benightandroidapp.album.activities.GalleryPhotoActivity;
import com.app.benight.benightandroidapp.homepage.HomepageActivity;
import com.app.benight.benightandroidapp.music.SoundcloudActivity;
import com.app.benight.benightandroidapp.profile.ProfileActivity;
import com.parse.ParseACL;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

public class BookingActivity extends FragmentActivity {

    protected TextView mEventName;
    protected TextView mEventDetails;
    protected TextView  mMap;
    protected Button   mBookButton;
    private ListView mDrawerList;
    protected ImageView mImg;
    private ArrayAdapter<String> mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_booking);
        mDrawerList = (ListView)findViewById(R.id.navList);
        addDrawerItems();

//        Parse.initialize(this, "KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT", "qayqlys4VkNJDQ06PUUa0aUp8i7g871mjFDmlyCb");
        ParseUser.enableAutomaticUser();
        ParseACL defaultACL = new ParseACL();
        defaultACL.setPublicReadAccess(true);
        ParseACL.setDefaultACL(defaultACL, true);
        ParseUser currentUser = ParseUser.getCurrentUser();

        mEventName = (TextView)findViewById(R.id.EventName);
        mEventDetails = (TextView)findViewById(R.id.EventDetails);
        mMap = (TextView)findViewById(R.id.MapId);
        mImg = (ImageView)findViewById(R.id.img_club);
        mImg.setImageResource(R.drawable.img_club_benight);
        Intent startingIntent = getIntent();
        final String fName = startingIntent.getStringExtra("clubName");
        final String mEventDescription = startingIntent.getStringExtra("eventDetails");
        final String mEventDate = startingIntent.getStringExtra("eventDate");
        final String mEventAuthor = startingIntent.getStringExtra("eventAuthor");
        final String mEventLocation = startingIntent.getStringExtra("eventLocation");
        final String mEventTheme = startingIntent.getStringExtra("eventTheme");
        final ParseObject mEvent = (ParseObject) startingIntent.getParcelableExtra("eventExtra");
        final TextView mEventName = (TextView) findViewById(R.id.EventName);
        mEventName.setText(fName);
        final TextView mEventDetails = (TextView) findViewById(R.id.EventDetails);
        mEventDetails.setText("Le " + mEventDate +
                " : " + mEventDescription);

        mMap.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent takeUserToMap = new Intent(BookingActivity.this, BookingConfirmActivity.class);
                startActivity(takeUserToMap);
            }
        });
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
                Intent takeUserToBookingConfirm = new Intent(BookingActivity.this, BookingConfirmActivity.class);

                takeUserToBookingConfirm.putExtra("eventAuthor", fName);
                startActivity(takeUserToBookingConfirm);


                Bitmap bitmap;
                OutputStream output;

                // Retrieve the image from the res folder
                bitmap = BitmapFactory.decodeResource(getResources(), R.id.img_result_qr);

                // Find the SD Card path
                File filepath = Environment.getExternalStorageDirectory();

                // Create a new folder in SD Card
                File dir = new File(filepath.getAbsolutePath()
                        + "/Save Image Tutorial/");
                dir.mkdirs();

                // Create a name for the saved image
                File file = new File(dir, "myimage.png");

                // Show a toast message on successful save
                Toast.makeText(BookingActivity.this, "Image Saved to SD Card",
                        Toast.LENGTH_SHORT).show();
                try {

                    output = new FileOutputStream(file);

                    // Compress into png format image from 0% - 100%
                    bitmap.compress(Bitmap.CompressFormat.PNG, 100, output);
                    output.flush();
                    output.close();
                }

                catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        });

        /*QRCodeWriter writer = new QRCodeWriter();
        try {
            BitMatrix bitMatrix = writer.encode("User: " + currentUser.getUsername().toString() + " Event: " + fName, BarcodeFormat.QR_CODE, 512, 512);
            int width = bitMatrix.getWidth();
            int height = bitMatrix.getHeight();
            Bitmap bmp = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565);
            for (int x = 50; x < width - 50; x++) {
                for (int y = 50; y < height - 50; y++) {
                    bmp.setPixel(x, y, bitMatrix.get(x, y) ? Color.DKGRAY : Color.WHITE);
                }
            }
            ((ImageView) findViewById(R.id.img_result_qr)).setImageBitmap(bmp);

        } catch (WriterException e) {
            e.printStackTrace();
        }*/
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
                    Intent takeUserToProfile = new Intent(BookingActivity.this, ProfileActivity.class);
                    startActivity(takeUserToProfile);

                } else if (item.equals("Fil d'actualités")) {
                    Intent takeUserToHomepage = new Intent(BookingActivity.this, HomepageActivity.class);
                    startActivity(takeUserToHomepage);

                } else if (item.equals("Album Photo")) {
                    Intent takeUserToAlbum = new Intent(BookingActivity.this, GalleryPhotoActivity.class);
                    startActivity(takeUserToAlbum);

                } else if (item.equals("Playlist")) {
                    Intent takeUserToPlaylist = new Intent(BookingActivity.this, SoundcloudActivity.class);
                    startActivity(takeUserToPlaylist);

                } else {
                    Toast.makeText(BookingActivity.this, "You clicked on" + item, Toast.LENGTH_SHORT).show();

                }
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