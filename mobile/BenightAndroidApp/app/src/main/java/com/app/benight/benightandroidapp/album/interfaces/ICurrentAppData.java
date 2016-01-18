package com.app.benight.benightandroidapp.album.interfaces;

import com.app.benight.benightandroidapp.album.vo.ImageInfo;

import java.util.List;

/**
 * Created by Jeirgino on 21/10/2015.
 */
public interface ICurrentAppData {
    List<ImageInfo> getImageInfos();

    void setImageInfos(List<ImageInfo> imageInfos);

    int getCurrentPosition();

    void setCurrentPosition(int currentPosition);
}