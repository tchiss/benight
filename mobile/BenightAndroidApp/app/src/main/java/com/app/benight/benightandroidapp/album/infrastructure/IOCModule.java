package com.app.benight.benightandroidapp.album.infrastructure;

import com.app.benight.benightandroidapp.album.implementations.CurrentAppData;
import com.app.benight.benightandroidapp.album.interfaces.ICurrentAppData;
import com.google.inject.Binder;
import com.google.inject.Module;

/**
 * Created by Jeirgino on 21/10/2015.
 */
public class IOCModule implements Module {
    @Override
    public void configure(Binder binder) {
        binder.bind(ICurrentAppData.class).to(CurrentAppData.class);
    }
}