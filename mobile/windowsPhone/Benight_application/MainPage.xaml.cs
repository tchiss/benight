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
using Facebook.Client;

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

        //public async void LoadFB()
        //{
        //    try
        //    {
        //        // Make your browser control visible
        //        ParseUser user = await ParseFacebookUtils.LogInAsync(browser, null);
        //        // Hide your browser control
        //        NavigationService.Navigate(new Uri("/WelcomeScreens/Page2.xaml", UriKind.Relative));
        //        browser.Visibility = Visibility.Collapsed;
        //    }
        //    catch
        //    {
        //        browser.Visibility = Visibility.Collapsed;
        //        //cancelled?
        //    }
        //}

        //private void SaveFilesToIsoStore()
        //{
        //    //These files must match what is included in the application package,
        //    //or BinaryStream.Dispose below will throw an exception.
        //    string[] files = {
        //    "readme.htm"
        //};

        //    IsolatedStorageFile isoStore = IsolatedStorageFile.GetUserStoreForApplication();

        //    if (false == isoStore.FileExists(files[0]))
        //    {
        //        foreach (string f in files)
        //        {
        //            StreamResourceInfo sr = Application.GetResourceStream(new Uri(f, UriKind.Relative));
        //            using (BinaryReader br = new BinaryReader(sr.Stream))
        //            {
        //                byte[] data = br.ReadBytes((int)sr.Stream.Length);
        //                SaveToIsoStore(f, data);
        //            }
        //        }
        //    }
        //}

        //private void SaveToIsoStore(string fileName, byte[] data)
        //{
        //    string strBaseDir = string.Empty;
        //    string delimStr = "/";
        //    char[] delimiter = delimStr.ToCharArray();
        //    string[] dirsPath = fileName.Split(delimiter);

        //    //Get the IsoStore.
        //    IsolatedStorageFile isoStore = IsolatedStorageFile.GetUserStoreForApplication();

        //    //Re-create the directory structure.
        //    for (int i = 0; i < dirsPath.Length - 1; i++)
        //    {
        //        strBaseDir = System.IO.Path.Combine(strBaseDir, dirsPath[i]);
        //        isoStore.CreateDirectory(strBaseDir);
        //    }

        //    //Remove the existing file.
        //    if (isoStore.FileExists(fileName))
        //    {
        //        isoStore.DeleteFile(fileName);
        //    }

        //    //Write the file.
        //    using (BinaryWriter bw = new BinaryWriter(isoStore.CreateFile(fileName)))
        //    {
        //        bw.Write(data);
        //        bw.Close();
        //    }
        //}


        //private void WebBrowser_OnLoaded(object sender, RoutedEventArgs e)
        //{
        //    SaveFilesToIsoStore();
        //    browser.Navigate(new Uri("readme.htm", UriKind.Relative));
        //}

        private async void buttonSignIn_Click(object sender, RoutedEventArgs e)
        {
            //TODO: delete query
            //var users = await (from user in ParseUser.Query
            //                   where user.Get<string>("username") == "totoro"
            //                   select user).FindAsync();

            var query = ParseUser.Query;
            IEnumerable<ParseObject> results = await query.FindAsync();

            var queryEvent = ParseObject.GetQuery("Event");
            IEnumerable<ParseObject> resultsEvent = await queryEvent.FindAsync();

            

            try
            {
                await ParseUser.LogInAsync(logUserName.Text, logPassword.Text);
                // Login was successful.
                NavigationService.Navigate(new Uri("/Overview.xaml", UriKind.Relative));
            }
            catch (Exception)
            {
                // The login failed. Check the error to see why.
                MessageBox.Show("Username ou mot de passe incorect./n");
            }
        }

        private void buttonFacebook_Click(object sender, RoutedEventArgs e)
        {
        }

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

