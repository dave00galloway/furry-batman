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
    public class ProcessStartInfoWrapper
    {
        // Summary:
        //     Gets or sets the set of command-line arguments to use when starting the application.
        //
        // Returns:
        //     File type–specific arguments that the system can associate with the application
        //     specified in the System.Diagnostics.ProcessStartInfo.FileName property. The
        //     default is an empty string (""). On Windows Vista and earlier versions of
        //     the Windows operating system, the length of the arguments added to the length
        //     of the full path to the process must be less than 2080. On Windows 7 and
        //     later versions, the length must be less than 32699.
        [DefaultValue("")]
        [MonitoringDescription("ProcessArguments")]
        [NotifyParentProperty(true)]
        [SettingsBindable(true)]
        [TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        public string Arguments { get; set; }
        //
        // Summary:
        //     Gets or sets a value indicating whether to start the process in a new window.
        //
        // Returns:
        //     true if the process should be started without creating a new window to contain
        //     it; otherwise, false. The default is false.
        [DefaultValue(false)]
        [MonitoringDescription("ProcessCreateNoWindow")]
        [NotifyParentProperty(true)]
        public bool CreateNoWindow { get; set; }
        //
        // Summary:
        //     Gets or sets a value that identifies the domain to use when starting the
        //     process.
        //
        // Returns:
        //     The Active Directory domain to use when starting the process. The domain
        //     property is primarily of interest to users within enterprise environments
        //     that use Active Directory.
        [NotifyParentProperty(true)]
        public string Domain { get; set; }
        //
        // Summary:
        //     Gets search paths for files, directories for temporary files, application-specific
        //     options, and other similar information.
        //
        // Returns:
        //     A string dictionary that provides environment variables that apply to this
        //     process and child processes. The default is null.
        [DefaultValue("")]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
        [Editor("System.Diagnostics.Design.StringDictionaryEditor, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        [MonitoringDescription("ProcessEnvironmentVariables")]
        [NotifyParentProperty(true)]
        public StringDictionary EnvironmentVariables { get; set; }

        //
        // Summary:
        //     Gets or sets a value indicating whether an error dialog box is displayed
        //     to the user if the process cannot be started.
        //
        // Returns:
        //     true if an error dialog box should be displayed on the screen if the process
        //     cannot be started; otherwise, false. The default is false.
        [DefaultValue(false)]
        [MonitoringDescription("ProcessErrorDialog")]
        [NotifyParentProperty(true)]
        public bool ErrorDialog { get; set; }
        //
        // Summary:
        //     Gets or sets the window handle to use when an error dialog box is shown for
        //     a process that cannot be started.
        //
        // Returns:
        //     A pointer to the handle of the error dialog box that results from a process
        //     start failure.
        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        IntPtr ErrorDialogParentHandle { get; set; }
        //
        // Summary:
        //     Gets or sets the application or document to start.
        //
        // Returns:
        //     The name of the application to start, or the name of a document of a file
        //     type that is associated with an application and that has a default open action
        //     available to it. The default is an empty string ("").
        [DefaultValue("")]
        [Editor("System.Diagnostics.Design.StartFileNameEditor, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        [MonitoringDescription("ProcessFileName")]
        [NotifyParentProperty(true)]
        [SettingsBindable(true)]
        [TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        public string FileName { get; set; }
        //
        // Summary:
        //     Gets or sets a value that indicates whether the Windows user profile is to
        //     be loaded from the registry.
        //
        // Returns:
        //     true if the Windows user profile should be loaded; otherwise, false. The
        //     default is false.
        [NotifyParentProperty(true)]
        public bool LoadUserProfile { get; set; }
        //
        // Summary:
        //     Gets or sets a secure string that contains the user password to use when
        //     starting the process.
        //
        // Returns:
        //     The user password to use when starting the process.
        public SecureString Password { get; set; }
        //
        // Summary:
        //     Gets or sets a value that indicates whether the error output of an application
        //     is written to the System.Diagnostics.Process.StandardError stream.
        //
        // Returns:
        //     true if error output should be written to System.Diagnostics.Process.StandardError;
        //     otherwise, false. The default is false.
        [DefaultValue(false)]
        [MonitoringDescription("ProcessRedirectStandardError")]
        [NotifyParentProperty(true)]
        public bool RedirectStandardError { get; set; }
        //
        // Summary:
        //     Gets or sets a value indicating whether the input for an application is read
        //     from the System.Diagnostics.Process.StandardInput stream.
        //
        // Returns:
        //     true if input should be read from System.Diagnostics.Process.StandardInput;
        //     otherwise, false. The default is false.
        [DefaultValue(false)]
        [MonitoringDescription("ProcessRedirectStandardInput")]
        [NotifyParentProperty(true)]
        public bool RedirectStandardInput { get; set; }
        //
        // Summary:
        //     Gets or sets a value that indicates whether the output of an application
        //     is written to the System.Diagnostics.Process.StandardOutput stream.
        //
        // Returns:
        //     true if output should be written to System.Diagnostics.Process.StandardOutput;
        //     otherwise, false. The default is false.
        [DefaultValue(false)]
        [MonitoringDescription("ProcessRedirectStandardOutput")]
        [NotifyParentProperty(true)]
        public bool RedirectStandardOutput { get; set; }
        //
        // Summary:
        //     Gets or sets the preferred encoding for error output.
        //
        // Returns:
        //     An object that represents the preferred encoding for error output. The default
        //     is null.
        public Encoding StandardErrorEncoding { get; set; }
        //
        // Summary:
        //     Gets or sets the preferred encoding for standard output.
        //
        // Returns:
        //     An object that represents the preferred encoding for standard output. The
        //     default is null.
        public Encoding StandardOutputEncoding { get; set; }
        //
        // Summary:
        //     Gets or sets the user name to be used when starting the process.
        //
        // Returns:
        //     The user name to use when starting the process.
        [NotifyParentProperty(true)]
        public string UserName { get; set; }
        //
        // Summary:
        //     Gets or sets a value indicating whether to use the operating system shell
        //     to start the process.
        //
        // Returns:
        //     true if the shell should be used when starting the process; false if the
        //     process should be created directly from the executable file. The default
        //     is true.
        [DefaultValue(true)]
        [MonitoringDescription("ProcessUseShellExecute")]
        [NotifyParentProperty(true)]
        public bool UseShellExecute { get; set; }
        //
        // Summary:
        //     Gets or sets the verb to use when opening the application or document specified
        //     by the System.Diagnostics.ProcessStartInfo.FileName property.
        //
        // Returns:
        //     The action to take with the file that the process opens. The default is an
        //     empty string (""), which signifies no action.
        [DefaultValue("")]
        [MonitoringDescription("ProcessVerb")]
        [NotifyParentProperty(true)]
        [TypeConverter("System.Diagnostics.Design.VerbConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        public string Verb { get; set; }
        //
        // Summary:
        //     Gets the set of verbs associated with the type of file specified by the System.Diagnostics.ProcessStartInfo.FileName
        //     property.
        //
        // Returns:
        //     The actions that the system can apply to the file indicated by the System.Diagnostics.ProcessStartInfo.FileName
        //     property.
        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public string[] Verbs { get; set; }

        //
        // Summary:
        //     Gets or sets the window state to use when the process is started.
        //
        // Returns:
        //     One of the enumeration values that indicates whether the process is started
        //     in a window that is maximized, minimized, normal (neither maximized nor minimized),
        //     or not visible. The default is Normal.
        //
        // Exceptions:
        //   System.ComponentModel.InvalidEnumArgumentException:
        //     The window style is not one of the System.Diagnostics.ProcessWindowStyle
        //     enumeration members.
        [MonitoringDescription("ProcessWindowStyle")]
        [NotifyParentProperty(true)]
        ProcessWindowStyle WindowStyle { get; set; }
        //
        // Summary:
        //     Gets or sets the initial directory for the process to be started.
        //
        // Returns:
        //     The fully qualified name of the directory that contains the process to be
        //     started. The default is an empty string ("").
        [DefaultValue("")]
        [Editor("System.Diagnostics.Design.WorkingDirectoryEditor, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        [MonitoringDescription("ProcessWorkingDirectory")]
        [NotifyParentProperty(true)]
        [SettingsBindable(true)]
        [TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
        public string WorkingDirectory { get; set; }
    }
}
