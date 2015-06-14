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

namespace Benight_application
{
    public partial class ForgetPassword : PhoneApplicationPage
    {

        public ForgetPassword()
        {
            InitializeComponent();
        }

        async private void ButtonRéinitialiser_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                await ParseUser.RequestPasswordResetAsync(eMail.Text);
                MessageBox.Show("Consultez le mail de réinitialisation.");
                NavigationService.Navigate(new Uri("/MainPage.xaml", UriKind.Relative));
            }
            catch
            {
                MessageBox.Show("Adresse mail incorrecte.");
            }
        }
    }
}