using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Security;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QA.ProcessRunner
{
    /// <summary>
    /// A wrapper for starting processes using ProcessStartInfo
    /// </summary>
    public class ProcessStartInfoWrapper : IProcessStartInfoWrapper
    {

        public ProcessStartInfoWrapper()
        {
            //SetupProcessStartInfo();
        }

        public void SetupProcessStartInfo()
        {
            ProcessStartInfo = new ProcessStartInfo
            {
                Arguments = Arguments,
                CreateNoWindow = CreateNoWindow,
                Domain = Domain,
                //EnvironmentVariables = EnvironmentVariables,
                ErrorDialog = ErrorDialog,
                ErrorDialogParentHandle = ErrorDialogParentHandle,
                FileName = FileName,
                LoadUserProfile = LoadUserProfile,
                Password = Password,
                RedirectStandardError = RedirectStandardError,
                RedirectStandardInput = RedirectStandardInput,
                RedirectStandardOutput = RedirectStandardOutput,
                StandardErrorEncoding = StandardErrorEncoding,
                StandardOutputEncoding = StandardOutputEncoding,
                UseShellExecute = UseShellExecute,
                UserName = UserName,
                Verb = Verb,
                WindowStyle = WindowStyle,
                WorkingDirectory = WorkingDirectory
            };
        }

        public ProcessStartInfo ProcessStartInfo { get; private set; }

        [DefaultValue("")]
        [MonitoringDescription("ProcessArguments")]
        [NotifyParentProperty(true)]
        [SettingsBindable(true)]
        [TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        public string Arguments { get; set; }

        [DefaultValue(false)]
        [MonitoringDescription("ProcessCreateNoWindow")]
        [NotifyParentProperty(true)]
        public bool CreateNoWindow { get; set; }

        [NotifyParentProperty(true)]
        public string Domain { get; set; }

        [DefaultValue("")]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Editor("System.Diagnostics.Design.StringDictionaryEditor, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        [MonitoringDescription("ProcessEnvironmentVariables")]
        [NotifyParentProperty(true)]
        public StringDictionary EnvironmentVariables
        {
            get { return ProcessStartInfo.EnvironmentVariables; }
        }

        [DefaultValue(false)]
        [MonitoringDescription("ProcessErrorDialog")]
        [NotifyParentProperty(true)]
        public bool ErrorDialog { get; set; }

        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public IntPtr ErrorDialogParentHandle { get; set; }

        [DefaultValue("")]
        [Editor("System.Diagnostics.Design.StartFileNameEditor, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        [MonitoringDescription("ProcessFileName")]
        [NotifyParentProperty(true)]
        [SettingsBindable(true)]
        [TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        public string FileName { get; set; }

        [NotifyParentProperty(true)]
        public bool LoadUserProfile { get; set; }

        public SecureString Password { get; set; }

        [DefaultValue(false)]
        [MonitoringDescription("ProcessRedirectStandardError")]
        [NotifyParentProperty(true)]
        public bool RedirectStandardError { get; set; }

        [DefaultValue(false)]
        [MonitoringDescription("ProcessRedirectStandardInput")]
        [NotifyParentProperty(true)]
        public bool RedirectStandardInput { get; set; }

        [DefaultValue(false)]
        [MonitoringDescription("ProcessRedirectStandardOutput")]
        [NotifyParentProperty(true)]
        public bool RedirectStandardOutput { get; set; }

        public Encoding StandardErrorEncoding { get; set; }

        public Encoding StandardOutputEncoding { get; set; }

        [NotifyParentProperty(true)]
        public string UserName { get; set; }

        [DefaultValue(true)]
        [MonitoringDescription("ProcessUseShellExecute")]
        [NotifyParentProperty(true)]
        public bool UseShellExecute { get; set; }

        [DefaultValue("")]
        [MonitoringDescription("ProcessVerb")]
        [NotifyParentProperty(true)]
        [TypeConverter("System.Diagnostics.Design.VerbConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        public string Verb { get; set; }

        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public string[] Verbs
        {
            get { return ProcessStartInfo.Verbs; }
        }

        [MonitoringDescription("ProcessWindowStyle")]
        [NotifyParentProperty(true)]
        public ProcessWindowStyle WindowStyle { get; set; }
 
        [DefaultValue("")]
        [Editor("System.Diagnostics.Design.WorkingDirectoryEditor, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        [MonitoringDescription("ProcessWorkingDirectory")]
        [NotifyParentProperty(true)]
        [SettingsBindable(true)]
        [TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        public string WorkingDirectory { get; set; }

        public void Dispose()
        {
            ProcessStartInfo = null; //shouldn't need to do this
        }
    }
}
