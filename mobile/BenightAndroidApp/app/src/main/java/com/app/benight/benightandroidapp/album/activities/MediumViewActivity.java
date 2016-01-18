package com.app.benight.benightandroidapp.album.activities;

import android.os.Bundle;
import android.support.v4.view.ViewPager;

import com.app.benight.benightandroidapp.R;
import com.app.benight.benightandroidapp.album.adapters.MediumViewAdapter;
import com.app.benight.benightandroidapp.album.interfaces.ICurrentAppData;

import javax.inject.Inject;

import roboguice.activity.RoboActivity;
import roboguice.inject.InjectView;

/**
 * Created by Jeirgino on 21/10/2015.
 */
public class MediumViewActivity extends RoboActivity {
    @InjectView(R.id.pager)
    private ViewPager viewPager;
    @Inject
    ICurrentAppData currentAppData;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_medium_view);

        MediumViewAdapter mediumViewAdapter = new MediumViewAdapter(MediumViewActivity.this);
        viewPager.setAdapter(mediumViewAdapter);
        viewPager.setCurrentItem(currentAppData.getCurrentPosition());
    }
}