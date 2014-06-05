using System;
using System.Windows.Forms;

namespace Alpari.QDF.UIClient.Gui
{
    public static class UiExtensions
    {
        public static void SearchAndScrollList(this ListBox listBox, string typed)
        {
            if (SearchListBox(listBox, typed))
            {
                int index = GetItemIndex(listBox, typed);
                listBox.TopIndex = index;
                if (index >= 0)
                {
                    listBox.SetSelected(index, true);
                }
            }
        }

        public static int GetItemIndex(this ListBox listBox, string typed)
        {
            for (int i = 0; i < listBox.Items.Count; i++)
            {
                if (listBox.Items[i].ToString()
                    .Substring(0, typed.Length)
                    .Equals(typed, StringComparison.InvariantCulture))
                {
                    return i;
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