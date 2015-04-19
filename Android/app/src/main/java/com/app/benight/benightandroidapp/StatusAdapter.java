package com.app.benight.benightandroidapp;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.parse.ParseObject;

import java.util.List;

/**
 * Created by jeirgino on 21/02/15.
 */
public class StatusAdapter extends ArrayAdapter<ParseObject> {
    protected Context mContext;
    protected List<ParseObject> mEvent;

    public StatusAdapter(Context context, List<ParseObject> event) {
        super(context, R.layout.homepagecustomlayout, event);
        mContext = context;
        mEvent = event;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        ViewHolder holder;

        if (convertView == null) {
            convertView = LayoutInflater.from(mContext).inflate(
                    R.layout.homepagecustomlayout, null);
            holder = new ViewHolder();
            holder.usernameHomepage = (TextView) convertView
                    .findViewById(R.id.usernameHP);
            holder.eventHomepage = (TextView) convertView
                    .findViewById(R.id.eventHP);

            convertView.setTag(holder);
        } else {

            holder = (ViewHolder) convertView.getTag();

        }

        ParseObject statusObject = mEvent.get(position);

        // title
        String username = statusObject.getString("author");
        holder.usernameHomepage.setText(username);

        // content
        String event = statusObject.getString("name");
        holder.eventHomepage.setText(event);

        return convertView;
    }

    public static class ViewHolder {
        TextView usernameHomepage;
        TextView eventHomepage;

    }

}
