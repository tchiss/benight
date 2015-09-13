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

namespace Benight_application
{
    public partial class Overview : PhoneApplicationPage
    {
        //public ParseUsersData parseUserDt;
        private ParseUsersData parseUserData;
        public ObservableCollection<string> listEvent { get; set; }


        public Overview()
        {
            DataContext = this;
            
            InitializeComponent();

            parseUserData = new ParseUsersData { userPseudo = ParseUser.CurrentUser.Username.ToString() };
            DataContext = parseUserData;

            //ListEvent = App.CustomNavigationService.data as ObservableCollection<string>;


        }

        //public class UserData
        //{
        //    public UserData()
        //    {
        //        var user = new ParseUser();
        //        string catchName = ParseUser.CurrentUser.Username;
        //        this.myUserName = new UserData() { myUserName = catchName};
        //        this.DataContext = this;
        //    }
        //    public UserData myUserName { get; set; }
        //}

        private void ButtonLogOut_Click(object sender, RoutedEventArgs e)
        {
            ParseUser.LogOut();
            NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
        }
    }
}