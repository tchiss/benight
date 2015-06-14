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
using System.Xml;
using System.IO.IsolatedStorage;
using System.Xml.Serialization;
using System.IO;
using Parse;

namespace Benight_application
{
    public partial class Registration : PhoneApplicationPage
    {
        public Registration()
        {
            InitializeComponent();
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
        }

        //public class FacebookSettings
        //{
        //    public static string AppID = "603572813098360";
        //    public static string AppSecret = "cf3d4ef11fdf5ae3212be34b77c38ba8";
        //}

        //public class FacebookAccess
        //{
        //    public string AccessToken { get; set; }
        //    public string UserId { get; set; }
        //}

        //public class UserInfo
        //{
        //    string uname;
        //    string pwd;
        //    string email;
        //    public string Username
        //    {
        //        get { return uname; }
        //        set { uname = value; }
        //    }
        //    public string Password
        //    {
        //        get { return pwd; }
        //        set { pwd = value; }
        //    }
        //    public string EmailAdd
        //    {
        //        get { return email; }
        //        set { email = value; }
        //    }
        //}

        public void buttonSave_Click(object sender, RoutedEventArgs e)
        {
            var user = new ParseUser()
            {
                Username = "",
                Password = "",
                Email = ""
            };

            //// other fields can be set just like with ParseObject
            //user["phone"] = "415-392-0202";

            try
            {
                if (textBox1.Text != "" &&
                    textBox2.Text != "" &&
                    textBox3.Text != "")
                {
                    user.Username = textBox1.Text;
                    user.Password = textBox2.Text;
                    user.Email = textBox3.Text;

                    user.SignUpAsync();

                    NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
                    MessageBox.Show("Check your mailbox in order to confirm your account.");
                }
                else
                {
                    if (textBox1.Text == "")
                        MessageBox.Show("Please enter the username");
                    if (textBox2.Text == "")
                        MessageBox.Show("Please enter the Password");
                    if (textBox3.Text == "")
                        MessageBox.Show("Please enter the e-mail address");
                }
            }
            catch (Exception exc)
            {
                MessageBox.Show("Message erreur suivant: " + exc);
            }


            //    // Write to the Isolated Storage
            //    XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
            //    xmlWriterSettings.Indent = true;
            //    //using (IsolatedStorageFile myIsolatedStorage = IsolatedStorageFile.GetUserStoreForApplication())
            //    //{
            //    //    using (IsolatedStorageFileStream stream = myIsolatedStorage.OpenFile("People.xml", FileMode.Create))
            //    //    {
            //    //        XmlSerializer serializer = new XmlSerializer(typeof(List<UserInfo>));
            //    //        using (XmlWriter xmlWriter = XmlWriter.Create(stream, xmlWriterSettings))
            //    //        {
            //    //            serializer.Serialize(xmlWriter, GeneratePersonData());
            //    //            NavigationService.Navigate(new Uri("/congate.xaml", UriKind.Relative));
            //    //        }
            //    //    }
            //    //}
            //}
            //private List<UserInfo> GeneratePersonData()
            //{
            //    List<UserInfo> data = new List<UserInfo>();
            //    UserInfo ui = new UserInfo();
            //    ui.Username = textBox1.Text;
            //    ui.Password = textBox2.Text;
            //    ui.EmailAdd = textBox3.Text;
            //    data.Add(ui);
            //    return data;
            //}
        }

        private void buttonBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
        }
    }
}
