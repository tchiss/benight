using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Phone.Controls;
using System.IO.IsolatedStorage;
using System.Xml.Serialization;
using System.IO;
using Parse;
//using Facebook.Client;

namespace Benight_application
{
    public partial class MainPage : PhoneApplicationPage
    {

        // Constructor
        public MainPage()
        {
            InitializeComponent();

            //    SupportedOrientations = SupportedPageOrientation.Portrait | SupportedPageOrientation.Landscape;
            //    browser.Loaded += WebBrowser_OnLoaded;

        }

        private async void buttonSignIn_Click(object sender, RoutedEventArgs e)
        {
            //TODO: delete query
            //var users = await (from user in ParseUser.Query
            //                   where user.Get<string>("username") == "totoro"
            //                   select user).FindAsync();

            //var query = ParseUser.Query;
            //IEnumerable<ParseObject> results = await query.FindAsync();

            //var queryEvent = ParseObject.GetQuery(className:"Event");
            //queryEvent.OrderByDescending("date");
            //IEnumerable<ParseObject> resultsEvent = await queryEvent.FindAsync();

            try
            {
                await ParseUser.LogInAsync(logUserName.Text, logPassword2.Password.ToString());
                // Login was successful.
                NavigationService.Navigate(new Uri("/Overview.xaml", UriKind.Relative));
            }
            catch (Exception)
            {
                // The login failed. Check the error to see why.
                MessageBox.Show("Username ou mot de passe incorect.");
            }
        }

        //private void buttonFacebook_Click(object sender, RoutedEventArgs e)
        //{
        //}

        private void buttonCreateNewAccount_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Uri("/Registration.xaml", UriKind.Relative));
        }

        private void buttonForget_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Uri("/ForgetPassword.xaml", UriKind.Relative));
        }
    }
}

