package com.app.benight.benightandroidapp;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.parse.ParseObject;
import com.parse.ParseUser;

import java.util.List;

/**
 * Created by jeirgino on 21/02/15.
 */
public class StatusAdapter extends ArrayAdapter<ParseObject> {
    protected Context mContext;
    protected List<ParseObject> mEvent;

    public StatusAdapter(Context context, final List<ParseObject> event) {
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
            holder.bookButton = (Button) convertView
                    .findViewById(R.id.bookHomepageButton);

            convertView.setTag(holder);
        } else {

            holder = (ViewHolder) convertView.getTag();

        }
        final ParseObject statusObject = mEvent.get(position);

        // title
        final String nightclubName = statusObject.getString("author");
        holder.usernameHomepage.setText(nightclubName);

        // content
        final String event = statusObject.getString("name");
        holder.eventHomepage.setText(event);
        holder.bookButton.setOnClickListener(new View.OnClickListener() {
        ParseUser currentUser = ParseUser.getCurrentUser();
            @Override
            public void onClick(View v) {
                if (onBookClick(statusObject, currentUser)) {
                    Toast.makeText(v.getContext(), "You booked " + nightclubName, Toast.LENGTH_LONG).show();
                }
            }
        });
        return convertView;
    }

    public static class ViewHolder {
        TextView usernameHomepage;
        TextView eventHomepage;
        Button   bookButton;
    }

    public boolean onBookClick(ParseObject event, ParseUser username) {
        if (username != null && event != null) {
            ParseObject reservation = new ParseObject("Reservation");
            reservation.put("Event", event);
            reservation.put("User", username);
            reservation.saveInBackground();
            return true;
        } else {
            System.out.println("Error during reservation process!");
            return false;
        }
    }
}
