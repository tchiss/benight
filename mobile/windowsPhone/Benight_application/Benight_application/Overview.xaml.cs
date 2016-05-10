using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;
using System.Windows.Data;
using Microsoft.Phone.Controls;
using Microsoft.Phone.Shell;
using System.Data.Linq;
using Parse;
using System.Collections.ObjectModel;
using System.Runtime.CompilerServices;
using System.ComponentModel;

namespace Benight_application
{
    public partial class Overview : PhoneApplicationPage
    {
        private MyParseUsersData parseUserData;
        public IEnumerable<ParseObject> ResultsEvent { get; set; }
        //List<string> _events = new List<string>();
        public static string nameSelected;
        public string idSelected;

        public Overview()
        {
            DataContext = this;
            InitializeComponent();

            parseUserData = new MyParseUsersData { userPseudo = ParseUser.CurrentUser.Username.ToString() };
            DataContext = parseUserData;

            //List_Events();
            //Refresh();
            JustDoIt_Names();

            //MyEvent.Add(new Recording(TodoEv.My_EventName));
            //EventListBox.DataContext = MyEvent;

            //parseEventData = new MyParseEventData { eventName = TodoEv.My_EventName };
        }

        public async void JustDoIt_Names()
        {
            ParseQuery<ParseObject> query = ParseObject.GetQuery("Event");
            IEnumerable<ParseObject> res = await query.FindAsync();
            List<string> list = new List<string>();
            foreach (var i in res)
            {
                var sn = i.Get<string>("name");
                list.Add(sn);
            }
            EventListBox.ItemsSource = list;
        }

        public async void JustDoIt_Desc()
        {
            ParseQuery<ParseObject> query = ParseObject.GetQuery("Event");
            IEnumerable<ParseObject> res = await query.FindAsync();
            List<string> list = new List<string>();
            foreach (var i in res)
            {
                var sn = i.Get<string>("Description");
                list.Add(sn);
            }
            EventListBox.ItemsSource = list;
        }


        public class Recording
        {
            public Recording() { }
            public Recording(string cdName /*, string desc*/)
            {
                //Description = desc;
                Name = cdName;
            }
            public string Description { get; set; }
            public string Name { get; set; }
            // Override the ToString method.
            public override string ToString()
            {
                return Name;
            }
        }

        //public async void List_Events()
        //{
        //    //var queryEvent = ParseObject.GetQuery("Event");
        //    //ResultsEvent = await queryEvent.FindAsync();
        //    //EventListBox.ItemsSource = ResultsEvent;

        //    var query = from name in ParseObject.GetQuery(TodoEv.ClassName)
        //                orderby name.CreatedAt
        //                select name;
        //    ResultsEvent = await query.FindAsync();
        //    EventListBox.ItemsSource = ResultsEvent;
        //}

        //public async void Refresh()
        //{
        //    var query = from item in ParseObject.GetQuery(TodoEv.ClassName)
        //                orderby item.CreatedAt
        //                select item;
        //    //ResultsEvent = await query.FindAsync();
        //    //EventListBox.ItemsSource = ResultsEvent;
        //    try
        //    {
        //        var allItems = from item in await query.FindAsync()
        //                           //var allItems = from item in await ParseObject.GetQuery(TodoEv.ClassName).FindAsync()
        //                       select new TodoEv(item);
        //        var itemList = new ObservableCollection<TodoEv>(allItems);
        //        EventListBox.ItemsSource = itemList;
        //        EventListBox.DisplayMemberPath = "name";
        //    }
        //    catch (Exception e)
        //    {
        //        throw (e);
        //    }
        //}

        private void ButtonLogOut_Click(object sender, RoutedEventArgs e)
        {
            ParseUser.LogOut();
            NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
        }

        private void Voir_Soiree_Click(object sender, RoutedEventArgs e)
        {
            if (EventListBox.SelectedItem != null)
            {
                Tools.evName = EventListBox.SelectedItem.ToString();
                NavigationService.Navigate(new Uri("/PageEventInfo.xaml", UriKind.Relative));
            }
        }
    }
}