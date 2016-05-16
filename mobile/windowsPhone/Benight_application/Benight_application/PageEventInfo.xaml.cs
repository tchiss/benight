using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Navigation;
using Microsoft.Phone.Controls;
using Microsoft.Phone.Shell;
using Parse;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace Benight_application
{
    public partial class PageEventInfo : PhoneApplicationPage, INotifyPropertyChanged
    {
        private MyParseUsersData parseUserData;
        private MyParseEventData parseEventData;
        public IEnumerable<ParseObject> ResultsEvent { get; set; }
        public ParseObject ev = new ParseObject("Event");
        //public string test_desc;

        public PageEventInfo()
        {
            InitializeComponent();

            this.DataContext = this;

            parseUserData = new MyParseUsersData { userPseudo = ParseUser.CurrentUser.Username.ToString() };
            parseEventData = new MyParseEventData { eventName = Tools.evName.ToString() };
            DataContext = parseEventData;

            //TextBlock listname = nomSoirée;
            ListBox listdesc = descSoirée;
            ListBox listdate = dateSoirée;

            Get_evStringBind("Description", listdesc);
            Get_evStringBind("date", dateSoirée);
        }

        public async void Get_evStringBind(string data, ListBox listb)
        {
            var ename = Tools.evName;
            var query = from item in ParseObject.GetQuery(TodoEv.ClassName)
                        where item.Get<String>("name") == ename
                        select item;
            //ResultsEvent = await query.FindAsync();
            //EventListBox.ItemsSource = ResultsEvent;
            try
            {
                var allItems = from item in await query.FindAsync()
                               select new TodoEv(item);
                var itemList = new ObservableCollection<TodoEv>(allItems);
                listb.ItemsSource = itemList;
                listb.DisplayMemberPath = data;
            }
            catch (Exception e)
            {
                throw (e);
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null) handler(this, new PropertyChangedEventArgs(propertyName));
        }

        private void retour_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Uri("/Overview.xaml", UriKind.Relative));
        }

        //async public void Get_Info(string data)
        //{
        //    var ename = Tools.evName;
        //    var query = from item in ParseObject.GetQuery(TodoEv.ClassName)
        //                where item.Get<String>("name") == ename
        //                select item;
        //    ResultsEvent = await query.FindAsync();
        //    //ev.ObjectId = await query.FindAsync();

        //    try
        //    {
        //        var allItems = from item in await query.FindAsync()
        //                       select new TodoEv(item);
        //        var itemList = new ObservableCollection<TodoEv>(allItems);
        //        ev = itemList;
        //        //ev = new ObservableCollection<TodoEv>(allItems);
        //    }
        //    catch (Exception e)
        //    {
        //        throw (e);
        //    }
        //}

        public async void List_Events()
        {
            var query = from item in ParseObject.GetQuery(TodoEv.ClassName)
                        orderby item.CreatedAt
                        select item;
            ResultsEvent = await query.FindAsync();
        }

        //public async void Get_evDesc()
        //{
        //    ParseQuery<ParseObject> query = ParseObject.GetQuery("Event");
        //    ParseObject ev = await query.GetAsync(test_desc);

        //    string desc = ev.Get<string>("Description");
        //    MessageBox.Show(desc);
        //}


        private async void inscription_Click(object sender, RoutedEventArgs e)
        {
            //try
            //{
            //Get_evDesc();
            var query = from objectId in ParseObject.GetQuery(TodoEv.ClassName)
                        where objectId.Get<string>("name") == Tools.evName
                        select objectId;
            ParseObject obj = await query.FirstAsync();
            //Tools.evId = obj.Get<string>("ObjectId").ToString();
            Tools.evId = obj.ObjectId;

            ParseObject resa = new ParseObject("Reservation");
            //resa["Event"] = obj.ObjectId;
            resa["User"] = ParseUser.CurrentUser;
            await resa.SaveAsync();

            MessageBox.Show("Réservation faite");
            NavigationService.Navigate(new Uri("/Overview.xaml", UriKind.Relative));
            //}
            //catch (Exception ex)
            //{
            //    MessageBox.Show("Erreur: " + ex);
            //}
        }
    }
}