package com.app.benight.benightandroidapp.album.infrastructure;

import android.app.Application;

/**
 * Created by Jeirgino on 21/10/2015.
 */
public class IOCApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();    //To change body of overridden methods use File | Settings | File Templates.
//        RoboGuice.setBaseApplicationInjector(this, RoboGuice.DEFAULT_STAGE, RoboGuice.newDefaultRoboModule(this), new IOCModule());

    }
}