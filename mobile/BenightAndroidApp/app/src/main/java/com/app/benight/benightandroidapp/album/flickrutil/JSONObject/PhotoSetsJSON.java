package com.app.benight.benightandroidapp.album.flickrutil.JSONObject;

import com.app.benight.benightandroidapp.album.flickrutil.PhotoSet;

public class PhotoSetsJSON extends FlickrBaseItemJSON {
    public PhotoSet getPhotoset() {
        return photoset;
    }

    public void setPhotoset(PhotoSet photoset) {
        this.photoset = photoset;
    }

    private PhotoSet photoset;


}
