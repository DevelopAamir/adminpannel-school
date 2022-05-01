class Maps {
  Map<String, dynamic> student = {
    'Information': {
      'Profile_Pic': '',
      'Name': '',
      'Class': '',
      'Rollno': '',
      'Section': '',
      'Temp_Address': '',
      'Per_Address': '',
      'DOB': '',
      'Phone_No': '',
      'Parents_Name': '',
      'Parents_No': '',
      'Father_Name': '',
      'Father_No': '',
      'Mother_Name': '',
      'Mother_No': '',
    },
  };
  Map<String, dynamic> staff = {
    'Information': {
      'Profile_Pic': '',
      'Name': '',
      'Temp_Address': '',
      'Per_Address': '',
      'DOB': '',
      'Phone_No': '',
    },
    'Classes': {
      'Science': {'Title': '', 'Link': '', 'Time': ''},
      'Math': {'Title': '', 'Link': '', 'Time': ''},
    },
    'Routine': {
      'Sunday': {
        'Science': {'Time': '', 'Teacher': ''}
      },
      'Monday': {
        'Science': {'Time': '', 'Teacher': ''}
      },
      'Tuesday': {
        'Science': {'Time': '', 'Teacher': ''}
      },
      'Wednesday': {
        'Science': {'Time': '', 'Teacher': ''}
      },
      'Thursday': {
        'Science': {'Time': '', 'Teacher': ''}
      },
      'Friday': {
        'Science': {'Time': '', 'Teacher': ''}
      },
      'Saturday': {
        'Science': {'Time': '', 'Teacher': ''}
      },
    },
    'Exam_Routine': {
      'Routine_Link': '',
    },
    'Leave_Request': {
      'Reason': '',
      'Application': '',
      'Start_Date': '',
      'End_Date': '',
    },
    'Leave_History': {
      'DateTime': {
        'Reason': '',
        'Application': '',
        'Start_Date': '',
        'End_Date': '',
      }
    },
    'Notification': {
      'DateTime': {
        'Notice': '',
        'Title': '',
        'Link': '',
      }
    },
  };
  Map<String, dynamic> admin = {
    'Information': {
      'ID': '',
      'Profile_Pic': '',
      "EnrollmentNumber": '',
      'Subscription_Date': '',
      'School_Name': '',
      'Temp_Address': '',
      'Per_Address': '',
      'DOB': '',
      'Phone_No': '',
      "UserName": "",
    },
    'Staff': {
      {
        'Name': '',
        'email': '',
        'ID': '',
        'Phone_Number': '',
      },
      {
        'Name': '',
        'email': '',
        'ID': '',
        'Phone_Number': '',
      },
    },
    'Students': {
      {
        'Name': '',
        'email': '',
        'ID': '',
        'Phone_Number': '',
      },
      {
        'Name': '',
        'email': '',
        'ID': '',
        'Phone_Number': '',
      },
    },
    'Staff_Attendance': '{}',
    'Students_Attendance': '{}',
    'Exam_Routine': {
      'Routine_Link': '',
    },
    'Leave_Request': {
      'Reason': '',
      'Application': '',
      'Start_Date': '',
      'End_Date': '',
    },
    'Leave_History': {
      'DateTime': {
        'Reason': '',
        'Application': '',
        'Start_Date': '',
        'End_Date': '',
      }
    },
    'Notification': {
      'DateTime': {
        'Notice': '',
        'Title': '',
        'Link': '',
      }
    },
  };
  Map<String, Object?> attendance = {};
}
