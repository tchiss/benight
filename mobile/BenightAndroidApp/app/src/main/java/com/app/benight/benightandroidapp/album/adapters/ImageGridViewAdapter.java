package com.app.benight.benightandroidapp.album.adapters;

import android.app.Activity;
import android.content.Intent;
import android.database.DataSetObserver;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.ListAdapter;

import com.app.benight.benightandroidapp.album.activities.MediumViewActivity;
import com.app.benight.benightandroidapp.album.interfaces.ICurrentAppData;

import javax.inject.Inject;

import roboguice.RoboGuice;

/**
 * Created by Jeirgino on 21/10/2015.
 */
public class ImageGridViewAdapter implements ListAdapter {

    @Inject
    ICurrentAppData currentAppData;
    private Activity activity;


    public ImageGridViewAdapter(Activity activity) {
        RoboGuice.getInjector(activity).injectMembers(this);
        this.activity = activity;
    }

    @Override
    public void registerDataSetObserver(DataSetObserver observer) {

    }

    @Override
    public void unregisterDataSetObserver(DataSetObserver observer) {

    }

    @Override
    public int getCount() {
        return currentAppData.getImageInfos().size();
    }

    @Override
    public Object getItem(int position) {
        return currentAppData.getImageInfos().get(position).getThumbnailBitmap();
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public boolean hasStableIds() {
        return false;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ImageView result;
        if (convertView == null)
            result = new ImageView(activity);
        else
            result = (ImageView) convertView;


        result.setScaleType(ImageView.ScaleType.CENTER);
        result.setImageBitmap(currentAppData.getImageInfos().get(position).getThumbnailBitmap());
        result.setOnClickListener(new ImageGridViewCellOnClickListener(position));

        return result;
    }

    @Override
    public int getItemViewType(int position) {
        return 0;
    }

    @Override
    public int getViewTypeCount() {
        return 1;
    }

    @Override
    public boolean isEmpty() {
        return false;
    }

    @Override
    public boolean areAllItemsEnabled() {
        return false;
    }

    @Override
    public boolean isEnabled(int position) {
        return false;
    }

    class ImageGridViewCellOnClickListener implements View.OnClickListener {
        private int position;

        public ImageGridViewCellOnClickListener(int position) {
            this.position = position;
        }

        @Override
        public void onClick(View v) {
            currentAppData.setCurrentPosition(position);
            Intent intent = new Intent(activity, MediumViewActivity.class);
            activity.startActivity(intent);
        }
    }
}
