package com.app.benight.benightandroidapp.booking;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.widget.ImageView;
import android.widget.TextView;

import com.app.benight.benightandroidapp.R;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.parse.ParseACL;
import com.parse.ParseUser;

public class BookingConfirmActivity extends ActionBarActivity {

    protected TextView mEventName;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_booking_confirm);

        //Parse.initialize(this, "KB0XBMX06SVCiUnSUKKgA52v2pee75nSGexrh0wT", "qayqlys4VkNJDQ06PUUa0aUp8i7g871mjFDmlyCb");
        ParseUser.enableAutomaticUser();
        ParseACL defaultACL = new ParseACL();
        defaultACL.setPublicReadAccess(true);
        ParseACL.setDefaultACL(defaultACL, true);
        ParseUser currentUser = ParseUser.getCurrentUser();

        Intent startingIntent = getIntent();
        final String fName = startingIntent.getStringExtra("eventAuthor");

        mEventName = (TextView)findViewById(R.id.EventNameBC);
        mEventName.setText(fName);

        QRCodeWriter writer = new QRCodeWriter();
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
        }
    }

}
