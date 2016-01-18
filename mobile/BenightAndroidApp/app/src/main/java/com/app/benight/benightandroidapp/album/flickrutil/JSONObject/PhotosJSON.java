package com.app.benight.benightandroidapp.album.flickrutil.JSONObject;

import com.app.benight.benightandroidapp.album.flickrutil.Sizes;

public class PhotosJSON extends FlickrBaseItemJSON {
    public Sizes getSizes() {
        return sizes;
    }

    public void setSizes(Sizes sizes) {
        this.sizes = sizes;
    }

    private Sizes sizes;
}
