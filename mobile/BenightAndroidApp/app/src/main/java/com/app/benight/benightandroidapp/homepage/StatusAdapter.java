package com.app.benight.benightandroidapp.homepage;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.app.benight.benightandroidapp.R;
import com.app.benight.benightandroidapp.booking.BookingActivity;
import com.app.benight.benightandroidapp.booking.SimpleQrcodeGenerator;
import com.parse.ParseFile;
import com.parse.ParseImageView;
import com.parse.ParseObject;
import com.parse.ParseUser;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
            holder.eventDate = (TextView) convertView
                    .findViewById(R.id.eventDateHP);
            holder.eventClub = (TextView) convertView
                    .findViewById(R.id.eventClubHP);
            holder.flyer = (ParseImageView) convertView
                    .findViewById(R.id.flyerHP);
            holder.bookButton = (Button) convertView
                    .findViewById(R.id.bookHomepageButton);

            convertView.setTag(holder);
        } else {

            holder = (ViewHolder) convertView.getTag();

        }
        final ParseObject statusObject = mEvent.get(position);

        // title
        final String eventName = statusObject.getString("name");
        holder.usernameHomepage.setText(eventName);

        ParseFile imageFile = statusObject.getParseFile("Flyer");
        if (imageFile != null) {
            holder.flyer.setParseFile(imageFile);
            holder.flyer.loadInBackground();
        }

        // content
        final String event = statusObject.getString("theme");
        holder.eventHomepage.setText(event);

        java.util.Date d1 = new java.util.Date();
        java.sql.Date d2 = new java.sql.Date(d1.getTime());


        java.util.Date date = statusObject.getDate("date");
        DateFormat df = new SimpleDateFormat("MMM dd, yyyy, HH:mm");
        final String dateFinal = df.format(date);
        holder.eventDate.setText(dateFinal);

        final String club = statusObject.getString("author");
        holder.eventClub.setText(club);

        holder.bookButton.setOnClickListener(new View.OnClickListener() {
        ParseUser currentUser = ParseUser.getCurrentUser();
            @Override
            public void onClick(View v) {
                if (onBookClick(statusObject, currentUser)) {
                    Toast.makeText(v.getContext(), "You booked " + eventName, Toast.LENGTH_LONG).show();


                    SimpleQrcodeGenerator.main("Hola");
                    Intent takeUserBooking = new Intent(v.getContext(), BookingActivity.class);
                    //takeUserBooking.putExtra("eventExtra", statusObject);
                    takeUserBooking.putExtra("eventDate", dateFinal);
                    takeUserBooking.putExtra("eventAuthor", statusObject.getString("author"));
                    takeUserBooking.putExtra("eventLocation", statusObject.getString("location"));
                    takeUserBooking.putExtra("eventTheme", statusObject.getString("theme"));
                    takeUserBooking.putExtra("eventDetails", statusObject.getString("Description"));
                    takeUserBooking.putExtra("clubName", eventName);
                    v.getContext().startActivity(takeUserBooking);
                }
            }
        });
        return convertView;
    }

    public static class ViewHolder {
        TextView        usernameHomepage;
        ParseImageView  flyer;
        TextView        eventHomepage;
        TextView        eventDate;
        TextView        eventClub;
        Button          bookButton;
    }

    public boolean onBookClick(ParseObject event, ParseUser username) {
        if (username != null && event != null) {
            ParseObject reservation = new ParseObject("Reservation");
            reservation.put("Event", event);
            reservation.put("User", username);
            reservation.saveInBackground();
            SimpleQrcodeGenerator.main("Hola");
            return true;
        } else {
            System.out.println("Error during reservation process!");
            return false;
        }
    }
}
