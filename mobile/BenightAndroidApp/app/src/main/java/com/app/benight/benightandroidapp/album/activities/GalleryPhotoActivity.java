package com.app.benight.benightandroidapp.album.activities;

import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Toast;

import com.app.benight.benightandroidapp.R;
import com.app.benight.benightandroidapp.album.adapters.ImageGridViewAdapter;
import com.app.benight.benightandroidapp.album.flickrutil.Flickr;
import com.app.benight.benightandroidapp.album.flickrutil.Photo;
import com.app.benight.benightandroidapp.album.flickrutil.Size;
import com.app.benight.benightandroidapp.album.interfaces.ICurrentAppData;
import com.app.benight.benightandroidapp.album.vo.ImageInfo;
import com.app.benight.benightandroidapp.constantValues.ConstantValues;
import com.app.benight.benightandroidapp.contact.ContactActivity;
import com.app.benight.benightandroidapp.homepage.HomepageActivity;
import com.app.benight.benightandroidapp.music.SoundcloudActivity;
import com.app.benight.benightandroidapp.profile.ProfileActivity;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import roboguice.activity.RoboActivity;
import roboguice.inject.InjectView;

public class GalleryPhotoActivity extends RoboActivity {
	@InjectView(R.id.albumGridView)
	private GridView gridView;
	@Inject
	ICurrentAppData currentAppData;
	private ImageGridViewAdapter imageGridViewAdapter;
	private ListView mDrawerList;
	private ArrayAdapter<String> mAdapter;

	/**
	 * Called when the activity is first created.
	 */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_gallery_photo);
		initializeComponents();
		new LoadImagesFromFlickrTask().execute();
		mDrawerList = (ListView)findViewById(R.id.navList);
		addDrawerItems();
	}

	private void initializeComponents() {
		float spacing = TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP,
				ConstantValues.GRIDVIEW_SPACING, getResources().getDisplayMetrics());
//		gridView  = (GridView)findViewById(R.id.albumGridView);
		//gridView.setNumColumns(DeviceUtil.getDeviceDimensions(GalleryPhotoActivity.this).x / ConstantValues.GRIDVIEW_COLUMN_WIDTH);
		gridView.setNumColumns(3);
		gridView.setPadding((int) spacing, (int) spacing, (int) spacing, (int) spacing);
		gridView.setVerticalSpacing((int) spacing);
		gridView.setHorizontalSpacing((int) spacing);
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
					Intent takeUserToProfile = new Intent(GalleryPhotoActivity.this, ProfileActivity.class);
					startActivity(takeUserToProfile);

				} else if (item.equals("Fil d'actualités")) {
					Intent takeUserToHomepage = new Intent(GalleryPhotoActivity.this, HomepageActivity.class);
					startActivity(takeUserToHomepage);

				} else if (item.equals("Album Photo")) {
					Intent takeUserToAlbum = new Intent(GalleryPhotoActivity.this, GalleryPhotoActivity.class);
					startActivity(takeUserToAlbum);

				} else if (item.equals("Playlist")) {
					Intent takeUserToPlaylist = new Intent(GalleryPhotoActivity.this, SoundcloudActivity.class);
					startActivity(takeUserToPlaylist);

				} else if (item.equals("Contact")) {
					Intent takeUserToContact = new Intent(GalleryPhotoActivity.this, ContactActivity.class);
					startActivity(takeUserToContact);

				} else {
					Toast.makeText(GalleryPhotoActivity.this, "You clicked on" + item, Toast.LENGTH_SHORT).show();

				}
			}
		});
	}

	class LoadImagesFromFlickrTask extends AsyncTask<String, Integer, List<ImageInfo>> {
		private ProgressDialog progressDialog;
		private Integer totalCount, currentIndex;

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			progressDialog = new ProgressDialog(GalleryPhotoActivity.this);
			progressDialog.setMessage("Loading images from Flickr. Please wait...");
			progressDialog.show();
		}

		@Override
		protected void onProgressUpdate(Integer... values) {
			super.onProgressUpdate(values);
			progressDialog.setMessage(String.format("Loading images from Flickr %s/%s. Please wait...", values[0], values[1]));
		}

		@Override
		protected List<ImageInfo> doInBackground(String... params) {
			Flickr flickr = new Flickr(ConstantValues.FLICKR_API_KEY, ConstantValues.FLICKR_FORMAT);
			List<Photo> photos = flickr.getPhotoSets().getPhotos(ConstantValues.PHOTOSET_ID);
			List<ImageInfo> result = new ArrayList<ImageInfo>();
			totalCount = photos.size();
			currentIndex = 0;
			for (Photo photo : photos) {
				currentIndex++;
				List<Size> sizes = flickr.getPhotos().getSizes(photo.getId());
				String thumbnailUrl = sizes.get(5).getSource();
				String mediumUrl = sizes.get(4).getSource();
				InputStream inputStreamThumbnail = null, inputStreamMedium = null;
				try {
					inputStreamThumbnail = new URL(thumbnailUrl).openStream();
					inputStreamMedium = new URL(mediumUrl).openStream();
				} catch (IOException e) {
					e.printStackTrace();
				}
				Bitmap bitmapThumbnail = BitmapFactory.decodeStream(inputStreamThumbnail);
				Bitmap bitmapMedium = BitmapFactory.decodeStream(inputStreamMedium);
				result.add(new ImageInfo(photo.getTitle(), bitmapThumbnail, bitmapMedium));
				publishProgress(currentIndex, totalCount);
//                if (currentIndex>3)
//                    break;
			}
			currentAppData.setImageInfos(result);
			return result;
		}

		@Override
		protected void onPostExecute(List<ImageInfo> s) {
			progressDialog.dismiss();
			imageGridViewAdapter = new ImageGridViewAdapter(GalleryPhotoActivity.this);
			gridView.setAdapter(imageGridViewAdapter);
			super.onPostExecute(s);
		}
	}
}
