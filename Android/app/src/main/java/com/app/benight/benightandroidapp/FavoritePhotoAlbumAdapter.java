package com.app.benight.benightandroidapp;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;

import com.parse.GetDataCallback;
import com.parse.ParseFile;
import com.parse.ParseImageView;
import com.parse.ParseQuery;
import com.parse.ParseQueryAdapter;

/**
 * Created by jeirgino on 26/05/15.
 */

public class FavoritePhotoAlbumAdapter extends ParseQueryAdapter<PhotoAlbum> {

    public FavoritePhotoAlbumAdapter(Context context) {
        super(context, new ParseQueryAdapter.QueryFactory<PhotoAlbum>() {
            public ParseQuery<PhotoAlbum> create() {
                // Here we can configure a ParseQuery to display
                // only top-rated meals.
                ParseQuery query = new ParseQuery("PhotoAlbum");
                return query;
            }
        });
    }

    @Override
    public View getItemView(PhotoAlbum photoAlbum, View v, ViewGroup parent) {

        if (v == null) {
            v = View.inflate(getContext(), R.layout.activity_photo_album, null);
        }

        super.getItemView(photoAlbum, v, parent);

        ParseImageView image = (ParseImageView) v.findViewById(R.id.img);
        ParseFile photoFile = photoAlbum.getParseFile("photo");
        if (photoFile != null) {
            image.setParseFile(photoFile);
            image.loadInBackground(new GetDataCallback() {
                @Override
                public void done(byte[] bytes, com.parse.ParseException e) {

                }
            });
        }

//        TextView titleTextView = (TextView) v.findViewById(R.id.text1);
  //      titleTextView.setText(photoAlbum.getTitle());
        return v;
    }

}