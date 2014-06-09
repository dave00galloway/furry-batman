using System;
using System.Windows.Forms;

namespace Alpari.QDF.UIClient.Gui
{
    public static class UiExtensions
    {
        public static void SearchAndScrollList(this ListBox listBox, string typed)
        {
            if (listBox.SearchListBox(typed))
            {
                int index = listBox.GetItemIndex(typed);
                listBox.TopIndex = index;
                if (index >= 0)
                {
                    listBox.SetSelected(index, true);
                }
            }
        }

        public static int GetItemIndex(this ListBox listBox, string typed)
        {
            if (typed.Length > 0)
            {
                for (int i = 0; i < listBox.Items.Count; i++)
                {
                    string itemText = listBox.Items[i].ToString();
                    if (itemText.Contains(typed) && itemText
                        .Substring(0, typed.Length)
                        .Equals(typed, StringComparison.InvariantCulture))
                    {
                        return i;
                    }
                }                
            }
            return -1;
        }

        public static bool SearchListBox(this ListBox listBox, string typed)
        {
            bool found = false;
            foreach (object item in listBox.Items)
            {
                if (item.ToString().Contains(typed))
                {
                    found = true;
                    break;
                }
            }
            return found;
        }

        public static DateTime SetDateTime(DateTimePicker datePicker, DateTimePicker timePicker)
        {
            var dateTime = new DateTime(datePicker.Value.Year, datePicker.Value.Month, datePicker.Value.Day,
                timePicker.Value.Hour, timePicker.Value.Minute, timePicker.Value.Second);
            return dateTime;
        }
    }
}