using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Songs_Words_Counter
{
    /// <summary>
    /// Logika interakcji dla klasy MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        Dictionary<string, int> wordsCountDictionary;

        private void CalculateBtn_Click(object sender, RoutedEventArgs e)
        {
            wordsCountDictionary = new Dictionary<string, int>();

            string input = new TextRange(WebsitesInputText.Document.ContentStart, WebsitesInputText.Document.ContentEnd).Text;
            if(input == null) { return; }

            string[] inputWebs = input.Split('\n');
            if (inputWebs.Length < 1) { return; }

            foreach(string element in inputWebs)
            {
                string[] elementSplit = element.Split('-');
                if(elementSplit.Length == 2)
                {
                    addWords(getTekstowoText(elementSplit[0], elementSplit[1]));
                }
            }

            var sortedDictionary = from entry in wordsCountDictionary orderby entry.Value descending select entry;
            //var sortedDict = sortedDictionary.ToDictionary(pair => pair.Key, pair => pair.Value);
            string outText = "";
            if ((NoNumbersCheckBox.IsChecked ?? false))
            {
                foreach (KeyValuePair<string, int> entry in sortedDictionary)
                {
                    for(int i = 0; i < entry.Value; i++)
                    {
                        outText += entry.Key + " ";
                    }
                }
                Random rnd = new Random();
                string[] tempStr2 = outText.Split(' ').OrderBy(x => rnd.Next()).ToArray();
                outText = "";
                foreach(string str in tempStr2)
                {
                    outText += str + " ";
                }
            }
            else {
                foreach (KeyValuePair<string, int> entry in sortedDictionary)
                {
                    outText += $"{entry.Key}: {entry.Value}\n";
                }
            }
            OutputTextBlock.Text = outText;

            string[] tempStr = outText.Split('\n');

            File.WriteAllLines("D:/cloud/OneDrive - Uniwersytet Jagiellonski/Documents/WordsCount.txt", tempStr);

        }

        private string getTekstowoText(string author, string song)
        {
            string ret = "";
            author = author.Trim();
            song = song.Trim();
            using (var wc = new System.Net.WebClient())
            {
                string site = $"http://www.tekstowo.pl/piosenka,{deleteSpecials(author)},{deleteSpecials(song)}.html";

                try
                {
                    byte[] retbyt = wc.DownloadData(site);
                    ret = Encoding.UTF8.GetString(retbyt);
                }
                catch(Exception ex)
                {
                    return "";
                }
            }
            ret = ret.Remove(0, ret.IndexOf("<div class=\"song-text\">") + "<div class=\"song-text\">".Length);
            ret = ret.Remove(0, ret.IndexOf("</h2><br />") + "</h2><br />".Length);
            ret = ret.Remove(ret.IndexOf("<p>"));

            ret = ret.Trim();
            ret = ret.Replace("<br/>", "");
            ret = ret.Replace("<br />", "");
            ret = deleteSpecials(ret, " ");
            ret = ret.ToLower();

            return ret;
        }

        private string deleteSpecials(string str, string chr = "_")
        {
            str = changePolish(str);
            return Regex.Replace(str, "[^a-zA-Z0-9_.]+", chr, RegexOptions.Compiled);
        }

        private string changePolish(string str)
        {
            string ret = "";

            for(int i = 0; i < str.Length; i++)
            {
                ret += changeChar(str[i]);
            }

            return ret;
        }

        private char changeChar(char character)
        {
            switch (character)
            {
                case 'ą':
                    return 'a';
                case 'ć':
                    return 'c';
                case 'ę':
                    return 'e';
                case 'ł':
                    return 'l';
                case 'ń':
                    return 'n';
                case 'ó':
                    return 'o';
                case 'ś':
                    return 's';
                case 'ż':
                case 'ź':
                    return 'z';
            }
            return character;
        }

        private void addWords(string text)
        {
            string[] textsArray = text.Split(' ');
            foreach(string element in textsArray)
            {
                if(wordsCountDictionary.ContainsKey(element))
                {
                    wordsCountDictionary[element]++;
                }
                else
                {
                    wordsCountDictionary.Add(element, 1);
                }
            }
        }
    }
}
