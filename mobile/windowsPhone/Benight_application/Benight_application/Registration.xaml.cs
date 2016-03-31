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
            Password1.Password = "";
            Password2.Password = "";
            textBox3.Text = "";
        }

        public void buttonSave_Click(object sender, RoutedEventArgs e)
        {
            var user = new ParseUser()
            {
                Username = "",
                Password = "",
                Email = ""
            };

            try
            {
                if (textBox1.Text != "" &&
                    Password1.Password.ToString() != "" &&
                    Password2.Password.ToString() != "" &&
                    textBox3.Text != "")
                {
                    if (Password1.Password == Password2.Password)
                    {
                        user.Username = textBox1.Text;
                        user.Password = Password1.Password.ToString();
                        user.Email = textBox3.Text;

                        user.SignUpAsync();

                        NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
                        MessageBox.Show("Vérifiez votre boite mail, un lien de confirmation vous a été envoyé.");
                    }
                    else
                    {
                        MessageBox.Show("Le mot de passe n'est pas correctement écrit.");
                    }
                }
                else
                {
                    if (textBox1.Text == "")
                        MessageBox.Show("Veuillez saisir un Pseudo.");
                    if (Password1.Password.ToString() == "")
                        MessageBox.Show("Veuillez saisir un Mot de passe.");
                    if (textBox3.Text == "")
                        MessageBox.Show("Veuillez saisir un eMail.");
                }
            }
            catch (Exception exc)
            {
                MessageBox.Show("Message erreur suivant: " + exc);
            }
        }

        private void buttonBack_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
        }
    }
}
